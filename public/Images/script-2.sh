!/bin/bash -x

# REMEMBER THIS SCRIPT ASSUMES YOUR BRAND NAME WILL ALWAYS BE UNDER MOBILE_IMAGES.
# FOR EX: ./mobile_images/nokia/nokia_lumia/black/*.jpg - this script is only concerned about whats under 4 levels down the mobile_images dir.
# it will ignore all others like ./mobile_images/nokia/dup/nokia_lumia/blue/*.jpg or ./mobile_jpgs/nokia/*.jpg
# input is your path, ex:/home/users/mobile_images
# to execute the script, ./copy.sh /home/users/mobile_images

if test $# -lt 1 ; then
echo please provide 1 inputs: your path ;
exit 0;
fi

input=$1

# This function will copy files from brand/pdt/color/*.jpg to brand/*.jpg

copy_files(){
find $input -type f -name '*.jpg' -mindepth 4 -maxdepth 4 | while read x;
do
y=`echo $x | rev | awk -F \/ '{print $4}' | rev`;

z="$input/$y";
cp $x $z;
done
}

# convert all file names and directory names in a given path to lowercase wherever applicable
convert_to_lowercase(){
f=0
find $input -depth -name '*[A-Z]*.jpg' | while read f;
do
mv -v $f `echo $f | tr '[A-Z]' '[a-z]'`;
done
}


# Main starts here
copy_files
convert_to_lowercase
