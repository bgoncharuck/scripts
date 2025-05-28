#!/bin/bash

ENV_FILE=".env"
LAUNCH_FILE=".vscode/launch.json"
TEMP_FILE="${LAUNCH_FILE}.tmp"

# Store any command-line arguments as additional_args
# These will be prepended to the toolArgs from .env
ADDITIONAL_ARGS=("$@")

# Check for required files
[[ -f "$ENV_FILE" ]] || { echo "Missing .env"; exit 1; }
[[ -f "$LAUNCH_FILE" ]] || { echo "Missing launch.json"; exit 1; }

# Initialize TOOL_ARGS with any provided additional arguments
TOOL_ARGS=()
for arg in "${ADDITIONAL_ARGS[@]}"; do
  # Assuming additional args are already in the correct --define format or don't need --define
  TOOL_ARGS+=("\"$arg\"")
done

# Initialize CLI_DEFINES with any provided additional arguments (for copy-paste)
CLI_DEFINES=("${ADDITIONAL_ARGS[@]}")


# Build --define args from .env and append to TOOL_ARGS
while IFS='=' read -r key value; do
  # Skip comments, empty lines, and lines without a value
  [[ "$key" =~ ^#.*$ || -z "$key" || -z "$value" ]] && continue
  
  TOOL_ARGS+=("\"--dart-define=${key}=${value}\"")
  CLI_DEFINES+=("--dart-define=${key}=${value}")
done < "$ENV_FILE"

# Prepare the formatted toolArgs for insertion
TOOL_ARGS_FORMATTED=""
if [ ${#TOOL_ARGS[@]} -gt 0 ]; then
  TOOL_ARGS_FORMATTED="[\n"
  for i in "${!TOOL_ARGS[@]}"; do
    TOOL_ARGS_FORMATTED+="        ${TOOL_ARGS[$i]}"
    if [ $((i+1)) -lt ${#TOOL_ARGS[@]} ]; then
      TOOL_ARGS_FORMATTED+=",\n"
    else
      TOOL_ARGS_FORMATTED+="\n"
    fi
  done
  TOOL_ARGS_FORMATTED+="      ]"
else
  TOOL_ARGS_FORMATTED="[]" # Handle case where there are no arguments at all
fi


# Rewrite launch.json with awk
awk -v toolargs_formatted="$TOOL_ARGS_FORMATTED" '
  BEGIN { in_toolargs = 0 }
  {
    # If we find the "toolArgs": line
    if ($0 ~ /"toolArgs"[[:space:]]*:/) {
      print "      \"toolArgs\": " toolargs_formatted ",";
      in_toolargs = 1; # Set flag to indicate we are inside toolArgs block
      next; # Skip printing the current line
    }

    # If we are inside the toolArgs block, skip lines until we find the closing bracket
    if (in_toolargs) {
      # Match closing ']' potentially followed by ',' and optional whitespace
      if ($0 ~ /\][[:space:]]*,?[[:space:]]*$/) {
        in_toolargs = 0; # Reset flag
      }
      next; # Skip printing lines within the old toolArgs block
    }

    print; # Print all other lines
  }
' "$LAUNCH_FILE" > "$TEMP_FILE" && mv "$TEMP_FILE" "$LAUNCH_FILE"

echo "Updated launch.json with defines from .env and additional arguments"

# Print CLI version of define flags
echo ""
echo "Copy-paste into flutter build/run:"
echo "${CLI_DEFINES[*]}"
