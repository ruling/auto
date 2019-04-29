#!/bin/bash

export JOBS=`nproc`;

if [[ ${1} = "--auto" ]]; then
  export PARAM=-y
  export SKIP=1
else
  export PARAM=""
  export SKIP=0
fi

echo " 安卓开发环境自动配置脚本 "
echo "作者：Ruling."

clear

echo
echo "进行系统更新"
echo
sudo apt-get update

clear

echo
echo "进入下载目录"
echo
if [ ! -d ~/Downloads ]; then
  mkdir -p ~/Downloads
fi
cd ~/Downloads

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo
echo "安装 Python!"
echo
sudo apt-get install build-essential gcc $PARAM
wget http://www.python.org/ftp/python/3.3.2/Python-3.3.2.tgz
tar -xvzf Python-3.3.2.tgz
cd ~/Downloads/Python-3.3.2
./configure --prefix=/usr/local/python3.3
make -j${JOBS}
sudo make install -j${JOBS}
sudo ln -s /usr/local/python3.3/bin/python /usr/bin/python3.3
cd ~/Downloads

if [ ${SKIP} = 1 ]; then
  echo "无人值守安装. 按任意键暂停..."
else
  read -p "按回车键继续..."
fi

clear

echo
echo "安装资源包!"
echo
sudo apt-get update
sudo apt-get apt-get install git ccache automake lzop bison gperf build-essential zip curl zlib1g-dev zlib1g-dev:i386 g++-multilib python-networkx libxml2-utils bzip2 libbz2-dev libbz2-1.0 libghc-bzlib-dev squashfs-tools pngcrush schedtool dpkg-dev liblz4-tool make optipng maven bc pngquant imagemagick yasm libssl-dev
echo “export USE_CCACHE=1” >> ~/.bashrc

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo
echo "安装 JDK 8!"
echo
sudo apt-get install openjdk-8-jdk
java -version
cd ~/

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo
echo "将终端快捷方式加入右键菜单!"
echo
sudo apt-get install nautilus-open-terminal $PARAM
nautilus -q

echo
echo "安装 Repo"
echo
if [ ! -d ~/bin ]; then
  mkdir -p ~/bin
fi

curl https://storage.googleapis.com/git-repo-downloads/repo 20 > ~/bin/repo
chmod a+x ~/bin/repo

echo “export PATH=~/bin:$PATH” >> ~/.bashrc

echo
echo "安装 ADB 驱动!"
echo
wget http://www.broodplank.net/51-android.rules
sudo mv -f 51-android.rules /etc/udev/rules.d/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules

echo
echo "下载和配置 Android SDK!!"
echo "请确保 unzip 已经安装"
echo
sudo apt-get install unzip $PARAM

if [ `getconf LONG_BIT` = "64" ]
then
echo
echo "正在下载 Linux 64位 系统的Android SDK"
        wget http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20140702.zip
echo "下载完成!!"
echo "展开文件"
	mkdir ~/adt-bundle
        mv adt-bundle-linux-x86_64-20140702.zip ~/adt-bundle/adt_x64.zip
        cd ~/adt-bundle
        unzip adt_x64.zip
        mv -f adt-bundle-linux-x86_64-20140702/* .
echo "正在配置"
        echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
        echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile
echo "完成!!"
else

echo
echo "正在下载 Linux 32位 系统的Android SDK"
        wget http://dl.google.com/android/adt/adt-bundle-linux-x86-20140702.zip
echo "下载完成!!"
echo "展开文件"
        mkdir ~/adt-bundle
        mv adt-bundle-linux-x86-20140702.zip ~/adt-bundle/adt_x86.zip
        cd ~/adt-bundle
        unzip adt_x86.zip
        mv -f adt-bundle-linux-x86_64-20140702/* .
echo "正在配置"
        echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
        echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile
echo "完成!!"
fi

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo
echo "清除临时文件..."
echo
rm -Rf ~/adt-bundle/adt-bundle-linux-x86_64-20140702
rm -Rf ~/adt-bundle/adt-bundle-linux-x86-20140702
rm -f ~/adt-bundle/adt_x64.zip
rm -f ~/adt-bundle/adt_x86.zip
rm -f ~/Downloads/master.zip

clear

echo
echo "完成!"
echo
echo "感谢使用本脚本!"
echo
read -p "按回车键退出..."
exit
