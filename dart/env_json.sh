awk -F= '!/^#/ && NF==2 { printf "\"%s\": \"%s\",\n", $1, $2 }' .env \
| sed '$s/,$//' \
| awk 'BEGIN { print "{" } { print } END { print "}" }' > env.json
