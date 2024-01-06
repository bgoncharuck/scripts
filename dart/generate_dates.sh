#!/bin/bash
for i in $(seq 1960 2030);
do
    dart main.dart $i >> ~/generated.txt
done
