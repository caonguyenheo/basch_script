#!/bin/bash

#Coder: TVThuan
#Date: 28/08/2017

#-------------------------------------------------------------------------------
clear

#-------------------------User Defined Paths here-------------------------------
#GIT_PATH="http://hoang.phuc:phuchoang@git.cinatic.com:7990/scm/cam/anyka_baterycam.git"
GIT_PATH="http://cao.nguyen:y@git.cinatic.com:7990/scm/cam/anyka_baterycam.git"  
#GIT_BRANCH="20171020_trung_merging_release010054" 
#MODEL="002"
#FW_VERSION="01.00.54"

#Thuan edited - 23/10/2017
GIT_BRANCH="$1"
MODEL="$2"
FW_VERSION="$3"



#-------------------------------------------------------------------------------
#                            ---------------------   
#-------------------------END USER DEFINED PATHS BLOCK--------------------------
#
#
#
#-------------------------------------------------------------------------------

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


array1=(${GIT_PATH//// })
num1=${#array1[@]}
num2=${array1[`expr $num1 - 1 `]}

array2=(${num2//./ })

SOURCE_FOLDER=${array2[0]}
DEMM=1
FW_VERSION_TEMP=""

#------------------------------Default Paths------------------------------------
TOP_DIR=""
MAIN_PATH=`pwd`
BIN_PATH="${MAIN_PATH}/${SOURCE_FOLDER}/image"
#---------TOOLCHAIN_PATH and TEMPLATE_PATH will be updated automatically--------
TOOLCHAIN_PATH=""
TEMPLATE_PATH="$MAIN_PATH/002_AK_Template.rar"
BIN_PATH_1=${MAIN_PATH}/${SOURCE_FOLDER}

#-------------------------------------------------------------------------------

array=(${FW_VERSION//./ })

num=${#array[@]}

if [ "$num" == "3" ]
then
        echo "Valid version"
else
        echo "Unvalid version"
        exit 1
fi

#Check for existing required tools: Template file/tool-chain/signature
check_env()
{
	if [ -f 002_AK_Template.rar ]
	then
        	echo "Template file_ok"
	else
        	echo "Couldn't find out Template file"
        	echo " Please re git clone all neccessary file from: http://hoang.phuc@git.cinatic.com:7990/scm/cam/ak_rtos_release.git"
        	exit 1
	fi

	if [ -f signature ]
	then
        	echo "signature file__ok"
	else
        	echo "Couldn't find out signature file"
        	echo " Please re git clone all neccessary file from: http://hoang.phuc@git.cinatic.com:7990/scm/cam/ak_rtos_release.git"
        	exit 1
	fi


	if [ -d $MAIN_PATH/opt/arm-anykav200-crosstool/usr/bin ]
	then
		echo "Tool chain_OK"
	else
		if [ -f anyka_uclibc_gcc.tar.bz2 ]
		then 
			tar jxf ./anyka_uclibc_gcc.tar.bz2
			if [ -d $MAIN_PATH/opt/arm-anykav200-crosstool/usr/bin ]
			then
				echo " Tool chain_OK"
			else
				echo "Couldn't find out Tool chain file"
                		echo " Please re git clone all neccessary file from: http://hoang.phuc@git.cinatic.com:7990/scm/cam/ak_rtos_release.git"
                		exit 1
			fi 
		else
			echo "Couldn't find out Tool chain file"
                	echo " Please re git clone all neccessary file from: http://hoang.phuc@git.cinatic.com:7990/scm/cam/ak_rtos_release.git"
                	exit 1
		fi	
	fi

TOOLCHAIN_PATH="${MAIN_PATH}/opt/arm-anykav200-crosstool/usr"
}
#-------------------------------------------------------------------------------


#Check for existing of the tool_chain
check_toolchain()
{
if [ -d $TOOLCHAIN_PATH/bin ]
then

	echo "The tool_chain existed, let 's go on!"

else

	echo "Can not find out tool chain from tool_chain path directory!"
	echo "Build fail!"
	echo ""
	echo "------------------------------------------------------------"
	exit 1
fi
}

check_oldVersion()
{
	if [ -d $SOURCE_FOLDER ]; then 
		rm -r -f $SOURCE_FOLDER;
		echo "Removed the old $SOURCE_FOLDER folder."
	fi
}

git_clone()
{
	git clone $GIT_PATH -b $GIT_BRANCH

if [ -e $SOURCE_FOLDER ]
then
	echo "------------------------------------------------------------"
	echo ""
	echo "Git clone successfully!"
	# Moving to the folder containing source code

	cd $SOURCE_FOLDER/
	TOP_DIR=`pwd`
	TOP_DIR=${TOP_DIR}/platform/apps/main_ctrl

else

	echo "Git clone fail!"
	echo ""
	echo ""
	echo "-----------------------------------------------------"
	exit 1

fi

	echo ""
	echo ""
	echo ""
	echo ""
}

edit_fwversion()
{
	cd $MAIN_PATH
	cd $SOURCE_FOLDER/

if [ $MODEL -eq "002" ] || [ $MODEL -eq "003" ]
then 
	#cd platform/apps/main_ctrl/
	#Write fw_version to version.h file
        if [ -e ${TOP_DIR}/version.h ]
	then
		 echo ""
		 echo "${TOP_DIR}/version.h"
       		 cat ${TOP_DIR}/version.h | sed 's/FW_VER=\([0-9][0-9]\)*.*.*"/FW_VER='$FW_VERSION_TEMP'"/g' > ${TOP_DIR}/version0.h
		 mv ${TOP_DIR}/version0.h  ${TOP_DIR}/version.h
		 echo "Edit firmvare_version successfully"
		 echo ""

	fi
else
	echo "Wrong MODEL"
	echo "Build fail!"
	echo "---------------------------------------------------------"
	exit 1

fi

}
edit_config()
{
cd
cd $BIN_PATH_1/platform/apps/config/
if [ $MODEL -eq "002" ]
then
if [ -e $BIN_PATH_1/platform/apps/config/config_model.h ]
then
#sed -i '31s/\'/'\'/'#define DOORBELL_TINKLE820                    (1)/\'/'\'/'#define DOORBELL_TINKLE820                    (1)/g' config_model.h
sed -i '31s/#define DOORBELL_TINKLE820                    (1)/\'/'\'/'#define DOORBELL_TINKLE820                    (1)/g' config_model.h
fi
fi

#if [ $MODEL -eq "003" ]
#then
#if [ -e $BIN_PATH_1/platform/apps/config/config_model.h ]
#then
#sed -i '31s/\'/'\'/'#define DOORBELL_TINKLE820                    (1)/#define DOORBELL_TINKLE820                    (1)/g' config_model.h
#sed -i '31s/#define DOORBELL_TINKLE820                    (1)/\'/'\'/'#define DOORBELL_TINKLE820                    (1)/g' config_model.h
#fi
#fi



cd
cd $MAIN_PATH
cp -f anyka_cfg.ini /$BIN_PATH_1/
}

start_build()
{	
	cd $MAIN_PATH
	cd $SOURCE_FOLDER/	

	#Start building source code..
	export CROSS_PATH=$TOOLCHAIN_PATH   #current toolchain_path :TOOLCHAIN_PATH = /opt/arm-anykav200-crosstool/usr
	export PATH=$PATH:$CROSS_PATH/bin/
	make BOARD=cc3200bd clean all
	echo ""
	echo ""
	echo ""
	echo "--------------------------------------------------------------------"
}

compress_rar()
{
	cd $MAIN_PATH
	outputfolder="${MODEL}_AK_${FW_VERSION}"

	if [ -d $MAIN_PATH/TEM ]
	then
		rm -r -f $MAIN_PATH/TEM
	fi

	if [ -d $MAIN_PATH/$outputfolder ]
	then
        	rm -r -f $MAIN_PATH/$outputfolder
	fi

#Decompress the template .rar file to folder
	if [ -f $TEMPLATE_PATH ]
	then
		mkdir TEM
		cd TEM 
		unrar x $TEMPLATE_PATH
		cd $MAIN_PATH
	fi

#cp -r $TEMPLATE_PATH $MAIN_PATH/TEM

	if [ -f $MAIN_PATH/TEM/sky39ev200_ota.bin ]
	then 
		rm -r -f $MAIN_PATH/TEM/sky39ev200_ota.bin
	fi

	if [ -f $MAIN_PATH/TEM/burn_tool_EV200_4MB_flash/burn_tool_evb_5jun/sky39ev200_ota.bin ]
	then
        	rm -r -f $MAIN_PATH/TEM/burn_tool_EV200_4MB_flash/burn_tool_evb_5jun/sky39ev200_ota.bin
	fi

	if [ -f $MAIN_PATH/TEM/burn_tool_51115_8MB_flash/burn_tool_51115/BK_KERNEL_sky39ev200.bin ]
	then
        	rm -r -f  $MAIN_PATH/TEM/burn_tool_51115_8MB_flash/burn_tool_51115/BK_KERNEL_sky39ev200.bin
	fi

	if [ -f $MAIN_PATH/TEM/burn_tool_51115_8MB_flash/burn_tool_51115/sky39ev200_ota.bin ]
	then
        	rm -r -f $MAIN_PATH/TEM/burn_tool_51115_8MB_flash/burn_tool_51115/sky39ev200_ota.bin
	fi
#----------------------------------------------------------------------------------------------------------------------
	cp -r $BIN_PATH/sky39ev200.bin $MAIN_PATH/TEM/sky39ev200_ota.bin
	cp -r $BIN_PATH/sky39ev200.bin $MAIN_PATH/TEM/burn_tool_EV200_4MB_flash/burn_tool_evb_5jun/sky39ev200_ota.bin
	cp -r $BIN_PATH/sky39ev200.bin $MAIN_PATH/TEM/burn_tool_51115_8MB_flash/burn_tool_51115/BK_KERNEL_sky39ev200.bin
	cp -r $BIN_PATH/sky39ev200.bin $MAIN_PATH/TEM/burn_tool_51115_8MB_flash/burn_tool_51115/sky39ev200_ota.bin
        cp -f $BIN_PATH_1/anyka_cfg.ini $MAIN_PATH/TEM/burn_tool_51115_8MB_flash/burn_tool_51115/
        cp -f $BIN_PATH_1/anyka_cfg.ini $MAIN_PATH/TEM/burn_tool_EV200_4MB_flash/burn_tool_evb_5jun/

#compress 2 folders burn_tool_EV200_4MB_flash and burn_tool_51115_8MB_flash
	cd $MAIN_PATH/TEM
	rar a burn_tool_EV200_4MB_flash.rar burn_tool_EV200_4MB_flash
	rar a burn_tool_51115_8MB_flash.rar burn_tool_51115_8MB_flash

# remove 2 folders burn_tool_EV200_4MB_flash and burn_tool_51115_8MB_flash
	if [ -d burn_tool_EV200_4MB_flash ]
	then
        	rm -r -f burn_tool_EV200_4MB_flash
	fi

	if [ -d burn_tool_51115_8MB_flash ]
	then
        	rm -r -f burn_tool_51115_8MB_flash
	fi


	cd $MAIN_PATH

#compress outputfolder.rar
	if [ -e $MAIN_PATH/$outputfolder.rar ]
	then
        	rm -r -f $MAIN_PATH/$outputfolder.rar
	fi

	cp -r TEM $outputfolder 
	rar a $outputfolder.rar  $outputfolder

#clean directory
	if [ -d $outputfolder ]
	then
        	rm -r -f $outputfolder
	fi

	if [ -d TEM ]
	then
        	rm -r -f TEM
	fi
	
	if [ -f $MAIN_PATH/$outputfolder.rar ]
        then
              echo "The $outputfolder.rar was built successfully at ${MAIN_PATH} "

	fi
}


#cal md5 and compress to OTA.rar
md5_cal()
{
OTAfolder="${MODEL}_AK_OTA_${FW_VERSION}"
	cd $MAIN_PATH
# check for existing of the OTA folder
	if [ -d $OTAfolder ]
	then
        	rm -r -f $OTAfolder
	fi

	if [ -f $OTAfolder.rar ]
	then
        	rm -r -f $OTAfolder.rar
	fi


#create new OTA folder
	mkdir $OTAfolder
	cp -r $BIN_PATH/sky39ev200.bin $MAIN_PATH/$OTAfolder/$MODEL\-$FW_VERSION.part1.fw.pkg
	md5sum $BIN_PATH/sky39ev200.bin | cut -c -32 > $MAIN_PATH/$OTAfolder/$MODEL\-$FW_VERSION.part1.fw.md5

#Edit md5 file
	if [ -e $MAIN_PATH/$OTAfolder/$MODEL\-$FW_VERSION.part1.fw.md5 ]
	then
		echo "create md5 success"
		#cat $MAIN_PATH/$OTAfolder/$MODEL\-$FW_VERSION.part1.fw.md5 | sed "s@ ${BIN_PATH}/sky39ev200.bin@@" > $MAIN_PATH/$OTAfolder/tem0.md5         
		#mv $MAIN_PATH/$OTAfolder/tem0.md5 $MAIN_PATH/$OTAfolder/$MODEL\-$FW_VERSION.part1.fw.md5
	else
		echo ""
        	echo "Creating the OTA.rar fail!"
		exit 1
	fi
if [ -f signature ]
then
	#starting to compress OTA.rar and copy to the output foler

		./signature $BIN_PATH/sky39ev200.bin $MAIN_PATH/$OTAfolder/$MODEL\-$FW_VERSION.part1.sig
		
		rar a $OTAfolder.rar  $OTAfolder
	
	if [ -e $MAIN_PATH/$OTAfolder.rar ]
	then
        	echo "***"
		echo ""
		echo "The ${OTAfolder}.rar was built successfully at the folder ${MAIN_PATH}"

	else
        	echo ""
		echo "Creating the ${OTAfolder}.rar fail!"
	fi

	if [ -f $MAIN_PATH/$outputfolder.rar ]
        then
              echo "The $outputfolder.rar was built successfully at ${MAIN_PATH} "
        fi

	
else
	echo ""
	echo "Coundn't find out the signature file from this current workspace!"
	exit 1
fi

	if [ -d $OTAfolder ]
        then
                rm -r -f $OTAfolder
        fi

}

#--------------------------- START MAIN-PROCESS HERE-------------------------------

for demm in {1..2}
do
	DEMM=$demm
	
	if [ $demm -eq 1 ]
	then
		#-----------
		myarray=(${FW_VERSION//./ })
		mynum1=`expr ${myarray[2]} / 10 `
		mynum2=`expr ${myarray[2]} % 10 `
		FW1=$FW_VERSION
		FW_VERSION_TEMP=$FW1
		FW_VERSION="${myarray[0]}${myarray[1]}${mynum1}${mynum2}"
		
		check_env
	        echo "--------------------------"
        	echo ""
        	check_oldVersion
        	echo "--------------------------"
        	echo ""

        	git_clone
                edit_config
        	echo "--------------------------"
        	echo ""
        	

	else
		#-----------
                myarray=(${FW1//./ })
                mynum=${myarray[2]}
                myarray[2]=`expr $mynum + 1 `
                mynum1=`expr ${myarray[2]} / 10 `
                mynum2=`expr ${myarray[2]} % 10 `
                FW_VERSION="${myarray[0]}${myarray[1]}${mynum1}${mynum2}"
		FW2="${myarray[0]}.${myarray[1]}.${mynum1}${mynum2}"
		FW_VERSION_TEMP=$FW2

	fi

	edit_fwversion
	echo "--------------------------"
	echo ""

	start_build

	echo "--------------------------"
	echo ""
# Comress .rar file
	compress_rar
	echo ""
	echo " Build successfully!"
	echo ""
	echo "--------------------------"

	md5_cal
	echo ""
	echo ""
done

	echo " --------------------------------------------------------------------"
	echo " The GIT_PATH: $GIT_PATH"
	echo " The current branch: $GIT_BRANCH"
	echo " ModeL: $MODEL"
	echo " Firmware Version: $FW1 and $FW2 "
	echo " The Current Workspace: $MAIN_PATH"
	echo " --------------------------------------------------------------------"
	echo ""
#----------------------------------------------------------------------------------
# END PROGRAM HERE
