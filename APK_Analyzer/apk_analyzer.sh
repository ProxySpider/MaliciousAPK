#By @echavarro
#usage apk_analyzer.sh <samples_folder>
#This script creates a sqlite database with the information for apk package and permissions and thre results from VT.

dbname="androsamples.db"
if [ ! -f $dbname ]; then
	echo "{!} Creating database $dbname using androsamples_sql.sql script" | tee APKAnalysis.log
	sqlite3 $dbname < androsamples_sql.sql
fi

for file in $(ls $1); do 
	echo "{+} Analyzing file $file" | tee -a APKAnalysis.log
	package=`aapt dump permissions $1/$file |grep package:|awk '{print $2}';`
	permissions=`aapt dump permissions $1/$file |grep -v package:|awk -F\' '{print $2}';`
#	rm -r ./tmp/*.dex
#	for dex in $(aapt list $1/$file|grep "\.dex"); do
#		unzip -j  $1/$file $dex -d ./tmp/
#	done
#	echo "	Storing collected dex strings on file strings_dex.data" | tee -a APKAnalysis.log
#	strings -n10 ./tmp/*.dex|sort|uniq >> strings_dex.data
	md5="$(md5sum $1/$file |awk '{print $1}')"
	echo "	Requesting information for sample on VirusTotal" | tee -a APKAnalysis.log
	positives=0
	last_scan=""
	read positives last_scan verdict <<< $(python vt_request.py $md5)
	echo "	Storing collected information into database $dbname" | tee -a APKAnalysis.log
	echo "insert into androsamples (md5, VTpositives,package,permissions,last_scan,verdict,positives) values ('$md5',$positives,'$package','$permissions','$last_scan','$verdict',1);" > ./tmp/sql.tmp
	sqlite3 $dbname < ./tmp/sql.tmp
	echo ""|tee -a APKAnalysis.log
done
