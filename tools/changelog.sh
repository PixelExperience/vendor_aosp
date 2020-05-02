#!/bin/sh

export Changelog=Changelog.txt

if [ -f $Changelog ];
then
	rm -f $Changelog
fi

export formatter_script=$(realpath vendor/aosp/tools/changelog_repo_formatter.sh)

touch $Changelog

echo "Generating changelog..."

for i in $(seq 14);
do
export After_Date=`date --date="$i days ago" +%Y/%m/%d`
k=$(expr $i - 1)
	export Until_Date=`date --date="$k days ago" +%Y/%m/%d`

	# Line with after --- until was too long for a small ListView
	echo '=======================' >> $Changelog;
	echo  "     "$Until_Date       >> $Changelog;
	echo '=======================' >> $Changelog;
	echo >> $Changelog;

	# Cycle through every repo to find commits between 2 dates
	repo forall -c '. $formatter_script' >> $Changelog
	echo >> $Changelog;
done

cp $Changelog $OUT/system/etc/
cp $Changelog $OUT/
