#!/bin/bash -x

if test $# -lt 3 ; then
echo please provide 3 inputs: path char_to_be_replaced char ;
exit 0;
fi

path=$1
e=$2
g=$3
find $path -depth -name "*${e}*" | while IFS=' ' read -r fname
do
mv -i "${fname}" "$(dirname "${fname}")/$(basename "${fname}"|tr "${e}" "${g}")"
done
