#!/bin/bash

cd `dirname $0`

p=`pwd`

user_prefix=home/$USER/

for f in `find -type f ! -path './.git/*' ! -name '*.sw?' ! -path ./$(basename $0) -printf "%P\n"`
do
	if [[ "$f" =~ ^${user_prefix}* ]]
	then
		echo mkdir -p $(dirname /$f)
		echo ln -sf $p/$f /$f
	else
		echo sudo mkdir -p $(dirname /$f)
		echo sudo ln -sf $p/$f /$f
	fi
done
