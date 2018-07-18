mkdir downgrade_packages
cd downgrade_packages

sudo aptitude install wget 

wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.64.tar.gz 
tar xf autoconf*
cd autoconf-2.64
sh configure --prefix /usr/local
sudo make install
cd ..

wget http://ftp.gnu.org/gnu/automake/automake-1.11.1.tar.gz
tar xf automake-1.11.1.tar.gz
cd automake-1.11.1/
./configure
sudo make install

wget http://ftp.gnu.org/gnu/patch/patch-2.5.4.tar.gz
tar xf patch-2.5.4.tar.gz
cd patch-2.5.4/
sh configure --prefix /usr/local
sudo cp patch /usr/bin/
cd ..

wget http://archive.apache.org/dist/ant/binaries/apache-ant-1.8.4-bin.tar.gz
tar xvfvz apache-ant-1.8.4-bin.tar.gz
sudo mv apache-ant-1.8.4/ /opt/ant
sudo sh -c 'echo ANT_HOME=/opt/ant >> /etc/environment'
sudo  rm /usr/bin/ant 
sudo ln -s /opt/ant/bin/ant /usr/bin/ant

wget http://ftp.gnu.org/gnu/libtool/libtool-2.2.10.tar.gz
tar xf libtool-2.2.10.tar.gz
cd libtool-2.2.10/
./configure
sudo make install
cd ..

wget http://ftp.gnu.org/gnu/texinfo/texinfo-4.13.tar.gz
gzip -dc < texinfo-4.13.tar.gz | tar -xf -
cd texinfo-4.13
./configure
make
sudo rm /usr/bin/makeinfo
sudo cp makeinfo/makeinfo /usr/bin/
cd ..

sudo apt-get install aptitude
sudo apt-get install device-tree-compiler
sudo aptitude install ant=1.8.4
sudo aptitude install autoconf=2.64
sudo aptitude install make=3.81
sudo aptitude install patch=2.5.4
sudo aptitude install sharutils=4.14
sudo aptitude install g++=4.8.4
sudo aptitude install bison=3.0.2
sudo aptitude install gettext=0.18.3
sudo aptitude install libtool=2.2.10
sudo aptitude install texinfo=4.13
#sudo aptitude install exuberant-ctags
#sudo aptitude install cscope
sudo aptitude install flex
sudo aptitude install gawk 
#sudo aptitude install zlib-devel
sudo aptitude install zlib1g-dev
#sudo aptitude install ncurses-devel
sudo aptitude install libncurses5-dev
#sudo aptitude install openssl-devel
sudo aptitude install libssl-dev
sudo aptitude install openssl
sudo aptitude install cmake

ant -v
autoconf -V
automake --version
make -v
shar -v
patch -v
libtool --version
makeinfo -version

sudo rm -f /bin/sh
sudo ln -s -T bash /bin/sh
ls -l /bin/sh
