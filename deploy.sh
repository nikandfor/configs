#!/bin/bash

set -ue

cd `dirname $0`

p=`pwd`

user_prefix=home/$USER/

echo "# usage: . <($0)"

for f in `find -type f ! -path './.git/*' ! -name '*.sw?' ! -path ./$(basename $0) -printf "%P\n"`; do
	dir=$( dirname "/$f" )

	if [[ "$f" =~ ^${user_prefix}* ]]
	then
		[[ $( readlink "/$f" ) == $p/$f ]] && continue

		[ -d "$dir" ] || echo mkdir -p "$dir"
		echo ln -sf $p/$f /$f
	else
		[ -f "/$f" ] && diff "/$f" "$p/$f" >/dev/null && continue

		[ -d "$dir" ] || echo sudo mkdir -p "$dir"
		echo sudo ln -sf $p/$f /$f
	fi
done
