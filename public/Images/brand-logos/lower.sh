convert_to_lowercase(){
f=0
find $input -depth -name '*[A-Z]*.jpg' | while read f;
do
mv -v $f `echo $f | tr '[A-Z]' '[a-z]'`;
done
}


convert_to_lowercase
