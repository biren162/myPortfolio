#FlexcabDeltaMerge.sh
if test -s ${RASHOME}/.passwd
	then
		
		JAVA_HOME=`grep -w "JAVAHOME" ${RASHOME}/.passwd | cut -f2 -d"="`
		export JAVA_HOME
		echo "JAVA_HOME:${JAVA_HOME}"
		
		RECLASSPATH=`grep -w "RECLASSPATH" ${RASHOME}/.passwd | cut -f2 -d"="`
		export RECLASSPATH
		echo "RECLASSPATH:${RECLASSPATH}"
		
		SQL_SERVER_HOME=`grep -w "SQL_SERVER_HOME" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SQL_SERVER_HOME
		echo "SQL_SERVER_HOME:${SQL_SERVER_HOME}"
		
		DEFAULT_PARAMETER=`grep -w "DEFAULT_PARAMETER" ${RASHOME}/.passwd | cut -f2 -d"="`
		export DEFAULT_PARAMETER
		echo "DEFAULT_PARAMETER:${DEFAULT_PARAMETER}"
		
		SERVER_NAME=`grep -w "SERVER_NAME" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SERVER_NAME
		echo "SERVER_NAME:${SERVER_NAME}"
		
		SQL_USR=`grep -w "SQL_USR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SQL_USR
		echo "SQL_USR:${SQL_USR}"
		
		SQL_PWD=`grep -w "SQL_PWD" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SQL_PWD
		echo "SQL_PWD:${SQL_PWD}"

		
		USERPASS=`grep -w "DBUSRPWD" ${RASHOME}/.passwd | cut -f2 -d"="`
		export USERPASS
		echo "USERPASS:${USERPASS}"
		
		BILLQADIR=`grep -w "BILLQADIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export BILLQADIR
		echo "BILLQADIR:${BILLQADIR}"
		
		GENDIR=`grep -w "GENDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export GENDIR
		echo "GENDIR:${GENDIR}"
		
		GENCONFIGDIR=`grep -w "GENCONFIGDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export GENCONFIGDIR
		echo "GENCONFIGDIR:${GENCONFIGDIR}"
		
		GENSQLDIR=`grep -w "GENSQLDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export GENSQLDIR
		echo "GENSQLDIR:${GENSQLDIR}"
		
		GENGRAPHDIR=`grep -w "GENGRAPHDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export GENGRAPHDIR
		echo "GENGRAPHDIR:${GENGRAPHDIR}"
		
		GENMETADATADIR=`grep -w "GENMETADATADIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export GENMETADATADIR
		echo "GENMETADATADIR:${GENMETADATADIR}"
		
		GENLOOKUPDIR=`grep -w "GENLOOKUPDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export GENLOOKUPDIR
		echo "GENLOOKUPDIR:${GENLOOKUPDIR}"
		
		GENSCRIPTDIR=`grep -w "GENSCRIPTDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export GENSCRIPTDIR
		echo "GENSCRIPTDIR:${GENSCRIPTDIR}"
		
		LOGDIR=`grep -w "LOGDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export LOGDIR
		echo "LOGDIR:${LOGDIR}"
		
		SRCLOOKUPDIR=`grep -w "SRCLOOKUPDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SRCLOOKUPDIR
		echo "SRCLOOKUPDIR:${SRCLOOKUPDIR}"
		
		SHAREDSRCDIR=`grep -w "SHAREDSRCDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SHAREDSRCDIR
		echo "SHAREDSRCDIR:${SHAREDSRCDIR}"
		
		SHAREDRAWFAILEDDIR=`grep -w "SHAREDRAWFAILEDDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SHAREDRAWFAILEDDIR
		echo "SHAREDRAWFAILEDDIR:${SHAREDRAWFAILEDDIR}"
		
		SHAREDRAWPROCESSEDDIR=`grep -w "SHAREDRAWPROCESSEDDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SHAREDRAWPROCESSEDDIR
		echo "SHAREDRAWPROCESSEDDIR:${SHAREDRAWPROCESSEDDIR}"
		
		SHAREDRAWREADYDIR=`grep -w "SHAREDRAWREADYDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SHAREDRAWREADYDIR
		echo "SHAREDRAWREADYDIR:${SHAREDRAWREADYDIR}"
		
		SHAREDBILLQAEXCEPTIONDIR=`grep -w "SHAREDBILLQAEXCEPTIONDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SHAREDBILLQAEXCEPTIONDIR
		echo "SHAREDBILLQAEXCEPTIONDIR:${SHAREDBILLQAEXCEPTIONDIR}"
		
		SHAREDBILLQAPROCESSEDDIR=`grep -w "SHAREDBILLQAPROCESSEDDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SHAREDBILLQAPROCESSEDDIR
		echo "SHAREDBILLQAPROCESSEDDIR:${SHAREDBILLQAPROCESSEDDIR}"

		SHAREDGENLOOKUPDIR=`grep -w "SHAREDGENLOOKUPDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SHAREDGENLOOKUPDIR
		echo "SHAREDGENLOOKUPDIR:${SHAREDGENLOOKUPDIR}"
		
		SHAREDBILLQAREADYDIR=`grep -w "SHAREDBILLQAREADYDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SHAREDBILLQAREADYDIR
		echo "SHAREDBILLQAREADYDIR:${SHAREDBILLQAREADYDIR}"
		
		SHAREDLOGDIR=`grep -w "SHAREDLOGDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SHAREDLOGDIR
		echo "SHAREDLOGDIR:${SHAREDLOGDIR}"
		
		TEMPSORTINGDIR=`grep -w "TEMPSORTINGDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export TEMPSORTINGDIR
		echo "TEMPSORTINGDIR:${TEMPSORTINGDIR}"
		
		RAWDIR=`grep -w "RAWDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export RAWDIR
		echo "RAWDIR:${RAWDIR}"
		
		RAWCONTRACTDIR=`grep -w "RAWCONTRACTDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export RAWCONTRACTDIR
		echo "RAWCONTRACTDIR:${RAWCONTRACTDIR}"
		
		RAWOCTDIR=`grep -w "RAWOCTDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export RAWOCTDIR
		echo "RAWOCTDIR:${RAWOCTDIR}"
		
		RAWBILLINGDIR=`grep -w "RAWBILLINGDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export RAWBILLINGDIR
		echo "RAWBILLINGDIR:${RAWBILLINGDIR}"
		
		RAWFAILEDDIR=`grep -w "RAWFAILEDDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export RAWFAILEDDIR
		echo "RAWFAILEDDIR:${RAWFAILEDDIR}"
		
		RAWPROCESSEDDIR=`grep -w "RAWPROCESSEDDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export RAWPROCESSEDDIR
		echo "RAWPROCESSEDDIR:${RAWPROCESSEDDIR}"
		
		RAWREADYDIR=`grep -w "RAWREADYDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export RAWREADYDIR
		echo "RAWREADYDIR:${RAWREADYDIR}"
		
		BILLQAPROCESSEDDIR=`grep -w "BILLQAPROCESSEDDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export BILLQAPROCESSEDDIR
		echo "BILLQAPROCESSEDDIR:${BILLQAPROCESSEDDIR}"
		
		BILLQAEXCEPTIONDIR=`grep -w "BILLQAEXCEPTIONDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export BILLQAEXCEPTIONDIR
		echo "BILLQAEXCEPTIONDIR:${BILLQAEXCEPTIONDIR}"
		
		BILLQAREADYDIR=`grep -w "BILLQAREADYDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export BILLQAREADYDIR
		echo "BILLQAREADYDIR:${BILLQAREADYDIR}"
		
		SLEEPTIME=`grep -w "SLEEPTIME" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SLEEPTIME
		echo "SLEEPTIME :${SLEEPTIME}"
		
		SLEEPLOOPTIME=`grep -w "SLEEPLOOPTIME" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SLEEPLOOPTIME
		echo "SLEEPLOOPTIME :${SLEEPLOOPTIME}"
		
		SLEEPCOUNT=`grep -w "SLEEPCOUNT" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SLEEPCOUNT
		echo "SLEEPCOUNT :${SLEEPCOUNT}"
		
		SQL_DBO=`grep -w "SQL_DBO" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SQL_DBO
		echo "SQL_DBO :${SQL_DBO}"
		
		NO_OF_SERVER=`grep -w "NO_OF_SERVER" ${RASHOME}/.passwd | cut -f2 -d"="`
		export NO_OF_SERVER
		echo "NO_OF_SERVER : ${NO_OF_SERVER}"
		
	else
		echo ".passwd FILE DOESNOT EXISTS IN HOME DIRECTORY"
		echo "TERMINATING THE EXECUTION OF THE PROCESS BillIDGenerate.sh"
		exit 1
fi

DBCONNECTIONTYPE="SQLSERVER"
export DBCONNECTIONTYPE
#include functions.sh
. /trans_prod/BILLQAENV/GEN/SRC/EXE/SCRIPT/bqa_functions.sh 

CURRENTDATE=`date '+%Y%m%d%H%M%S'`
#CURRENTDATETIME=`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`
export CURRENTDATE

CURRENTDATE_SQL=`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`
export CURRENTDATE_SQL
INTF_CONFIG=${GENCONFIGDIR}/BQA_INTF_CONFIG.CFG
export INTF_CONFIG

LOGFILE=${LOGDIR}/billing_qa_process_db_connection_${CURRENTDATE}.log
export LOGFILE
echo "FIRST DB CONNECTION LOGFILE:${LOGFILE}"

BILLINGIDSPOOLFILE=${LOGDIR}/billing_qa_process_billing_id_spoolfile_${CURRENTDATE}.log

# Fetching the new BILLING ID for the process
echo "FETCHING MAXIMUM BILLING ID" >> ${LOGFILE}

#part of merge logic start **********
line1=$1
parition=$2
lastPartition=$3
BILLINGID=$4
DATEbiren=`date '+%Y%m%d'`
mergeLog=${BILLQAREADYDIR}/${BILLINGID}/FlexcabMergeLog_${BILLINGID}_${DATEbiren}.log
temppath=${BILLQAREADYDIR}/${BILLINGID}/
fileType=$(echo $line1|cut -d"," -f2)
fileCode=$(echo $line1|cut -d"," -f1)
echo "----------------------mergegin started for fileCode:${fileCode}--------------------------" >> ${mergeLog}
basePath=`grep -w "FLEXCAB_MERGE_INPUT_BASE_PATH" ${RASHOME}/.passwd | cut -f2 -d"="`
deltaPath=`grep -w "FLEXCAB_MERGE_INPUT_DELTA_PATH" ${RASHOME}/.passwd | cut -f2 -d"="`
#basePath="/trans_cat/BILLQAENV/tmp/Biren/MERGE_SCRIPT/Testing7_final_Problem/base/"
#deltaPath="/trans_cat/BILLQAENV/tmp/Biren/MERGE_SCRIPT/Testing7_final_Problem/delta/"


if [ "${fileCode}" == "FMIP0027" ]
then
deltaTemp1=$deltaPath"FLEXCAB.REFERENCE."$fileCode".EXTRACT.20??????.dat"
else
deltaTemp1=$deltaPath"FLEXCAB.REFERENCE."$fileCode".EXTRACT.20??????"
fi



deltaTemp2=$deltaPath"FLEXCAB.REFERENCE."$fileCode".EXTRACT.20????????"

deltaf1=$( ls -1 $deltaTemp1) 
deltaf2=$( ls -1 $deltaTemp2) 

if [ -z "$deltaf1"  ] && [ -z "$deltaf2" ]
then
exit 1
fi

recordLen=$(echo $line1|cut -d"," -f4)



#part of merge logic EDN   **********




START_PROCESS=`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`
pID=MERGE001
QUERY_LOG_FILE=${BILLQAREADYDIR}/${BILLINGID}/FlexcabMergeSQLLog_${BILLINGID}_${DATEbiren}.log

if  (($parition != -1)) 
	then
	db_connection "Q0010" "${QUERY_LOG_FILE}" "${BILLINGID};${pID};${START_PROCESS};STARTED;FLEXCAB_MERGE_PROCESS_STARTED;${fileCode}${parition}" 
	else
	db_connection "Q0010" "${QUERY_LOG_FILE}" "${BILLINGID};${pID};${START_PROCESS};STARTED;FLEXCAB_MERGE_PROCESS_STARTED;${fileCode}" 
fi





	RETCODE_INSERTCHECK=$?
if [ ${RETCODE_INSERTCHECK} -ne 0 ]
then
	echo "FAILED WHILE INSERTING DETAILS IN : BQA_BILLING_PROC_STATUS" >> ${LOGFILE}
	echo "TERMINATING THE EXECUTION OF THE PROCESS BillIDGenerate.sh" >> ${LOGFILE}
	exit 1
fi

#merge logic start************************************************	
#multiple Key start



if [ "${fileType}" == "R" ]   #simply replace ref. file
then
	echo "FILETYPE                        : REF."  >> ${mergeLog}
	
	#echo "before awk deltaf: ${deltaf}"  >> tempLG
	if [ "${fileCode}" == "FMIP0027" ]
	then
		control=$deltaPath"FLEXCAB.REFERENCE."$fileCode".EXTRACT.20??????.ctl"
		eof=$deltaPath"FLEXCAB.REFERENCE."$fileCode".EXTRACT.20??????.eot"
		controlf=$( ls -1 $control) 
		eoff=$( ls -1 $eof) 
		deltaTemp=$deltaPath"FLEXCAB.REFERENCE."$fileCode".EXTRACT.20??????.dat"
		baseTemp=$basePath"FLEXCAB.REFERENCE."$fileCode".INITIAL.20??????.dat"
	else
		deltaTemp=$deltaPath"FLEXCAB.REFERENCE."$fileCode".???????.20??????"
		baseTemp=$basePath"FLEXCAB.REFERENCE."$fileCode".INITIAL.20??????"
	fi
	basef=$( ls -1 $baseTemp) 
	deltaf=$( ls -1 $deltaTemp) 
	
	mawk -v fileCode="$fileCode" -v controlf="$controlf" -v eoff="$eoff" -v recordLen="$recordLen" -v mergeLog="$mergeLog" 'BEGIN{
		REC_COUNT_Delta = 0
		headerFound = "F"
		trailerFound = "F"
		dataFound ="T"
	#	print "awk BEGIN" >> "tempLG"
		control_count = 0
		data_count = 0
		if(controlf != ""){
			while( getline < controlf){
				control_count = $1 + 0
			}
		}
	}
	{
		if(fileCode == "FMIP0027"){
			
			if(eoff == ""){
			#	print "Eot_File_Not_Found" >> "tempLG"
				print "Eot_File_Not_Found" > "'${temppath}'failReason" 
				exit_invoked=1
				exit 1
			}
			else if(controlf == ""){
			#	print "Control_File_Not_Found" >> "tempLG"
				print "Control_File_Not_Found" > "'${temppath}'failReason"
				exit_invoked=1
				exit 1
			}
			else{	
					line=$0
					REC_ID=substr(line,1,1)
					if(NR == 1 && substr(line,10,7) == "FCBPRD1"){
						data_count = data_count + 1 
						headerFound ="T"
					#	print "header found" >> "tempLG"
						
					}
					else if( substr(line,2,7) == "FCBPRD1" ){
						data_count = data_count + 1 
						trailerFound  ="T"
					#	print "trailer found" >> "tempLG"
					}
					else if( line != "" ){
						data_count = data_count + 1 
						dataFound  ="T"
					#	print "data found"  >> "tempLG"
						
						if((length) != (recordLen + 0)){
						#print "length:" length "& recordLen:" recordLen + 0    >> "tempLG"
						#print "Record_Length_Does_Not_Match#">> "tempLG"
						print "Record_Length_Does_Not_Match" > "'${temppath}'failReason"				
						print "record length does not match error" >> mergeLog
						exit_invoked=1
						exit 1				
						}
					}
			
			}
		
		
		}
		else{		 
			 REC_ID=substr($0,1,1)
			 #DATA=substr($0,6,)
			 #PRIMARY_KEY=substr($0,2,4)	
			 
			 
			if(REC_ID == 0){
				headerFound ="T"
				#print "header found" >> "tempLG"
			}
			else if(REC_ID == 1){
				
				dataFound  ="T"
				#print "data found" >> "tempLG"
					if((length) != (recordLen + 0)){
					#print "length:" length "& recordLen:" recordLen + 0   >> "tempLG"
					#print "Record_Length_Does_Not_Match#">> "tempLG"
					print "Record_Length_Does_Not_Match" > "'${temppath}'failReason"					
					print "record length does not match error" >> mergeLog
					exit_invoked=1
					exit 1				
					}
				REC_COUNT_Delta=REC_COUNT_Delta+1
			}		
			else if(REC_ID == 9){   
				trailerFound  ="T"
				#print "trailer found"  >> "tempLG"
				REC_COUNT_Trailer=substr($0,10,18)+0
			}
		}
	
	}
	END{
		#print "REC_COUNT_Trailer:"REC_COUNT_Trailer >> "tempLG"
		#print "REC_COUNT_Delta:"REC_COUNT_Delta    >> "tempLG"
		if(! exit_invoked ){
		if(headerFound == "F"){
			#print "Header_Not_Found_Error" >> "tempLG"
			print "Header_Not_Found_Error" > "'${temppath}'failReason"
			exit 1
			}
		else if(trailerFound == "F"){
			#print "Trailer_Not_Found_Error" >> "tempLG"
			print "Trailer_Not_Found_Error" > "'${temppath}'failReason"
			exit 1
			}
		else if( REC_COUNT_Trailer != REC_COUNT_Delta ){
			#print "REC_COUNT_Trailer*:"REC_COUNT_Trailer  >> "tempLG"
			#print "REC_COUNT_Delta*:"REC_COUNT_Delta >> "tempLG"
			#number of records does not match with trailer.
				success="F"
				print "Total_Records_Count_Does_Not_Match_With_Count_Given_In_Trailer" >> mergeLog
				print "Total_Records_Count_Does_Not_Match_With_Count_Given_In_Trailer"  > "'${temppath}'failReason"
				exit 1
		}
		else if( control_count != data_count){
			#print "control_count:" control_count " data_count:" data_count >> "tempLG"
			#print "Total_Records_Count_Does_Not_Match_With_Count_Given_In_Control" >> "tempLG"
			print "Total_Records_Count_Does_Not_Match_With_Count_Given_In_Control" > "'${temppath}'failReason"
			exit 1
		}
		}
	}' $deltaf
	
	#echo "after awk" >> tempLG
	if [ -f ${temppath}failReason ] 
	 then
	 reason=$(<"${temppath}failReason")
	 #echo "reason: ${reason}" >> tempLG
	 rm ${temppath}failReason
	# echo "making fail entry" >> tempLG
	 db_connection "Q0012" "${QUERY_LOG_FILE}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;FAIL;${reason};${BILLINGID};${fileCode};${pID}"
	# echo "after making fail entry" >> tempLG	
	else

	#echo "now moving actual ref. file" >> tempLG
	mv $deltaf $basef
	
	lastCommand=$?
	if [ ${lastCommand} -ne 0 ]
	then
		db_connection "Q0012" "${QUERY_LOG_FILE}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;FAIL;FLEXCAB_MERGE_PROCESS_FAILED;${BILLINGID};${fileCode};${pID}"	
		
			RETCODE_INSERTCHECK=$?
		if [ ${RETCODE_INSERTCHECK} -ne 0 ]
		then
			echo "FAIL WHILE updating failure status for Ref. file : BQA_BILLING_PROC_STATUS" >> ${LOGFILE}
			echo "TERMINATING THE EXECUTION OF THE PROCESS BillIDGenerate.sh" >> ${LOGFILE}
			exit 1
		fi
	else
		echo $basef " has been replaced successfully. with "$deltaf

		#insert log in db 
		db_connection "Q0012" "${QUERY_LOG_FILE}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;SUCCESS;FLEXCAB_MERGE_PROCESS_SUCCESS;${BILLINGID};${fileCode};${pID}"
		
			RETCODE_INSERTCHECK=$?
		if [ ${RETCODE_INSERTCHECK} -ne 0 ]
		then
			echo "FAILED WHILE updating success status for Ref. file : BQA_BILLING_PROC_STATUS" >> ${LOGFILE}
			echo "TERMINATING THE EXECUTION OF THE PROCESS BillIDGenerate.sh" >> ${LOGFILE}
			exit 1
		fi
	
	fi
	fi
exit 1
elif [ "${fileType}" != "T" ]  #merging of delta file
then
echo "Invalid filetype in Congif file, It must be either T or R" >> ${mergeLog}
exit 1
fi	

echo "FILETYPE                        : Transaction."  >> ${mergeLog}



success="T"
reason=""

if  (($parition == -1)) 
then
	baseTemp=$basePath"FLEXCAB.REFERENCE."$fileCode".INITIAL.20??????"
else
	baseTemp=$basePath"FLEXCAB.REFERENCE."$fileCode".INITIAL.20??????"$parition
		
fi

deltaTemp=$deltaPath"FLEXCAB.REFERENCE."$fileCode".???????.20??????"

if  (($parition != -1)) 
then
    fileCode=$fileCode""$parition 
fi


basef=$( ls -1 $baseTemp) 
#outputFileName=$( echo $basef | rev | cut  -d'/' -f 1 | rev)
deltaf=$( ls -1 $deltaTemp) 
cc=$(echo $line1|cut -d"," -f2)
pks=$(echo $line1|cut -d"," -f3)
#IFS=': ' read -r -a pkArr <<< $pks
#multiple Key end


start=$(($recordLen+1))
len=10
declare -A countArray

touch ${temppath}baseheader.txt
touch ${temppath}tempCount.txt
touch ${temppath}basetrailer.txt
echo "empty baseHeader tempCount baseTrailer file created " >> ${mergeLog}
mawk -F"," -v start="$start" -v clen="$len" -v pks="$pks" -v deltaf="$deltaf" -v basef="$basef" -v parition="$parition" -v last="$lastPartition" -v success="$success" -v mergeLog="$mergeLog" 'BEGIN{
	print "******BEGIN******" >> mergeLog
	print "first awk begin reading delta file into array" >> mergeLog
	trailerFound = "F"
	headerFound  = "F"
	dataFound    = "T"
	REC_COUNT_Trailer = 0
	REC_COUNT_Delta = 0
	#print deltaf >> "tempLog"
	while (getline < deltaf)
	{	
		#multiple Key start
		split(pks,pksArr,":")
		PRIMARY_KEY=""
		for (key in pksArr) { 
			split(pksArr[key],startLenArr,"-")
			#print startLenArr[1] "&"startLenArr[2] 
			PRIMARY_KEY=PRIMARY_KEY""substr($0,startLenArr[1],startLenArr[2])
		 }
		 print "pk:" PRIMARY_KEY
		#multiple Key end
	
		 REC_ID=substr($0,1,1)
		 #DATA=substr($0,6,)
		 #PRIMARY_KEY=substr($0,2,4)
		if(REC_ID == 0){
			headerFound ="T"
		}	
		 
		else if(REC_ID == 1)
		{   
			dataFound ="T"
			
			if((length) != (start-1)){
			#print "file_length:" length >> "tempLog"
			#print "IASS_length:" start-1 >> "tempLog"
			success="F"
			#print "Record_Length_Does_Not_Match#">> "tempLog"
			print "Record_Length_Does_Not_Match" > "'${temppath}'failReason"
			#reason="record_length_does_not_match_for_line:" NR
			
			#system ("db_connection ""Q0012" ${QUERY_LOG_FILE} "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;FAIL;"${reason}";"${BILLINGID}";"${fileCode}";"${pID})
			print "record length does not match error" >> mergeLog
			exit 1
			
			}
			ARRAY[PRIMARY_KEY]=$0
			REC_COUNT_Delta=REC_COUNT_Delta+1
		}
		else if (REC_ID == 9){
			trailerFound ="T"
			REC_COUNT_Trailer=substr($0,10,18)+0
		}	
		
	}
	if(headerFound == "F"){
		#header not found
		#print "header not found" >> "tempLog"
		print "header not found error" >> mergeLog
			success="F"
			print "Header_Not_Found"  >  "'${temppath}'failReason"
			exit 1
	}
	else if(dataFound == "F"){
		#data not found
		print "data not found error" >> mergeLog
			success="F"
			print "Data_Not_Found"  >  "'${temppath}'failReason"
			exit 1
	}
	else if(trailerFound == "F"){
		#trailer not found
		#print "trailer not found" >> "tempLog"
		print "trailer not found error" >> mergeLog
			success="F"
			print "Trailer_Not_Found"  >  "'${temppath}'failReason"
			#reason="Trailer_Not_Found" 
			#system ("db_connection ""Q0012" ${QUERY_LOG_FILE} "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;FAIL;"${reason}";"${BILLINGID}";"${fileCode}";"${pID})
		
			exit 1
	}
	else if(REC_COUNT_Trailer != REC_COUNT_Delta){
		#print "REC_COUNT_Trailer:"REC_COUNT_Trailer  >> "tempLog"
		#print "REC_COUNT_Delta:"REC_COUNT_Delta >> "tempLog"
		#number of records does not match with trailer.
			success="F"
			print "Total_Records_Count_Does_Not_Match_With_Count_Given_In_Trailer" >> mergeLog
			print "Total_Records_Count_Does_Not_Match_With_Count_Given_In_Trailer"  > "'${temppath}'failReason"
			exit 1
	}
		print "*****end*******" >> mergeLog
		print "first awk BEGIN end" >> mergeLog
		#print "#####start_delta:"deltaf  >> "tempLG"
}
	{       
		if(NR==1){
		print "first awk body printing header in baseHeader.txt and same for trailer and storing count with pk in tempCount.txt" >> mergeLog
		}
		REC_ID=substr($0,1,1)
		#DATA=substr($0,3,4)
		#multiple Key start
		split(pks,pksArr,":")
		PRIMARY_KEY=""
		for (key in pksArr) { 
		split(pksArr[key],startLenArr,"-")
			PRIMARY_KEY=PRIMARY_KEY""substr($0,startLenArr[1],startLenArr[2])
		 }
		#multiple Key end
		
		#print  REC_ID " " last " " parition  >> "tempLG"
		if(REC_ID == 0)
		{
			print $0 > "'${temppath}'baseheader.txt"
		}
		else if(REC_ID==9)
		{
			print $0 > "'${temppath}'basetrailer.txt"
		}
		else if( REC_ID == 1 || ( parition == last && parition != -1))
		{
			#print "ARRAY["PRIMARY_KEY"]="ARRAY[PRIMARY_KEY] >> "tempLG"
			if(ARRAY[PRIMARY_KEY] == "")
			{
				print $0  >> "'${temppath}'baseheader.txt"
			}
			else {
				#start validation As_Per_Delta_Indicator_Operation_To_Be_Performed_Is_Insert_But_Actual_Operation_Performed_Is_Update		
				#if( parition == -1 && "'"$fileCode"'" != "T04237" && "'"$fileCode"'" != "T04676"){
				#deltaInd=substr(ARRAY[PRIMARY_KEY],start-1,1)
				#print "update_delta Ind:"deltaInd >> "tempLG"
					#if(deltaInd == "I"){
					#print "As_Per_Delta_Indicator_Operation_To_Be_Performed_Is_Insert_But_Actual_Operation_Performed_Is_Update"  >  "'${temppath}'failReason"
					#exit 1
					#}
				#}
				#end validation
				count=substr($0,start,clen)
				#print "pk,count,start,clen:"PRIMARY_KEY","count","start","clen >>mergeLog
				print PRIMARY_KEY","count >> "'${temppath}'tempCount.txt"
				
				}

			
			
			
		}
					
		}' $basef
		
#count=$(wc -l baseheader.txt | cut -d" " -f1)
#echo "count 1awk:"count
#count_baseheader=`expr $count - 1`
#echo $count_baseheader
#if first awk fail than do not run second awk
if [ -f ${temppath}failReason ] 
then
	parition=-999
fi
echo "partition:" $parition >> ${mergeLog}
echo "lastPartition:" $lastPartition >> ${mergeLog}
if  (($parition == $lastPartition)) 
then
	echo  "++++before second awk" >> ${mergeLog}
	mawk -F"," -v start="$start" -v clen="$len" -v pks="$pks" -v parition="$parition" -v countTrailer="0" -v mergeLog="$mergeLog" 'function repl(s,f,t,v){ 

	return sprintf("%-*s",f-1,substr(s,1,f-1)) sprintf("%-*s", t-f+1, v) substr(s,t+1) 
	}
	BEGIN{
		print "reading tempcount.txt into array" >> mergeLog
		while (getline < "'${temppath}'tempCount.txt")
		{	
			countArr[$1]=$2
			
		}
		
		print "second awk body will start" >> mergeLog
	}

	{

	
		REC_ID=substr($0,1,1)
		#multiple Key start
				split(pks,pksArr,":")
				PRIMARY_KEY=""
				for (key in pksArr) { 
				split(pksArr[key],startLenArr,"-")
					PRIMARY_KEY=PRIMARY_KEY""substr($0,startLenArr[1],startLenArr[2])
				 }

		#print "PK:::::"PRIMARY_KEY
		#multiple Key end
		
		if (REC_ID == 1)
		{
			
		Delta_array[PRIMARY_KEY]= $0
		countArr[PRIMARY_KEY]=countArr[PRIMARY_KEY]+1
		#print "@@@@@CountArr:"countArr[PRIMARY_KEY] 
			if(countArr[PRIMARY_KEY] == 1){
				countTrailer=countTrailer+1
				#print "countTrailer INc:"countTrailer
			}

		}
		else if (REC_ID == 0){
			date= substr($0,2,8)
		}

	}

	END{     
	print "++++second awk END countTrailer:"countTrailer  >> mergeLog
						#count=0

							for (x in Delta_array)
							{		#print "~~~~~~~~~~~~~~~~~"	
									#print Delta_array[x] countArr[x] date >> "baseheader.txt"
									# start validation As_Per_Delta_Indicator_Operation_To_Be_Performed_Is_Update_But_Actual_Operation_Performed_Is_Insert
									#if( parition == -1 && "'"$fileCode"'" != "T04237" && "'"$fileCode"'" != "T04676"){
									#deltaInd=substr(Delta_array[x],start-1,1)
									#	if( countArr[x] == 1 && deltaInd == "U" ) {
									#		print "As_Per_Delta_Indicator_Operation_To_Be_Performed_Is_Update_But_Actual_Operation_Performed_Is_Insert"  >  "failReason"
									#		exit 1
									#	}
									#	else if ( countArr[x] == 1 && deltaInd == "D" ) {
									#		print "As_Per_Delta_Indicator_Operation_To_Be_Performed_Is_Delete_But_Record_Is_Not_Present"  >  "failReason"
									#		exit 1
									#	}
									#}
									# end validation
									print repl(Delta_array[x],start,start+clen-1,countArr[x])date>> "'${temppath}'baseheader.txt"           
										#count=count+1
										#if(countArr[x] == 1){
										#count=count+1
										#}
										
							}
							while (getline < "'${temppath}'basetrailer.txt")
							{
								
								REC_ID=substr($0,1,1)
								DATE=substr($0,2,8)
								print "old count:#" substr($0,10,18)
								REC_COUNT=substr($0,10,18)+countTrailer
								#REC_COUNT=countTrailer
	
								FILLERS=substr($0,19,20)

								  print REC_ID DATE REC_COUNT FILLERS >> "'${temppath}'baseheader.txt"
							}
							
							

	}' $deltaf

	if [ -f ${temppath}tempCount.txt ] ; then rm ${temppath}tempCount.txt
	fi
	if [ -f ${temppath}basetrailer.txt ] ; then rm ${temppath}basetrailer.txt
	fi

fi


#mv $basef base.txt_old
if [ -f ${temppath}failReason ] 
then
	if [ -f ${temppath}tempCount.txt ] ; then rm ${temppath}tempCount.txt
	fi
	if [ -f ${temppath}basetrailer.txt ] ; then rm ${temppath}basetrailer.txt
	fi
	if [ -f ${temppath}baseheader.txt ] ; then rm ${temppath}baseheader.txt
	fi
else
mv ${temppath}baseheader.txt $basef
fi
#mv baseheader.txt $outputPath$outputFileName


#if [ -f "base.txt_old" ] ; then rm base.txt_old
#fi

if [ -f ${temppath}failReason ] 
 then
 reason=$(<"${temppath}failReason")
 #echo "*"$reason >> "tempLog"
 rm ${temppath}failReason
 db_connection "Q0012" "${QUERY_LOG_FILE}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;FAIL;${reason};${BILLINGID};${fileCode};${pID}"
 
else
	db_connection "Q0012" "${QUERY_LOG_FILE}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;SUCCESS;FLEXCAB_MERGE_PROCESS_SUCCESS;${BILLINGID};${fileCode};${pID}"
	
		RETCODE_INSERTCHECK=$?
	if [ ${RETCODE_INSERTCHECK} -ne 0 ]
	then
		echo "FAILED WHILE updating DETAILS IN : BQA_BILLING_PROC_STATUS" >> ${LOGFILE}
		echo "TERMINATING THE EXECUTION OF THE PROCESS BillIDGenerate.sh" >> ${LOGFILE}
		exit 1
	fi  

fi

#merge logic end ***********************************************************************************	
echo  "merging of file "$deltaf " ended" >> ${mergeLog}
echo "============================================================================" >> ${mergeLog}
