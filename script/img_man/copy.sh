#!/bin/bash -x

if test $# -lt 1 ; then
echo please provide 1 inputs: your path ;
exit 0;
fi

input=$1

# This function will copy files from brand/pdt/color/*.jpg to brand/*.jpg

copy_files(){
find $input -mindepth 3 -maxdepth 3 -type f -name '*.jpg' | while read x;
do
y=`echo $x | rev | awk -F \/ '{print $3}' | rev`;
z="$input/$y";
cp $x $z;
rm -rf $x
done
}

#Main
copy_files
