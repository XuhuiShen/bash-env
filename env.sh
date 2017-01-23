#!/bin/bash
set -u
set -e
set -o pipefail

base_dir=$(readlink -f $(dirname ${BASH_SOURCE[0]})/)

example_dir=('$base_dir/../' \
	               '$base_dir/../')

if [[ -e $base_dir/.dir_flag ]]; then
	  i=0;
else
	  i=1;
fi

function redefine()
{
    local array_name=$1
    local i=$2
	  eval "local val=\${$array_name[$i]}"
	  if [[ "$val" == "" ]]; then
		    eval "unset $array_name"
	  else
		    eval "eval $array_name=\${$array_name[$i]}"
	  fi
}

for var_name in example_dir \ # if you need a newline you will need \.
	              ; do
    redefine $var_name $i
done
