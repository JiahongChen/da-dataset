#!/bin/bash

# help function adopted from https://unix.stackexchange.com/questions/31414/how-can-i-pass-a-command-line-argument-into-a-shell-script
help()
{
   echo "Usage: $0 -p [path-to-your-data-folder]"
   echo -e "\t-p: Path to your data folder"
   echo -e "\t-u: Your Cityscape username"
   exit 1
}

while getopts "p:u:" opt
do
   case "$opt" in
      p ) path="$OPTARG" ;;
      u ) username="$OPTARG" ;;
      ? ) help ;;
   esac
done


# Print help function when parameters are empty
if [ -z "$path" ]
then
   echo "Path to your data folder is empty";
   help
fi

if [ -z "$username" ]
then
   echo "Your Cityscape username is empty";
   help
fi

read -s -p "Your Cityscape password: " password
# echo "$path"
# echo "$username"
# echo "$password"

########### GTA dataset ###########
cd "$path"
mkdir gta
cd gta
for idx in 01 02 03 04 05 06 07 08 09 10
do
	wget --no-check-certificate https://download.visinf.tu-darmstadt.de/data/from_games/data/${idx}_images.zip
	wget --no-check-certificate https://download.visinf.tu-darmstadt.de/data/from_games/data/${idx}_labels.zip
done
for idx in 01 02 03 04 05 06 07 08 09 10
do
	unzip ${idx}_images.zip
	unzip ${idx}_labels.zip
done

########### SYNTHIA ###########
cd "$path"
mkdir synthia
cd synthia
wget --no-check-certificate http://synthia-dataset.cvc.uab.cat/SYNTHIA_RAND_CITYSCAPES.rar

wget https://rpmfind.net/linux/dag/redhat/el6/en/x86_64/dag/RPMS/unrar-5.0.3-1.el6.rf.x86_64.rpm
sudo yum install unrar-5.0.3-1.el6.rf.x86_64.rpm

unrar x SYNTHIA_RAND_CITYSCAPES.rar

for file in *\\*
do 
  target="${file//\\//}"
  mkdir -p "${target%/*}"
  mv -v "$file" "$target"
done

########### Cityscapes ###########
cd "$path"
mkdir cityscapes
cd cityscapes

wget --save-cookies cookies.txt \
     --keep-session-cookies \
     --post-data 'username='${username}'&password='${password}'&submit=Login' \
     --delete-after \
     https://www.cityscapes-dataset.com/login/
password = ''

wget --load-cookies cookies.txt \
     https://www.cityscapes-dataset.com/file-handling/?packageID=3
     
unzip leftImg8bit_trainvaltest.zip
