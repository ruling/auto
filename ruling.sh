#!/bin/bash

export JOBS=`nproc`;

if [[ ${1} = "--auto" ]]; then
  export PARAM=-y
  export SKIP=1
else
  export PARAM=""
  export SKIP=0
fi

echo
echo "安装 JDK 6!"
echo
sudo apt-get update
sudo apt-get install openjdk-7-jdk
sudo update-alternatives --config java
sudo update-alternatives --config javac
cd ~/

echo
echo "安装 必要资源包!"
echo
sudo apt-get install git gnupg flex bison gperf build-essential \
zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev \
libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 \
libgl1-mesa-dev g++-multilib mingw32 tofrodos pngcrusher \
python-markdown libxml2-utils xsltproc zlib1g-dev:i386
  
echo
echo "将终端快捷方式加入右键菜单!"
echo
sudo apt-get install nautilus-open-terminal
nautilus -q

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

echo "安装 Repo"
echo
if [ ! -d ~/bin ]; then
  mkdir -p ~/bin
fi
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo "安装 ADB 驱动!"
echo
wget http://www.broodplank.net/51-android.rules
sudo mv -f 51-android.rules /etc/udev/rules.d/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules
	mkdir ~/adt-bundle
        mv adt-bundle-linux-x86_64-20131030.zip ~/adt-bundle/adt_x64.zip
        cd ~/adt-bundle
        unzip adt_x64.zip
        mv -f adt-bundle-linux-x86_64-20131030/* .
echo "正在配置"
        echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
        echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile
echo "完成!!"

clear

echo
echo "清除临时文件..."
echo
rm -Rf ~/adt-bundle/adt-bundle-linux-x86_64-20131030
rm -f ~/adt-bundle/adt_x64.zip

echo
echo "完成!"
echo
echo "感谢使用本脚本!"
echo
read -p "按回车键退出..."
exit
