#! /bin/bash   

#jun: please not use /bin/sh, instead, use /bin/bash in the first line.
#jun: the compare of string uses '!=', '=='(or '='), '-z string', '-n string', '<', '>'
#jun: the compare of digital uses '-eq', '-ne', '-lt', '-le', '-gt', '-ge'
#jun: in if [ ], use -o(or), -a(and), !. not be &&, ||
#jun: NOTE: In bash file, 'make -p ~/XX' donot create XX dir in your home dir, be careful!!!. 
#     instead, use $HOME/XX.

PROJECT_PATH=$1
PROJECT_NAME=$2

T=`dirname $0` #get dir name
CSCOPE_DB_TOP_PATH=`cd $T;pwd`

function check_exit()
{
	if [ $? != '0' ]; then
		exit $?
	fi
}

# main:
if [ $# != '2' ]; then
	echo "USAGE: need two arguments. For example: $0 <your_project_path> <your_project_name>"
	exit -1
fi

if [ ! -d $PROJECT_PATH ]; then
	echo "$PROJECT_PATH no exit, please offer the top dir of your project."
	exit -1
fi

#jun: first obtain absolute path
PROJECT_PATH_ABS="$(cd "$PROJECT_PATH" ; pwd)"
CSCOPE_DB_TOP_PATH_ABS="$(cd "$CSCOPE_DB_TOP_PATH" ; pwd)"
PROJECT_DB_PATH="$CSCOPE_DB_TOP_PATH_ABS/$PROJECT_NAME"

if [ ! -d $PROJECT_DB_PATH ]; then
	mkdir -p $PROJECT_DB_PATH	
	check_exit
else
	echo "cscope projec of $PROJECT_NAME has exsited! Quit. "
	echo "If you want to rebuild cscope project of $PROJECT_NAME, delete the dir of $PROJECT_DB_PATH"
	exit -1
fi

echo "project top dir: $PROJECT_PATH_ABS"
echo "project name: $PROJECT_NAME"
echo "cscope database path: $PROJECT_DB_PATH"

#jun: find arguments
#jun:  -o: or
#jun:  -path and -prune: skip path's dir
#jun:  -path and ! -path and -prune: skip path's dir, except for the !path's dir
#jun:  NOTE: -name "*_defconfig" -o -name "*.[xx]"  IS DIFFERENT OF -name "*_defconfig -print -o -name "*.[xx]" -print
#jun:        I don't know the reason. But, using the latter is more safer.
#jun: I think that find tool is very complicated.

find "$PROJECT_PATH_ABS"  \
	-path "$PROJECT_PATH_ABS/arch/*" ! -path "$PROJECT_PATH_ABS/arch/arm*" -prune -o               \
	-path "$PROJECT_PATH_ABS/Documentation*" -prune -o      \
	-path "$PROJECT_PATH_ABS/scripts*" -prune -o            \
	-name "*_defconfig" -print -o 									\
	-name "*.cpp" -print -o                    \
	-name "*.[chsS]" -print > $PROJECT_DB_PATH/cscope.files
check_exit

cd $PROJECT_DB_PATH

#jun: cscope arguments, from http://cscope.sourceforge.net/large_projects.html
#jun: The -b flag tells Cscope to just build the database, and not launch the Cscope GUI. The -q causes an additional,
#jun: 'inverted index' file to be created, which makes searches run much faster for large databases. Finally, -k sets 
#jun: Cscope's 'kernel' mode--it will not look in /usr/include for any header files that are #included in your source 
#jun: files (this is mainly useful when you are using Cscope with operating system and/or C library source code, as we are here).
cscope -b -q -k
check_exit

#export CSCOPE_DB=$PROJECT_DB_PATH/cscope.out

echo "ok"


