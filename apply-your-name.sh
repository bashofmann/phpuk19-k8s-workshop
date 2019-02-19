#!/usr/bin/env bash

echo "Enter a unique name for your namespace"

read namespaceName

find . -name '*.yaml' -exec sed -i '' -e "s/<YOURNAME>/${namespaceName}/g" {} \;
find . -name '*.md' -exec sed -i ''  -e "s/<YOURNAME>/${namespaceName}/g" {} \;
