# Domain adaptation dataset download with command line (GTA, SYNTHIA, Cityscaptes)
Command line scripts to download domain adaptation dataset (both classification and segmentation), which could be used for model training on servers without GUI.
* [Segmentation dataset](segmentation-dataset)
  * [GTA](#gta)
  * [SYNTHIA](#synthia)
  * [Cityscapes](#cityscapes)
* [Classification dataset](classification-dataset)
  * MNIST
  * ImageCLEF
  * Office-31
  * Office-Home

# Segmentation dataset
You may use the [bash script](https://github.com/JiahongChen/da-dataset/blob/main/scripts/segmentation.sh) to download the data directly or follow the detailed explainations below.

## GTA
GTA dataset contains 14966 synthetic images with pixel-wise annotation, it's resolution is 1914*1052. This dataset can be downloaded easily from [TU Darmstadt's server](https://download.visinf.tu-darmstadt.de/data/from_games/) as no registration is needed.
```
cd path-to-your-data-folder/
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
```
## SYNTHIA
SYNTHIA_RAND_CITYSCAPES dataset contains 9400 synthetic images with semantic annotation, it's resolution is 1280*760. This dataset can be downloaded from their [official website](https://synthia-dataset.net/downloads/) directly, but we would need to unrar the compressed file which required additional package in Unix systems.

To download SYNTHIA_RAND_CITYSCAPES dataset:
```
cd path-to-your-data-folder/
mkdir synthia
cd synthia
wget --no-check-certificate http://synthia-dataset.cvc.uab.cat/SYNTHIA_RAND_CITYSCAPES.rar
```


For Ubuntu, we may install the unrar package directly:
```
sudo apt-get install unrar
```

For other Unix systems that does not support ```apt-get```, we may download unrar's ```rpm``` package and install it via ```yum```:
```
wget https://rpmfind.net/linux/dag/redhat/el6/en/x86_64/dag/RPMS/unrar-5.0.3-1.el6.rf.x86_64.rpm
sudo yum install unrar-5.0.3-1.el6.rf.x86_64.rpm
```

Then we can unpack SYNTHIA's rar compressed file with:
```
unrar x SYNTHIA_RAND_CITYSCAPES.rar
```

However, we may find that the uncompressed files are not put into folders as they might be generated on Windows, which uses backslashes ```\``` as folder speratore. We may change the backslashes to forward slashes by following [this post](https://superuser.com/questions/1382839/zip-files-expand-with-backslashes-on-linux-no-subdirectories):
```
for file in *\\*
do 
  target="${file//\\//}"
  mkdir -p "${target%/*}"
  mv -v "$file" "$target"
done
```

## Cityscapes
Cityscapes dataset contains 5000 annotated real-world traffic images. It's [official website](https://www.cityscapes-dataset.com/downloads/) requries registeration before download. Therefore, it requires extra steps to save login information before download. Thanks to [this repo](https://github.com/cemsaz/city-scapes-script) and [this post](https://stackoverflow.com/questions/1324421/how-to-get-past-the-login-page-with-wget), we may download this dataset with commandline scripts:
```
# Log in and save the session cookie.
cd path-to-your-data-folder/
mkdir cityscapes
cd cityscapes
wget --save-cookies cookies.txt \
     --keep-session-cookies \
     --post-data 'username='${username}'&password='${password}'&submit=Login' \
     --delete-after \
     https://www.cityscapes-dataset.com/login/

# Download data with the saved log in information
wget --load-cookies cookies.txt \
     https://www.cityscapes-dataset.com/file-handling/?packageID=3
     
# unzip compress file
unzip leftImg8bit_trainvaltest.zip
```

# Classification dataset
Todo
