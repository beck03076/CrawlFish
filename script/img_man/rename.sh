#!/bin/bash
# convert all file names and directory names in a given path to lowercase wherever applicable

if test $# -lt 1 ; then
echo please provide 1 inputs: path ;
exit 0;
fi

input=$1
convert_to_lowercase(){
f=0
find $input -depth -name '*[A-Z]*.jpg' | while read f;
do
mv -v $f `echo $f | tr '[A-Z]' '[a-z]'`;
done
}

# Main
convert_to_lowercase
