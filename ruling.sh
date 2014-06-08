#!/bin/bash

export JOBS=`nproc`;

if [[ ${1} = "--auto" ]]; then
  export PARAM=-y
  export SKIP=1
else
  export PARAM=""
  export SKIP=0
fi

cd ~/
clear

echo
echo "安装 JDK 6!"
echo
chmod +x jdk-6u45-linux-x64.bin
sudo ./jdk-6u45-linux-x64.bin
sudo mkdir /usr/lib/jvm
sudo mv jdk1.6.0_45 /usr/lib/jvm/
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_45/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_45/bin/javac 1
sudo update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/jdk1.6.0_45/bin/javaws 1
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.6.0_45/bin/jar 1
sudo update-alternatives --install /usr/bin/javadoc javadoc /usr/lib/jvm/jdk1.6.0_45/bin/javadoc 1
java -version

cd ~/

echo
echo "安装 必要资源包!"
echo
        sudo apt-get install git-core gnupg flex bison gperf build-essential \
        zip curl zlib1g-dev libc6-dev libncurses5-dev x11proto-core-dev \
        libx11-dev libreadline6-dev libgl1-mesa-dev tofrodos python-markdown \
        libxml2-utils xsltproc pngcrush gcc-multilib lib32z1 schedtool \
        libqt4-gui libqt4-core libqt4-dev lib32stdc++6 libx11-dev:i386 \
        pngcrush schedtool g++-multilib lib32z1-dev lib32ncurses5-dev \
        ia32-libs mingw32 lib32z-dev
echo
echo "将终端快捷方式加入右键菜单!"
echo
sudo apt-get install nautilus-open-terminal
nautilus -q

echo
echo "安装 GIT!"
echo
sudo apt-get install git

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
echo "安装adt-bundle!"
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
rm -f ~/jdk-6u45-linux-x64.bin
rm -Rf ~/adt-bundle/adt-bundle-linux-x86_64-20131030
rm -f ~/adt-bundle/adt_x64.zip

echo
echo "完成!"
echo
echo "感谢使用本脚本!"
echo
read -p "按回车键退出..."
exit
