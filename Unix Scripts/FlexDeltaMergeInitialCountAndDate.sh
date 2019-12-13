#FlexDeltaMergeInitialCountAndDate.sh
#gunzip /trans_cat/BILLQAENV/tmp/Biren/MERGE_SCRIPT/addCountAndDate2Base/base/*
#stat=$?
#if [ $stat -ne 0 ]
#then
# 	echo "error while unzipping base files."
#fi

GENCONFIGDIR=`grep -w "GENCONFIGDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
basePath=`grep -w "FLEXCAB_MERGE_INPUT_BASE_PATH" ${RASHOME}/.passwd | cut -f2 -d"="`
configFile=${GENCONFIGDIR}/FLEXCABResourceMergeConfig.config
while  read -r line
do 

count=10 
date=`date '+%Y%m%d'`


fileCode=$(echo $line | cut -d"," -f1)
filetype=$(echo $line | cut -d"," -f2)

if [ "${filetype}" == "T" ]
then
	#recLen=$(echo $line | cut -d"," -f4)
	
	baseTemp=$basePath"FLEXCAB.REFERENCE."$fileCode".INITIAL.20??????"
	basef=$( ls -1 $baseTemp) 


	if [ -z $basef ]
	then
	echo ""
	else

		awk -F, -v count="$count" -v date="$date" '{
		line=$0
		REC_ID=substr(line,1,1)
			if(REC_ID == 1){
			c=sprintf("%.*d",count,1)
			#line1=line c date
			#line1=sprintf("%s%.*d%s",line,count,1,date)
			#print line1 > "cool"
			print $0 c date > "cool"

			}
			else{
			 print $0 > "cool"
			}


		}' $basef

		mv "cool" $basef
	fi
fi
done < $configFile