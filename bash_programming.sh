#!/bin/bash

#when boot: Not strictly speaking, /etc/enviroment(usually NOT exists) --> /etc/profile --> $HOME/.profile --> $HOME/.bashrc.

#bash syntax: 
#    1) please not use /bin/sh, instead, use /bin/bash in the first line.
#    2) the compare of string uses '!=', '=='(or '='), '-z string', '-n string', '<', '>'
#    3) the compare of digital uses '-eq', '-ne', '-lt', '-le', '-gt', '-ge'
#    4) in if [ ], use -o(or), -a(and), !. not be &&, ||
#    5) NOTE: In bash file, 'make -p ~/XX' donot create XX dir in your home dir, be careful!!!. 
#             instead, use $HOME/XX.
#    6) [ ! -f "file" ]  :file don't exist
#       [ ! -d "dir" ]   :dir don't exist
#    7) $#: how many are there arguments?
#       $0: the bash script's name, if you input "source program.sh", then $0="bash". Be carefully
#       $n: the nth argument(n>0)
#       $*: all argument, split by space
#    8) for var in all_vars; do
#          ...
#       done
#    9) case "$VAR" in
#         value)
#             ...
#          	  ;;
#          *)
#             ...
#             ;;
#       esac

#useful command:
#    1) ls -l xxx | awk '{print $6$7}' | sed 's/-//g' | sed 's/://g'     : can display "201207191200"
#    2) find . -name "*.mk" | xargs grep "JUN"      : find JUN in the all *.mk
#    3) wc -l   : print the newline counts 
#    4) sed -i 'xxx' filename   :-i: in-place modify
#       echo "v1.0.1.jun.2006" | sed 's/.*\.//g'  :the result is "2006"
#       echo "v1.0.1.jun.2006" | sed 's/\.j.*//g' :the result is "v1.0.1"
#    5) awk 'NR==3' file   :gets the 3th line
#    6) dirname $0: gets the dir of $0, attention: if source xxx.sh, then $0=bash.
#    7) cd xxx;pwd: gets the absolute path.
