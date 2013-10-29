#!/bin/bash

# This script will convert/resize all *.jpg images from one directory down the given folder and write them to size_images.jpg[in the given folder].
# It will finally copy the original image to o_imgname.jpg
# To execute the script,
# Inputs: path where product of the image exists[ex:mobile_images] and size in "sizexsize" format
# for example: ./converter.sh ~/mobile_images 32x34


# Additional info
# The script will only pick *.jpg files that starts with character and ignore the ones, that start with "o_" just to ensure already resized images or existing original images are not altered

if test $# -lt 2 ; then
echo please provide 2 inputs: your path and size;
exit 0;
fi

input=$1
shift
ignore_pattern='o_*.jpg'
find $input -mindepth 2 -maxdepth 2 -type f -name '[a-z|A-Z]*.jpg' -not -name $ignore_pattern | while read images;
do
echo $images;
for size1 in $@; do
img_name=`echo $images | rev | awk -F \/ '{print $1}' | rev`;
img_dir=`echo $images | rev | awk -F \/ '{print $2}' | rev`;
pdt_img=`echo $images | rev | awk -F \/ '{print $1"/"$2}' | rev`;
source_img="$input/$pdt_img";
orig_name="o_$img_name";
new_name="$size1"_"$img_name";
dest_img="$input/$img_dir/$new_name";
orig_img="$input/$img_dir/$orig_name";
convert -resize $size1 -background white -gravity center -extent $size1 -format jpg -quality 75 $source_img $dest_img;
echo "*** $source_img is converted to $dest_img ***";
done
mv $source_img $orig_img;
echo "*** $source_img is now renamed to $orig_img ***";
done
