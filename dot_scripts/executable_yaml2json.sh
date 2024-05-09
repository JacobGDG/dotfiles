#!/bin/bash

# Purpose: convert yaml to json for jq parsing

# check if ruby installed, if so use ruby to convert
if command -v ruby &> /dev/null; then
  ruby -ryaml -rjson -e 'puts JSON.pretty_generate(YAML.load(ARGF))'
  exit 0
fi

# same for python
if command -v python &> /dev/null; then
  python -c 'import sys, yaml, json; json.dump(yaml.safe_load(sys.stdin), sys.stdout, indent=4)' 
  exit 0
fi

echo "No ruby or python found. Exiting..."
exit 1

