#                                                         INSTRUCTION
At the first time of using this build-release program, user should open the run file: ./build_release.sh for editing user-configuration variables
# User defined paths include:
	GIT_PATH="http://hoang.phuc@git.cinatic.com:7990/scm/cam/anyka_baterycam.git"
	GIT_BRANCH="20170811_trung_record_mp4"
	MODEL="002"
        FW_VERSION="01.00.17"
	
# These paths will be updated automatically whenever user runs build_release: 
	TOOLCHAIN_PATH="/home/thuanbk/myworkspace/mytoolchain/arm-anykav200-crosstool/usr"
	TEMPLATE_PATH="/media/sf_myfolder/002_AK_Template.rar"
# The program will check for existing  of the Template file:  AK_Template.rar and the tool_chain file: anyka_uclibc_gcc.tar
# This program will update the template file and tool_chain file if it does not find out the tool chain or template file

To run this build-release program, at the current workspace user run
 ./build_release.sh 
=> User checks the OUTPUT_PATH for output build files.

# IMPORTANT Requirement:
	+ Don't build at the share linux-windown folder
	+ Run the build_release as root
	+ Install rar, unrar before run the build release program
	+ Open the build_release.sh and check inputs as you expect
