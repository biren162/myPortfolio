#FlexcabMergeFieldValidationZIP.sh
#-------------------------------Developed_By_BIREN_PATEL-------------------------------------------------
#filePath="/trans_cat/BILLQAENV/tmp/Biren/MERGE_VALIDATION_SCRIPT/REFERENCE/"
param=$1
if [ -z $param ]
	then
	echo "please pass parameter as EXTRACT or INITIAL"
	exit 1
fi
if [ $param == "INITIAL" ]
then
	filePath=`grep -w "FlX_VAL_INPUT_PATH_INITIAL" ${RASHOME}/.passwd | cut -f2 -d"="`
	filePath2=`grep -w "FLX_VAL_INTERMEDIATE_PATH_INITIAL" ${RASHOME}/.passwd | cut -f2 -d"="`
	FILE_TYPE="INITIAL"
else
	filePath=`grep -w "FLX_VAL_INPUT_PATH_EXTRACT" ${RASHOME}/.passwd | cut -f2 -d"="`
	filePath2=`grep -w "FLX_VAL_INTERMEDIATE_PATH_EXTRACT" ${RASHOME}/.passwd | cut -f2 -d"="`
	FILE_TYPE="EXTRACT"
fi




if test -s ${RASHOME}/.passwd
then
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
		
		LOGDIR=`grep -w "LOGDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export LOGDIR
		echo "LOGDIR:${LOGDIR}"
		
		SHAREDSRCDIR=`grep -w "SHAREDSRCDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SHAREDSRCDIR
		echo "SHAREDSRCDIR:${SHAREDSRCDIR}"
		
		SHAREDRAWREADYDIR=`grep -w "SHAREDRAWREADYDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SHAREDRAWREADYDIR
		echo "SHAREDRAWREADYDIR:${SHAREDRAWREADYDIR}"
		
		BILLQAREADYDIR=`grep -w "BILLQAREADYDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export BILLQAREADYDIR
		echo "BILLQAREADYDIR:${BILLQAREADYDIR}"
		
		GENCONFIGDIR=`grep -w "GENCONFIGDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export GENCONFIGDIR
		echo "GENCONFIGDIR:${GENCONFIGDIR}"

else
		echo ".passwd FILE DOESNOT EXISTS IN HOME DIRECTORY"
		echo "TERMINATING THE EXECUTION OF THE PROCESS BillIDGenerate.sh"
		exit 1
fi


	CURRENTDATE=`date '+%Y%m%d%H%M%S'`
	val_Log=${LOGDIR}/flexcab_delta_merge_validation_${CURRENTDATE}.log
	echo $CURRENTDATE >> ${val_Log}

#configPath="/trans_cat/BILLQAENV/GEN/SRC/EXE/CFG/CONFIG/"
DBCONNECTIONTYPE="SQLSERVER"
export DBCONNECTIONTYPE
echo ${DBCONNECTIONTYPE}
#include functions.sh
. /trans_prod/BILLQAENV/GEN/SRC/EXE/SCRIPT/bqa_functions.sh

#billing ID generation start-biren
	CURRENTDATE=`date '+%Y%m%d%H%M%S'`
	export CURRENTDATE
	LOGFILE=${LOGDIR}/billing_qa_process_db_connection_${CURRENTDATE}.log
	export LOGFILE
	echo "FIRST DB CONNECTION LOGFILE:${LOGFILE}" 	
	BILLINGIDSPOOLFILE=${LOGDIR}/billing_qa_process_billing_id_spoolfile_${CURRENTDATE}.log
	# Fetching the new BILLING ID for the process
	echo "FETCHING MAXIMUM BILLING ID" >> ${LOGFILE}

		db_connection "Q0001" ${BILLINGIDSPOOLFILE} 

		#Check if the file is spooled correctly or not
		checkSpoolforError ${LOGDIR}/billing_qa_process_billing_id_spoolfile_${CURRENTDATE}.log
		RETCODE_SPOOLCHECK=$?
		if [ ${RETCODE_SPOOLCHECK} -ne 0 ]
		then
			echo "ERROR OCCURED WHILE SPOOLING NEW BILLINGID" >> ${LOGFILE}
			echo "TERMINATING THE EXECUTION OF THE PROCESS BillIDGenerate.sh" >> ${LOGFILE}
			exit 1
		fi

		BILLINGID=`grep -w "BILLINGID" ${BILLINGIDSPOOLFILE} | cut -f2 -d"="`
		RETCODE_BILLINGID=$?
		if [ ${RETCODE_BILLINGID} -ne 0 ]
		then
			echo "ERROR OCCURED WHILE GENERATING THE BILLINGID" >> ${LOGFILE}
			echo "TERMINATING THE EXECUTION OF THE PROCESS BillIDGenerate.sh" >> ${LOGFILE}
			exit 1
		fi
	
	export BILLINGID
	echo "BILLINGID:${BILLINGID}" 	
#billing ID generation end-biren

	#unzip Start
	#gunzip $filePath*
	#unzipStat=$?
	#if [ $unzipStat -ne 0 ]
	#then
	#	echo "unzipping of files failed."  >> "log"
	#else
	#	echo "unzipping successfully completed." >> "log"
	#fi
	#unzip End
	#> "log"
	
	#unzip logic start
	for file in `ls -1 $filePath`
	do 

		if [[ $file ==  *".ctl"* ]]; then
			cp ${filePath}${file}  ${filePath2}${file}
		elif [ ! -z ${filePath2} ] ; then   # condition added to prevent danger of updating folder with blank files cool.
			gunzip -c ${filePath}${file} > ${filePath2}${file}
		fi
	done
	#unzip logic end
	
	#remove zipped file if filepath is present or set.
	if [ ! -z ${filePath} ] ; then
	rm ${filePath}*
	fi



	DATEbiren=`date '+%Y%m%d'`
	validationLog=${BILLQAREADYDIR}/${BILLINGID}/FLXMergeValidationLog_${BILLINGID}_${DATEbiren}.log
	queryLogFile=${LOGDIR}/FLXMergeValidationSqlLog_${CURRENTDATE}.log

pID=FX_MG_VLDATION
#billing ID wise directory generation start-biren
echo "PROCESS WILL NOW CREATE BILLINGID WISE DIRECTORIES_biren" >> ${LOGFILE}
	create_billingid_dirs
	DIRCREATION_CHECK=$?

	if [ ${DIRCREATION_CHECK} -ne 0 ]
	then
		echo "ERROR WHILE CREATING BILLINGID WISE DIRECTORIES"  >> ${LOGFILE}
		echo "TERMINATING THE EXECUTION OF THE PROCESS FLAXCAB_MERGE_COOL" >> ${LOGFILE}
		START_PROCESS=`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`
		db_connection "Q0010" "${queryLogFile}" "${BILLINGID};${pID};${START_PROCESS};FAIL;ERROR_WHILE_CREATING_DIRECTORY;none" 
		exit 1
	fi
	echo "BILLINGID WISE DIRECTORIES CREATED" >> ${LOGFILE}
#billing ID wise directory generation end-biren


	db_connection "Q0002" "${queryLogFile}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;M;STARTED;FLEXCAB_DELTA_MERGE_VALIDATION;ALL;`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`" 	
	anyFileFailed=0
	RETCODE_INSERTCHECK=$?
	if [ ${RETCODE_INSERTCHECK} -ne 0 ]
	then
		echo "FAILED WHILE INSERTING NEW BILLINGID DETAILS IN : BQA_BILLING_MST" >> ${LOGFILE}
		echo "TERMINATING THE EXECUTION OF THE PROCESS BillIDGenerate.sh" >> ${LOGFILE}
		exit 1
	fi
	
	
#Flexcab field validation -not numeric dateformat and mandatory field start-biren


while IFS= read -r line
do
	fileCode=$(echo $line | cut -f1 -d"|")
	recordLen=$(echo $line | cut -f2 -d"|")
	fileTemp=$filePath2"FLEXCAB.REFERENCE."$fileCode"."$FILE_TYPE".20??????"
	if [ $fileCode == "FMIP0027" ]
	then
	fileTemp=$filePath2"FLEXCAB.REFERENCE."$fileCode"."$FILE_TYPE".20??????.dat"
	fi
	FILE=$( ls -1 $fileTemp)
	START_PROCESS=`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`
	
	if [ -z $FILE ]
	then
	continue
	fi
	
	db_connection "Q0010" "${queryLogFile}" "${BILLINGID};${pID};${START_PROCESS};STARTED;FLEXCAB_MERGE_VALIDATION_PROCESS_STARTED;${fileCode}" 
	
	mawk -v fileConfig="${GENCONFIGDIR}/${fileCode}.config" -v recordLen="${recordLen}" -v fileCode="${fileCode}" 'function trim(str){
	sub("^[ |	]*", "", str);
	sub("[ |	]*$", "", str);
	return str;
	}
	function isNumeric(str){
		if( match (str,"^[+-]?[0-9]*[.[0-9]+]?$")){
		return 1
		}
		else{
		return 0
		}
	}
	function isDate(str){
		if ( match(str,"^(0[1-9]|[1-2][0-9]|3[0-1])\\.(0[1-9]|1[0-2])\\.[0-9][0-9][0-9][0-9]$") ){	
			return 1
		}
		else{
			return 0
		}
	}
	function isTimeStamp(str){
		if ( match(str,"^[0-9][0-9][0-9][0-9]-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])-([0-1][0-9]|2[0-3])\\.([0-5][0-9])\\.([0-5][0-9])\\.([0-9][0-9][0-9][0-9][0-9][0-9])$") ){
			return 1
		}
		else{
			return 0
		}
	}
	
	BEGIN{
		i=1
		while(getline < fileConfig){
			configArr[i]=$0
			i=i+1
		}
	}
	{	
	line=$0
	rec_ID=substr(line,1,1)
	if(fileCode == "FMIP0027"){
	HDR_NM       = substr(line,10,7)
	MIS_EXTCT_CD = substr(line,2,7)
		if(HDR_NM == "FCBPRD1" || MIS_EXTCT_CD == "FCBPRD1" ){
		rec_ID="biren"
		}
		else{
		rec_ID = 1
		}
	}
	
	if(rec_ID == 1 ){			
			if((length) != (recordLen + 0)){
					print "Record_Length_Does_Not_Match" >> "'${val_Log}'"				
					#print "length:" length "& recordLen:" recordLen + 0 >> "tempLog"
					print "file Len:" length " IASS len:" recordLen + 0 >> "'${val_Log}'"
					print "line no:" NR >> "'${val_Log}'"
					print "Record_Length_Does_Not_Match" > "fail"					
					exit 1				
			}		
			for( x in configArr ){
				split(configArr[x],metaArr,"|")	
				name = trim(metaArr[1])
				datatType = tolower(trim(metaArr[2]))
				mand = trim(metaArr[3])
				start= trim(metaArr[4])
				len  = trim(metaArr[5])
				field= trim(substr(line,start,len))
				
				if( field == ""  && mand == "M" ){
						print "Mandatory_Field_Is_Not_Present" > "fail"
						print "Mandatory Field " name " is not present at line no:" NR >> "'${val_Log}'"
						exit 1
				}
				else if ( field != "" ){
					if( datatType == "integer" || datatType == "decimal" ){
						
						if(!isNumeric(field)){
						print "Not_A_Numeric_Value" > "fail"
						print name "="field" is not a numeric value at line no:" NR >> "'${val_Log}'"
						exit 1	
						}
					
					
					}
					else if( datatType == "date" ){
						if(!isDate(field)){
						print "Incorrect_Date_Format" > "fail"
						print "date format of "name ":"field" is not correct at line no:" NR >> "'${val_Log}'"
						exit 1
						}
					}
					else if( datatType == "timestamp" ){
						#print "timestamp: " fileConfig "timestamp name:value :: "name ":"field" line no:" NR >> "temp"
						if(!isTimeStamp(field)){
						print "Incorrect_TimeStamp_Format" > "fail"
						print "timestamp format of "name ":"field" is not correct at line no:" NR >> "'${val_Log}'"
						exit 1
						}
					
					}
				}
			}
			
	}
	}' $FILE

if [ -f "fail" ]
then
	anyFileFailed=1
	reason=$(<"fail")
	rm "fail"
	echo " error in file:${FILE}" >> ${val_Log}
	echo "reason : ${reason}" >> ${val_Log}
	db_connection "Q0012" "${queryLogFile}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;FAIL;${reason};${BILLINGID};${fileCode};${pID}"
else
	echo "${FILE} validated successfully! " >> ${val_Log}
	db_connection "Q0012" "${queryLogFile}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;SUCCESS;FLEXCAB_MERGE_VALIDATION_PROCESS_SUCCESS;${BILLINGID};${fileCode};${pID}"
fi
done < "${GENCONFIGDIR}/Main.config"

if [ $anyFileFailed -ne 0 ]
then
	param="`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;FAIL;FLEXCAB_MERGE_PROCESS_FAILED;$BILLINGID"
	db_connection "Q0003" "${queryLogFile}" "${param}"	

else
	param="`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;SUCCESS;FLEXCAB_MERGE_VALIDATION_SUCCESSFULLY_COMPLETED;$BILLINGID"
	db_connection "Q0003" "${queryLogFile}" "${param}"	
fi

CURRENTDATE=`date '+%Y%m%d%H%M%S'`
echo $CURRENTDATE >> ${val_Log}

