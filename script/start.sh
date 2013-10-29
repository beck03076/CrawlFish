a=$2
b=$1
read line
if [ "$a"="SERVER" ]; then
~/.bashrc
cd $b
pwd
bash -c 'rake ts:start'
rails s
elif [ "$a"="CONSOLE" ]; then
cd $b
rails c
else echo "Please try again from given options only."
fi
