#!/bin/bash

export JOBS=`nproc`;

if [[ ${1} = "--auto" ]]; then
  export PARAM=-y
  export SKIP=1
else
  export PARAM=""
  export SKIP=0
fi

clear
echo "安卓编译环境自动配置脚本"
echo "作者：Ruling."

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

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
wget http://www.python.org/ftp/python/2.5.6/Python-2.5.6.tgz
tar -xvzf Python-2.5.6.tgz
cd ~/Downloads/Python-2.5.6
./configure --prefix=/usr/local/python2.5
make -j${JOBS}
sudo make install -j${JOBS}
sudo ln -s /usr/local/python2.5/bin/python /usr/bin/python2.5
cd ~/Downloads

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo
echo "安装 CCache!"
echo
wget http://www.samba.org/ftp/ccache/ccache-3.1.9.tar.gz
tar -xvzf ccache-3.1.9.tar.gz
cd ~/Downloads/ccache-3.1.9
./configure
make -j${JOBS}
sudo make install -j${JOBS}
echo "export USE_CCACHE=1" >> ~/.bashrc
if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo
echo "安装 JDK 6!"
echo
wget  --no-check-certificate --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin"
chmod +x jdk-6u45-linux-x64.bin
sudo ./jdk-6u45-linux-x64.bin
sudo mv jdk1.6.0_45 /usr/lib/jvm/jdk1.6.0_45
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_45/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_45/bin/javac 1
sudo update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/jdk1.6.0_45/bin/javaws 1
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.6.0_45/bin/jar 1
sudo update-alternatives --install /usr/bin/javadoc javadoc /usr/lib/jvm/jdk1.6.0_45/bin/javadoc 1
java -version

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo
echo "安装 GNU Make!"
echo
wget http://ftp.gnu.org/gnu/make/make-3.81.tar.gz
tar -xvzf make-3.81.tar.gz
cd ~/Downloads/make-3.81
./configure
sudo make install -j${JOBS}
cd ~/

if [ ${SKIP} = 1 ]; then
echo "无人值守安装. 按任意键暂停..."
else
read -p "按回车键继续..."
fi

clear

echo
echo "安装其他要求资源包!"
echo
sudo apt-get install git-core gnupg flex bison gperf build-essential \
zip curl zlib1g-dev libc6-dev libncurses5-dev x11proto-core-dev \
libx11-dev libreadline6-dev libgl1-mesa-dev tofrodos python-markdown \
libxml2-utils xsltproc pngcrush gcc-multilib lib32z1 schedtool \
libqt4-dev lib32stdc++6 libx11-dev:i386 g++-multilib lib32z1-dev \
lib32ncurses5-dev ia32-libs mingw32 lib32z-dev $PARAM

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


export LANGUAGE=`echo $LANG | grep CN`;

if [[ $LANGUAGE != "" ]]; then
    echo
echo "安装 Smarthosts!"
echo
sudo wget https://sourceforge.net/projects/androidbuild/files/hosts -O /etc/hosts
sudo chmod a+x /etc/hosts
fi;

echo
echo "安装 GIT!"
echo
sudo apt-get install git $PARAM

echo
echo "安装 Repo"
echo
if [ ! -d ~/bin ]; then
  mkdir -p ~/bin
fi
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

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
        wget http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20131030.zip
echo "下载完成!!"
echo "展开文件"
        mkdir ~/adt-bundle
        mv adt-bundle-linux-x86_64-20131030.zip ~/adt-bundle/adt_x64.zip
        cd ~/adt-bundle
        unzip adt_x64.zip
        mv -f adt-bundle-linux-x86_64-20131030/* .
echo "正在配置"
        echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
        echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile
        echo "创建桌面快捷方式"
        ln -s ~/adt-bundle/eclipse/eclipse ~/Desktop/Eclipse
        ln -s ~/adt-bundle/sdk/tools/android ~/Desktop/SDK-Manager
echo "完成!!"
else
echo
echo "正在下载 Linux 32位 系统的Android SDK"
        wget http://dl.google.com/android/adt/adt-bundle-linux-x86-20131030.zip
echo "下载完成!!"
echo "展开文件"
        mkdir ~/adt-bundle
        mv adt-bundle-linux-x86-20131030.zip ~/adt-bundle/adt_x86.zip
        cd ~/adt-bundle
        unzip adt_x86.zip
        mv -f adt-bundle-linux-x86_64-20131030/* .
echo "正在配置"
        echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
        echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile
        echo "创建桌面快捷方式"
        ln -s ~/adt-bundle/eclipse/eclipse ~/Desktop/Eclipse
        ln -s ~/adt-bundle/sdk/tools/android ~/Desktop/SDK-Manager
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
rm -f ~/Downloads/Python-2.5.6.tgz
sudo chmod 777 ~/Downloads/Python-2.5.6/Lib/plat-linux3
rm -Rf ~/Downloads/Python-2.5.6
rm -f ~/Downloads/make-3.81.tar.gz
rm -Rf ~/Downloads/make-3.81
rm -f ~/Downloads/jdk-6u45-linux-x64.bin
rm -f ~/Downloads/ccache-3.1.9.tar.gz
rm -Rf ~/Downloads/ccache-3.1.9
rm -Rf ~/adt-bundle/adt-bundle-linux-x86_64-20131030
rm -Rf ~/adt-bundle/adt-bundle-linux-x86-20131030
rm -f ~/adt-bundle/adt_x64.zip
rm -f ~/adt-bundle/adt_x86.zip

echo
echo "完成!"
echo
echo "感谢使用本脚本!"
echo "现在，享受一下编译 roms/kernels 吧:)"
read -p "按回车键退出..."
exit
