#!/bin/bash

#export GIT_SSL_NO_VERIFY=1
##################################### USE CHANGE HAND ##############################
#FW_VERSION_C="020242"
#FW_VERSION_L="020243"
DIR_C="$1"
version_cc="$2"
DIR_AK_C="$3"
version_ak="$4"
MODEL="$5"
CC_branch="$6"
AK_BRANCH="$7"
number_RC="$8"
###################################################################################

RC_folder=FW_"$MODEL"_CC"$DIR_C"_AK"$DIR_AK_C"_RC_0$number_RC
RC_folder_003=FW_003_CC"$DIR_C"_AK"$DIR_AK_C"_RC_$number_RC
gcc_cc=/usr/local

DIR_L=0`expr $DIR_C + 000001`
DIR_AK_L=0`expr $DIR_AK_C + 000001`


if [ $number_RC -ge "10" ];then
number_RC1=$number_RC
else
number_RC1=0$number_RC
fi

DIR_CC32_TAG=cc3200_module
DIR_AK_TAG=anyka_baterycam
VAR_CC32=CC_"$MODEL"_"$version_cc"_RC"$number_RC1"
VAR_AK=AK_"$MODEL"_"$version_ak"_RC"$number_RC1"



folder_release="$MODEL"_CC_"$DIR_C"
DIR_CC_OLD=0`expr $DIR_C - 000002`
DIR_AK_OLD=0`expr $DIR_AK_C - 000002`
folder_release_OLD="$MODEL"_CC_"$DIR_CC_OLD"
#MODEL_I_CODE="002"
folder_all=FW_"$MODEL"_CC"$DIR_C"_AK"$DIR_AK_C"
folder_all_OLD=FW_CC"$DIR_CC_OLD"_AK"$DIR_AK_OLD"

number_RC_OLD=0`expr $number_RC - 1`
RC_folder_OLD=FW_CC"$DIR_CC_OLD"_AK"$DIR_AK_OLD"_RC_$number_RC_OLD


MAIN_PATH=`pwd`
name=gpio4_"$DIR_C"
name1=gpio4_"$DIR_L"
name2=gpio11_"$DIR_C"
name3=gpio11_"$DIR_L"
DIR_CC_OLD=020237

DIR_CP=cc3200_module/programs/p2p/exe
DIR_OTA=OTA_"$MODEL"_"$DIR_C"
DIR_OTA_L=OTA_"$MODEL"_"$DIR_L"
DIR_AK=ak_rtos_release
DIR_OTA_CP=OTA
#AK_BRANCH=20170907_trung_receive_cds_turn_led

check_clone_AK()
{
#cd $MAIN_PATH
#if [ -d $MAIN_PATH/$DIR_AK ]; then
#rm -r -f $MAIN_PATH/$DIR_AK
#echo "remove directory AK"
#git clone http://hoang.phuc@git.cinatic.com:7990/scm/cam/ak_rtos_release.git
#else
#git clone http://hoang.phuc@git.cinatic.com:7990/scm/cam/ak_rtos_release.git
#fi
#cd $MAIN_PATH
#cd
#cd $MAIN_PATH/$DIR_AK
#sed -i '11s/GIT_BRANCH="master"/GIT_BRANCH="'$AK_BRANCH'"/g' build_release.sh
#sed -i '13s/FW_VERSION="01.00.24"/FW_VERSION="'$version_ak'"/g' build_release.sh
#sed -i '12s/MODEL="003"/MODEL="'$MODEL'"/g' build_release.sh
#./build_release.sh
#git checkout -f 20170914_VanThuan_Fix_Buildrelease
cd
#cd $MAIN_PATH
#cd $MAIN_PATH/$DIR_AK
cd $MAIN_PATH
./build_release.sh $AK_BRANCH $MODEL $version_ak
cd 
#cd $MAIN_PATH/$DIR_AK
cd $MAIN_PATH
#if [ -e $MAIN_PATH/$DIR_AK/"$MODEL"_AK_OTA_"$DIR_AK_C".rar ]; then
if [ -e $MAIN_PATH/"$MODEL"_AK_OTA_"$DIR_AK_C".rar ]; then
unrar x  "$MODEL"_AK_OTA_"$DIR_AK_C".rar
echo "unrar directory AK_C done"
fi 
cd $MAIN_PATH
#cd $MAIN_PATH/$DIR_AK
#if [ -e $MAIN_PATH/$DIR_AK/"$MODEL"_AK_OTA_"$DIR_AK_L".rar ]; then
if [ -e $MAIN_PATH/"$MODEL"_AK_OTA_"$DIR_AK_L".rar ]; then
unrar x  "$MODEL"_AK_OTA_"$DIR_AK_L".rar
echo "unrar directory AK_L done"
fi
}


check_clone_code()
{
DIR=cc3200_module

echo "$MAIN_PATH/$DIR"
cd $MAIN_PATH
if [ -d $MAIN_PATH/$DIR ]; then
echo "start remove directory exists"
rm -r -f $MAIN_PATH/$DIR 
echo "remove done cc3200"
else
echo "not directory cc3200 exists"
fi
cd $MAIN_PATH
if [ -d $MAIN_PATH/$folder_release ] || [ -f $MAIN_PATH/$folder_release ]; then
rm -r -f $MAIN_PATH/$folder_release
echo "remove directory release"
else
echo "not directory release exists"
fi

if [ -e $MAIN_PATH/$folder_release.tar.gz ]; then
rm -r -f $MAIN_PATH/$folder_release.tar.gz
echo "remove directory folder_release compress"
else
echo "not directoryfolder_release compres exists"
fi

cd $MAIN_PATH
if [ -d $MAIN_PATH/$folder_release_OLD ] || [ -f $MAIN_PATH/$folder_release_OLD ]; then
rm -r -f $MAIN_PATH/$folder_release_OLD
echo "remove directory release"
else
echo "not directory release exists"
fi

if [ -e $MAIN_PATH/$folder_release_OLD.tar.gz ]; then
rm -r -f $MAIN_PATH/$folder_release_OLD.tar.gz
echo "remove directory folder_release_OLD compress"
else
echo "not directory folder_release_OLD compres exists"
fi


cd
cd $MAIN_PATH
if [ -d $MAIN_PATH/$DIR_OTA ]; then
rm -r -f $MAIN_PATH/$DIR_OTA
echo "remove directory OTA"
else
echo "not directory OTA exists"
fi

cd
cd $MAIN_PATH
if [ -d $MAIN_PATH/$DIR_OTA_L ]; then
rm -r -f $MAIN_PATH/$DIR_OTA_L
echo "remove directory OTA_L"
else
echo "not directory OTA_L exists"
fi

cd
cd $MAIN_PATH
if [ -e $MAIN_PATH/$DIR_OTA_L.tar.gz ]; then
rm -r -f $MAIN_PATH/$DIR_OTA_L.tar.gz
echo "remove directory OTA_L.tar.gz"
else
echo "not directory OTA_L.tar.gz exists"
fi

cd
cd $MAIN_PATH
if [ -e $MAIN_PATH/$DIR_OTA.tar.gz ]; then
rm -r -f $MAIN_PATH/$DIR_OTA.tar.gz
echo "remove directory OTA_C.taz.gz"
else
echo "not directory OTA_C.taz.gz exists"
fi

cd
cd $MAIN_PATH
if [ -e $MAIN_PATH/$DIR_OTA_CP.tar.gz ]; then
rm -r -f $MAIN_PATH/$DIR_OTA_CP.tar.gz
echo "remove directory DIR_OTA_CP.taz.gz"
else
echo "not directory DIR_OTA_CP.taz.gz exists"
fi

cd
cd $MAIN_PATH
if [ -e $MAIN_PATH/$DIR_OTA_CP ]; then
rm -r -f $MAIN_PATH/$DIR_OTA_CP
echo "remove directory DIR_OTA_CP"
else
echo "not directory DIR_OTA_CP exists"
fi

cd
cd $MAIN_PATH
if [ -e $MAIN_PATH/$folder_all ]; then
rm -r -f $MAIN_PATH/$folder_all
echo "remove directory folder_all_OLD"
else
echo "not directory folder_all_OLD exists"
fi

cd
cd $MAIN_PATH
if [ -e $MAIN_PATH/$folder_all_OLD.tar.gz ]; then
rm -r -f $MAIN_PATH/$folder_all_OLD.tar.gz
echo "remove directory folder_all.tar.gz"
else
echo "not directory folder_all.tar.gz exists"
fi
#gt is > or ge >=
cd
cd $MAIN_PATH
if [ -e $MAIN_PATH/$RC_folder_OLD.tar.gz ] && [ $number_RC_OLD -ge 00 ]; then
rm -r -f $MAIN_PATH/$RC_folder_OLD.tar.gz
echo "remove directory RC_folder_OLD.tar.gz"
else
echo "not directory RC_folder_OLD.tar.gz exists"
fi

cd
cd $MAIN_PATH
if [ -e $MAIN_PATH/$RC_folder.tar.gz ] || [ $number_RC -ge 00 ]; then
rm -r -f $MAIN_PATH/$RC_folder.tar.gz
echo "remove directory RC_folder.tar.gz"
else
echo "not directory RC_folder.tar.gz exists"
fi


#cd
#cd $MAIN_PATH
#if [-d $MAIN_PATH/gcc-arm-none-eabi-4_8-2014q1 ]
#then
#echo "folder GCC exist"
#else
#wget https://launchpad.net/gcc-arm-embedded/4.8/4.8-2014-q1-update/+download/gcc-arm-none-eabi-4_8-2014q1-20140314-linux.tar.bz2
#tar xjvf gcc-arm-none-eabi-4_8-2014q1-20140314-linux.tar.bz2
#sudo mv gcc-arm-none-eabi-4_8-2014q1 /usr/local
#rm -r -f gcc-arm-none-eabi-4_8-2014q1-20140314-linux.tar.bz2
#fi
cd
cd /usr/local
if [ -e /usr/local/gcc-arm-none-eabi-4_8-2014q1 ] || [ -d /usr/local/gcc-arm-none-eabi-4_8-2014q1 ]
then
echo "folder exist GCC"
else
sudo wget https://launchpad.net/gcc-arm-embedded/4.8/4.8-2014-q1-update/+download/gcc-arm-none-eabi-4_8-2014q1-20140314-linux.tar.bz2
sudo tar xjvf gcc-arm-none-eabi-4_8-2014q1-20140314-linux.tar.bz2
fi

cd
cd $MAIN_PATH
echo "start clone code"
git clone --recursive http://cao.nguyen:y@git.cinatic.com:7990/scm/cam/cc3200_module.git

#git clone --recursive http://hoang.phuc:phuchoang@git.cinatic.com:7990/scm/cam/cc3200_module.git

echo "clone done"

#cat $MAIN_PATH/$DIR/apps/p2p_streaming/lib/cc3200/cc3200_system.h | sed 's/define CALLGPIO 11/define CALLGPIO 4/g' > $MAIN_PATH/$DIR/apps/p2p_streaming/lib/cc3200/cc3200_system0.h
#mv $MAIN_PATH/$DIR/apps/p2p_streaming/lib/cc3200/cc3200_system0.h $MAIN_PATH/$DIR/apps/p2p_streaming/lib/cc3200/cc3200_system.h
#export and build code

echo "start export and build code"
cd $MAIN_PATH
export PATH=/usr/local/gcc-arm-none-eabi-4_8-2014q1/bin:$PATH
cd $MAIN_PATH/$DIR
git checkout -f "$CC_branch"
cd
cd $MAIN_PATH/$DIR/apps/p2p_streaming/lib/cc3200
#sed -i '11 s/#define SYSTEM_VERSION		"020256"/#define SYSTEM_VERSION    "'$DIR_C'"/g' cc3200_system.h
sed -i '11s/#define SYSTEM_VERSION     \([0-9][0-9]\)*.*.*"/#define SYSTEM_VERSION    "'$DIR_C'"/g' cc3200_system.h
sed -i '18 s/#define STR_MODEL			"003"/#define STR_MODEL    "'$MODEL'"/g' cc3200_system.h
cd 
cd $MAIN_PATH/$DIR/apps/p2p_streaming/lib/cc3200
if [ $MODEL -eq "002" ];
then
sed -i '7s/\'/'\'/'#define NTP_CHINA/#define NTP_CHINA/g' cc3200_system.h

sed -i '36s/#define CAM_LANGUAGE LANGUAGE_ENGLISH/#define CAM_LANGUAGE LANGUAGE_CHINESE/g' cc3200_system.h
fi
cd
cd $MAIN_PATH/$DIR/programs/p2p
make
cd
echo "folder exists"
echo "remove folder"
cd $MAIN_PATH
mkdir $folder_release
cd
cd $MAIN_PATH

cp -r $MAIN_PATH/$DIR_CP/p2p.bin $MAIN_PATH/$folder_release
cd
cd $MAIN_PATH/$folder_release
if [ -e $MAIN_PATH/$folder_release/p2p.bin ]; then
mv p2p.bin p2p_"$name2".bin
fi

cd $MAIN_PATH
cd $MAIN_PATH/$DIR/apps/p2p_streaming/lib/cc3200
sed -i '11 s/#define SYSTEM_VERSION    "'$DIR_C'"/#define SYSTEM_VERSION    "'$DIR_L'"/g' cc3200_system.h

cd $MAIN_PATH
cd $MAIN_PATH/$DIR/programs/p2p
make
cd $MAIN_PATH
cp -r $MAIN_PATH/$DIR_CP/p2p.bin $MAIN_PATH/$folder_release
cd $MAIN_PATH/$folder_release
if [ -e  $MAIN_PATH/$folder_release/p2p.bin ]; then
mv p2p.bin p2p_"$name3".bin
fi
cd $MAIN_PATH
cd $MAIN_PATH/$DIR/apps/p2p_streaming/lib/cc3200
sed -i '6 s/#define CALLGPIO 11/#define CALLGPIO 4/g' cc3200_system.h
cd $MAIN_PATH
cd $MAIN_PATH/$DIR/apps/p2p_streaming/lib/cc3200
sed -i '11 s/#define SYSTEM_VERSION    "'$DIR_L'"/#define SYSTEM_VERSION    "'$DIR_C'"/g' cc3200_system.h
cd $MAIN_PATH
cd $MAIN_PATH/$DIR/programs/p2p
make
#creat folder new
cd $MAIN_PATH

cp -r $MAIN_PATH/$DIR_CP/p2p.bin $MAIN_PATH/$folder_release
cd $MAIN_PATH/$folder_release
if [ -e $MAIN_PATH/$folder_release/p2p.bin ]; then
mv p2p.bin p2p."$name".bin
fi

cd
cd $MAIN_PATH/$DIR/apps/p2p_streaming/lib/cc3200
sed -i '11 s/#define SYSTEM_VERSION    "'$DIR_C'"/#define SYSTEM_VERSION    "'$DIR_L'"/g' cc3200_system.h
cd $MAIN_PATH
cd $MAIN_PATH/$DIR/programs/p2p
make
cd $MAIN_PATH
cp -r $MAIN_PATH/$DIR_CP/application_bootloader.bin $MAIN_PATH/$folder_release
cd $MAIN_PATH
cp -r $MAIN_PATH/$DIR_CP/p2p.bin $MAIN_PATH/$folder_release
cd
cd $MAIN_PATH/$folder_release
if [ -e $MAIN_PATH/$folder_release/p2p.bin ]; then
mv p2p.bin p2p_"$name1".bin
fi
cd $MAIN_PATH
cp -r $MAIN_PATH/$DIR/release/cc3200_factory_test.rar $MAIN_PATH/$folder_release
cd $MAIN_PATH
tar -zcf $folder_release.tar.gz $folder_release
cd
}

check_create_md5()
{
cd
cd $MAIN_PATH
mkdir $DIR_OTA
mkdir $DIR_OTA_L
cp -r $MAIN_PATH/$folder_release/p2p_gpio11_"$DIR_C".bin $MAIN_PATH/$DIR_OTA/$MODEL\-$DIR_C.part2.fw.pkg
cp -r $MAIN_PATH/$folder_release/p2p_gpio11_"$DIR_L".bin $MAIN_PATH/$DIR_OTA_L/$MODEL\-$DIR_L.part2.fw.pkg
 
cp -r $MAIN_PATH/$folder_release/p2p_gpio11_"$DIR_C".bin $MAIN_PATH/$DIR_OTA
cp -r $MAIN_PATH/$folder_release/p2p_gpio11_"$DIR_L".bin $MAIN_PATH/$DIR_OTA_L
cd
cd $MAIN_PATH/$DIR_OTA
if [ -e $MAIN_PATH/$DIR_OTA/p2p_gpio11_"$DIR_C".bin ]; then
md5sum p2p_gpio11_"$DIR_C".bin | cut -c -32 > "$MODEL"-"$DIR_C".part2.fw.md5
fi			
cd 
cd $MAIN_PATH/$DIR_OTA_L
#md5sum $MAIN_PATH/$DIR_OTA_L/p2p_gpio11_"$DIR_L".bin > $MAIN_PATH/$DIR_OTA_L/$MODEL\-$DIR_L.part2.fw.md5
#md5= md5sum p2p_gpio11_020241.bin | cut -d ' ' -f 1
#md51=`cat md5`
#touch temp_l.md5
#echo ${md5} > temp_l.md5
#echo ${md51} >> temp_l.md5
if [ -e $MAIN_PATH/$DIR_OTA_L/p2p_gpio11_"$DIR_L".bin ]; then
md5sum p2p_gpio11_$DIR_L.bin | cut -c -32 > $MODEL-$DIR_L.part2.fw.md5
fi
#cd $MAIN_PATH/$DIR_OTA
#if [ -e $MAIN_PATH/$DIR_OTA/$MODEL\-$DIR_C.part2.fw.md5 ]; then
#cat $MAIN_PATH/$DIR_OTA/$MODEL\-$DIR_C.part2.fw.md5 | sed "s@$MAIN_PATH/$DIR_OTA/p2p_gpio11_"$DIR_C".bin@@" > $MAIN_PATH/$DIR_OTA/temp_c.md5
#fi
#cd
#cd $MAIN_PATH/$DIR_OTA
#mv $MAIN_PATH/$DIR_OTA/temp_c.md5 $MAIN_PATH/$DIR_OTA/$MODEL\-$DIR_C.part2.fw.md5
#cd
#cd $MAIN_PATH/$DIR_OTA_L
#if [ -e $MAIN_PATH/$DIR_OTA_L/$MODEL\-$DIR_L.part2.fw.md5 ]; then
#cat $MAIN_PATH/$DIR_OTA_L/$MODEL\-$DIR_L.part2.fw.md5 | sed "s@$MAIN_PATH/$DIR_OTA_L/p2p_gpio11_"$DIR_L".bin@@" > $MAIN_PATH/$DIR_OTA_L/temp_l.md5
#fi

cd
cd $MAIN_PATH/$DIR_OTA_L
#mv $MAIN_PATH/$DIR_OTA_L/temp_l.md5 $MAIN_PATH/$DIR_OTA_L/$MODEL\-$DIR_L.part2.fw.md5

cd
cd $MAIN_PATH
#cp -r $MAIN_PATH/$DIR_AK/signature $MAIN_PATH/$DIR_OTA
#cp -r $MAIN_PATH/$DIR_AK/signature $MAIN_PATH/$DIR_OTA_L
cp -r $MAIN_PATH/signature $MAIN_PATH/$DIR_OTA
cp -r $MAIN_PATH/signature $MAIN_PATH/$DIR_OTA_L
cd 
cd $MAIN_PATH/$DIR_OTA
if [ -f signature ]; then
./signature p2p_gpio11_"$DIR_C".bin $MAIN_PATH/$DIR_OTA/$MODEL\-$DIR_C.part2.sig
fi
cd
cd $MAIN_PATH/$DIR_OTA_L
if [ -f signature ]; then
./signature p2p_gpio11_"$DIR_L".bin $MAIN_PATH/$DIR_OTA_L/$MODEL\-$DIR_L.part2.sig
fi
cd
cd $MAIN_PATH
#cp -r $MAIN_PATH/$DIR_AK/"$MODEL"_AK_OTA_"$DIR_AK_C"/"$MODEL"-"$DIR_AK_C".part1.fw.pkg /$MAIN_PATH/$DIR_OTA/
#cp -r $MAIN_PATH/$DIR_AK/"$MODEL"_AK_OTA_"$DIR_AK_C"/"$MODEL"-"$DIR_AK_C".part1.fw.md5 /$MAIN_PATH/$DIR_OTA/
#cp -r $MAIN_PATH/$DIR_AK/"$MODEL"_AK_OTA_"$DIR_AK_C"/"$MODEL"-"$DIR_AK_C".part1.sig /$MAIN_PATH/$DIR_OTA/
cp -r $MAIN_PATH/"$MODEL"_AK_OTA_"$DIR_AK_C"/"$MODEL"-"$DIR_AK_C".part1.fw.pkg /$MAIN_PATH/$DIR_OTA/
cp -r $MAIN_PATH/"$MODEL"_AK_OTA_"$DIR_AK_C"/"$MODEL"-"$DIR_AK_C".part1.fw.md5 /$MAIN_PATH/$DIR_OTA/
cp -r $MAIN_PATH/"$MODEL"_AK_OTA_"$DIR_AK_C"/"$MODEL"-"$DIR_AK_C".part1.sig /$MAIN_PATH/$DIR_OTA/
cd
cd $MAIN_PATH
#cp -r $MAIN_PATH/$DIR_AK/"$MODEL"_AK_OTA_"$DIR_AK_L"/"$MODEL"-"$DIR_AK_L".part1.fw.pkg /$MAIN_PATH/$DIR_OTA_L/
#cp -r $MAIN_PATH/$DIR_AK/"$MODEL"_AK_OTA_"$DIR_AK_L"/"$MODEL"-"$DIR_AK_L".part1.fw.md5 /$MAIN_PATH/$DIR_OTA_L/
#cp -r $MAIN_PATH/$DIR_AK/"$MODEL"_AK_OTA_"$DIR_AK_L"/"$MODEL"-"$DIR_AK_L".part1.sig /$MAIN_PATH/$DIR_OTA_L/

cp -r $MAIN_PATH/"$MODEL"_AK_OTA_"$DIR_AK_L"/"$MODEL"-"$DIR_AK_L".part1.fw.pkg /$MAIN_PATH/$DIR_OTA_L/
cp -r $MAIN_PATH/"$MODEL"_AK_OTA_"$DIR_AK_L"/"$MODEL"-"$DIR_AK_L".part1.fw.md5 /$MAIN_PATH/$DIR_OTA_L/
cp -r $MAIN_PATH/"$MODEL"_AK_OTA_"$DIR_AK_L"/"$MODEL"-"$DIR_AK_L".part1.sig /$MAIN_PATH/$DIR_OTA_L/

cd
cd $MAIN_PATH/$DIR_OTA
rm -rf p2p_gpio11_"$DIR_C".bin
rm -rf signature
cd
cd $MAIN_PATH/$DIR_OTA_L
rm -rf p2p_gpio11_"$DIR_L".bin
rm -rf signature

#sed -i 's/"version":"'$DIR_AK_L'"/"version":"'$DIR_AK_L'"/' 002-020237.json
#sed -i 's/"pkg":"'002-"$DIR_AK_L".part1.fw.pkg'"/"pkg":"'002-"$DIR_AK_L".part1.fw.pkg'"/' 002-020237.json
#sed -i 's/"sig":"'002-"$DIR_AK_L".part1.sig'"/"sig":"'002-"$DIR_AK_L".part1.sig'"/' 002-020237.json
cd $MAIN_PATH
echo ""
}
check_json()
{
cd $MAIN_PATH
#cp -r $MAIN_PATH/json/002-020237.json $MAIN_PATH/$DIR_OTA
#cd
#cd $MAIN_PATH/$DIR_OTA

#sed -i '5 s/"version":"'$DIR_AK_L'"/"version":"'$DIR_AK_L'"/g' 002-020237.json
#sed -i '6 s/"pkg":"'002-"$DIR_AK_L".part1.fw.pkg'"/"pkg":"'002-"$DIR_AK_L".part1.fw.pkg'"/g' 002-020237.json
#sed -i '7 s/"sig":"'002-"$DIR_AK_L".part1.sig'"/"sig":"'002-"$DIR_AK_L".part1.sig'"/g' 002-020237.json

#cd
#cd $MAIN_PATH/$DIR_OTA
#sed -i '12 s/"version":"'$DIR_CC_OLD'"/"version":"'$DIR_L'"/g' 002-020237.json
#sed -i '13 s/"pkg":"'002-"$DIR_CC_OLD".part2.fw.pkg'"/"pkg":"'002-"$DIR_C".part2.fw.pkg'"/g' 002-020237.json
#sed -i '14 s/"sig":"'002-"$DIR_CC_OLD".part2.sig'"/"sig":"'002-"$DIR_C".part2.sig'"/g' 002-020237.json

cd
cd $MAIN_PATH/$DIR_OTA_L
#num_md5=cat 002-020240.part2.fw.md5
cc_md5=`cat "$MODEL"-"$DIR_L".part2.fw.md5`
md5_AK=`cat "$MODEL"-"$DIR_AK_L".part1.fw.md5`

#sed $'s/\'${\\([0-9]*\\)}\'/\\1/g'
#sed -i 's/responseCode\[7\]/responseCode\[16\]/g'
#sed -i '8 s/"md5":"ba4fd924b83e8ad4a3b6f15561614007"/"md5":"${md5_AK}"/g' 002-020237.json
#sed -i "15 s@`"md5":"612329f3e089426734b8ce2bb550be01"`@`"md5":"${value_md5_CC}"`@" 002-020237.json
###################################write input file#########################################
echo '{"partitionData":' >  "$MODEL"-"$DIR_L".json
echo "[" >> "$MODEL"-"$DIR_L".json
echo "{" >> "$MODEL"-"$DIR_L".json
echo '"index":0,' >>  "$MODEL"-"$DIR_L".json
echo '"version":"'$DIR_AK_L'",' >> "$MODEL"-"$DIR_L".json
echo '"pkg":"'$MODEL'-'$DIR_AK_L'.part1.fw.pkg",'>> "$MODEL"-"$DIR_L".json
echo '"sig":"'$MODEL'-'$DIR_AK_L'.part1.sig",' >> "$MODEL"-"$DIR_L".json
echo '"md5":"'$md5_AK'"' >> "$MODEL"-"$DIR_L".json
echo "}," >> "$MODEL"-"$DIR_L".json
echo "{" >> "$MODEL"-"$DIR_L".json
echo '"index":1,' >> "$MODEL"-"$DIR_L".json
echo '"version":"'$DIR_L'",' >> "$MODEL"-"$DIR_L".json
echo '"pkg":"'$MODEL'-'$DIR_L'.part2.fw.pkg",' >> "$MODEL"-"$DIR_L".json
echo '"sig":"'$MODEL'-'$DIR_L'.part2.sig",' >> "$MODEL"-"$DIR_L".json
echo '"md5":"'$cc_md5'"' >> "$MODEL"-"$DIR_L".json
echo "}," >> "$MODEL"-"$DIR_L".json
echo "]" >> "$MODEL"-"$DIR_L".json
echo "}" >> "$MODEL"-"$DIR_L".json

cd
cd $MAIN_PATH/$DIR_OTA
c_cc_md5=`cat "$MODEL"-"$DIR_C".part2.fw.md5`
md5_AK_c=`cat "$MODEL"-"$DIR_AK_C".part1.fw.md5`

echo '{"partitionData":' >  "$MODEL"-"$DIR_C".json
echo '[' >> "$MODEL"-"$DIR_C".json
echo '{' >> "$MODEL"-"$DIR_C".json
echo '"index":0,' >>  "$MODEL"-"$DIR_C".json
echo '"version":"'$DIR_AK_C'",' >> "$MODEL"-"$DIR_C".json
echo '"pkg":"'$MODEL'-'$DIR_AK_C'.part1.fw.pkg",'>> "$MODEL"-"$DIR_C".json
echo '"sig":"'$MODEL'-'$DIR_AK_C'.part1.sig",' >> "$MODEL"-"$DIR_C".json
echo '"md5":"'$md5_AK_c'"' >> "$MODEL"-"$DIR_C".json
echo '},' >> "$MODEL"-"$DIR_C".json
echo "{" >> "$MODEL"-"$DIR_C".json
echo '"index":1,' >> "$MODEL"-"$DIR_C".json
echo '"version":"'$DIR_C'",' >> "$MODEL"-"$DIR_C".json
echo '"pkg":"'$MODEL'-'$DIR_C'.part2.fw.pkg",' >> "$MODEL"-"$DIR_C".json
echo '"sig":"'$MODEL'-'$DIR_C'.part2.sig",' >> "$MODEL"-"$DIR_C".json
echo '"md5":"'$c_cc_md5'"' >> "$MODEL"-"$DIR_C".json
echo '},' >> "$MODEL"-"$DIR_C".json
echo ']' >> "$MODEL"-"$DIR_C".json
echo '}' >> "$MODEL"-"$DIR_C".json
###########################################################################################
cd
cd $MAIN_PATH
mkdir $DIR_OTA_CP
cd 
cp -r $MAIN_PATH/$DIR_OTA $MAIN_PATH/$DIR_OTA_CP
cp -r $MAIN_PATH/$DIR_OTA_L $MAIN_PATH/$DIR_OTA_CP
cd
cd $MAIN_PATH/$DIR_OTA_CP
tar -zcf $DIR_OTA.tar.gz $DIR_OTA
tar -zcf $DIR_OTA_L.tar.gz $DIR_OTA_L
cd
cd $MAIN_PATH/$DIR_OTA_CP
rm -r -f $DIR_OTA_L
rm -r -f $DIR_OTA
cd
cd $MAIN_PATH
tar -zcf $DIR_OTA_CP.tar.gz $DIR_OTA_CP
cd
cd $MAIN_PATH
rm -r -f $DIR_OTA_L
rm -r -f $DIR_OTA
cd
cd $MAIN_PATH
rm -r -f $folder_release
cd
cd $MAIN_PATH
rm -r -f $DIR_OTA_CP
cd $MAIN_PATH
mkdir $folder_all
mkdir $RC_folder
#mkdir $RC_folder_003
cd
cd $MAIN_PATH
cp -r $DIR_OTA_CP.tar.gz $MAIN_PATH/$folder_all
cp -r $folder_release.tar.gz $MAIN_PATH/$folder_all

cp -r $DIR_OTA_CP.tar.gz $MAIN_PATH/$RC_folder
cp -r $folder_release.tar.gz $MAIN_PATH/$RC_folder

#cp -r $DIR_OTA_CP.tar.gz $MAIN_PATH/$RC_folder_003
#cp -r $folder_release.tar.gz $MAIN_PATH/$RC_folder_003
cd
#cp -r $MAIN_PATH/$DIR_AK/"$MODEL"_AK_"$DIR_AK_C".rar $MAIN_PATH/$folder_all
#cp -r $MAIN_PATH/$DIR_AK/"$MODEL"_AK_"$DIR_AK_L".rar $MAIN_PATH/$folder_all
cp -r $MAIN_PATH/"$MODEL"_AK_"$DIR_AK_C".rar $MAIN_PATH/$folder_all
cp -r $MAIN_PATH/"$MODEL"_AK_"$DIR_AK_L".rar $MAIN_PATH/$folder_all


#cp -r $MAIN_PATH/$DIR_AK/"$MODEL"_AK_"$DIR_AK_C".rar $MAIN_PATH/$RC_folder
#cp -r $MAIN_PATH/$DIR_AK/"$MODEL"_AK_"$DIR_AK_L".rar $MAIN_PATH/$RC_folder
cp -r $MAIN_PATH/"$MODEL"_AK_"$DIR_AK_C".rar $MAIN_PATH/$RC_folder
cp -r $MAIN_PATH/"$MODEL"_AK_"$DIR_AK_L".rar $MAIN_PATH/$RC_folder

#cp -r $MAIN_PATH/$DIR_AK/"$MODEL"_AK_"$DIR_AK_C".rar $MAIN_PATH/$RC_folder_003
#cp -r $MAIN_PATH/$DIR_AK/"$MODEL"_AK_"$DIR_AK_L".rar $MAIN_PATH/$RC_folder_003
cd
cd $MAIN_PATH
tar -zcf $folder_all.tar.gz $folder_all
tar -zcf $RC_folder.tar.gz $RC_folder
#tar -zcf $RC_folder_003.tar.gz $RC_folder_003

cd
cd $MAIN_PATH
rm -rf $folder_all
rm -rf $RC_folder
rm -rf $RC_folder_003
cd

cd $MAIN_PATH/$DIR_CC32_TAG
git tag $VAR_CC32
git push origin $VAR_CC32
cd
cd $MAIN_PATH/$DIR_AK_TAG
git tag $VAR_AK
git push origin $VAR_AK
cd

}
#############################################################################
#                            START MAIN                                    #
#############################################################################
check_clone_AK
check_clone_code
check_create_md5
check_json
