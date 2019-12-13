//FlexcabDeltaMergeLooper.sh
	#!/bin/bash
	if [ -f ~/.bash_profile ]
	then
		. ~/.bash_profile
	fi	

	#calling validation script which will validate and unzip the files into other dir. then next process will be done on that dir.
	sh -x /trans_prod/BILLQAENV/GEN/SRC/EXE/SCRIPT/FlexcabMergeFieldValidationZIP.sh EXTRACT
	
	if [ $? -eq 0 ]
	then
		echo "FlexcabMergeFieldValidationZIP.sh:Process successfully executed!." 
		else
		echo "FlexcabMergeFieldValidationZIP.sh:Failed " 
		echo "FlexcabMergeFieldValidationZIP.sh:EXECUTION END TIMESTAMP:`date`" 
		exit 1
	fi
	
	#deltaPath="/trans_prod/BILLQAENV/tmp/Biren/MERGE_SCRIPT/Testing7_final_Problem/delta"
	deltaPath=`grep -w "FLEXCAB_MERGE_INPUT_DELTA_PATH" ${RASHOME}/.passwd | cut -f2 -d"="`
	basePath=`grep -w "FLEXCAB_MERGE_INPUT_BASE_PATH" ${RASHOME}/.passwd | cut -f2 -d"="`
	baseBkupPath=`grep -w "FLEXCAB_MERGE_INPUT_BASE_BK_PATH" ${RASHOME}/.passwd | cut -f2 -d"="`
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
		
		TEMP_OUTPUT_PATH=`grep -w "FLEXCAB_SNAPSHOT_TEMP_OUTPUT_PATH" ${RASHOME}/.passwd | cut -f2 -d"="`
		export TEMP_OUTPUT_PATH

		
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
	
	echo "PROCESS WILL NOW CREATE BILLINGID WISE DIRECTORIES_biren" >> ${LOGFILE}
	create_billingid_dirs

	DIRCREATION_CHECK=$?

	if [ ${DIRCREATION_CHECK} -ne 0 ]
	then
		echo "ERROR WHILE CREATING BILLINGID WISE DIRECTORIES"  >> ${LOGFILE}

		echo "TERMINATING THE EXECUTION OF THE PROCESS FLAXCAB_MERGE_COOL" >> ${LOGFILE}
		
		START_PROCESS=`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`
		pID=MERGE002
	
		db_connection "Q0010" "${BILLINGPROCESSINSERTFILE}" "${BILLINGID};${pID};${START_PROCESS};FAIL;ERROR_WHILE_CREATING_DIRECTORY;none" 
	

		exit 1
	fi

	echo "BILLINGID WISE DIRECTORIES CREATED" >> ${LOGFILE}
	temppath=${BILLQAREADYDIR}/${BILLINGID}/
	DATEbiren=`date '+%Y%m%d'`
	mergeLog=${BILLQAREADYDIR}/${BILLINGID}/FlexcabMergeLog_${BILLINGID}_${DATEbiren}.log
	DBCONNECTIONTYPE="SQLSERVER"
	BILLINGPROCESSINSERTFILE=${LOGDIR}/FlexcabMergeSqlLog_${CURRENTDATE}.log

	CURRENTDATE=`date '+%d-%m-%Y %H:%M:%S'`
	echo $CURRENTDATE >> ${mergeLog}
	
	
	#taking backup of last updated initial file start
	
	if [ ! -z ${baseBkupPath} ] ; then
	rm ${baseBkupPath}*
	echo "old initial file backup has been removed successfully"
	else
	echo "baseBkupPath is not present in .passwd file ! " >> ${mergeLog}
	exit 1
	fi
	
	cp -r  ${basePath}* ${baseBkupPath}
	if [ $? -ne 0 ]
		then
		echo "error while taking backup of last updated INITIAL files: FlexcabDeltaMergeLooper.sh." >> ${mergeLog}
		exit 1
		else
		echo "initial file backup successful" >> ${mergeLog}
	fi
	
	gzip ${baseBkupPath}*
	if [ $? -ne 0 ]
		then
		echo "error while zipping backup of last updated INITIAL files: FlexcabDeltaMergeLooper.sh." >> ${mergeLog}
		exit 1
		else
		echo "initial file backup zippped successfully" >> ${mergeLog}
	fi
	#taking backup of last updated initial file end
	
	#calling validation script which will validate and unzip the files into other dir. then next process will be done on that dir.

	
	
	#start
	#gunzip $deltaPath*
	#unzipStat=$?
	#if [ $unzipStat -ne 0 ]
	#then
	#	echo "unzipping of delta failed."  >> ${mergeLog}
	#else
	#	echo "unzipping successfully completed." >> ${mergeLog}
	#fi
	#stop
	
	
	if [ "${DBCONNECTIONTYPE}" == "SQLSERVER" ]
		then
	db_connection "Q0002" "${BILLINGPROCESSINSERTFILE}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;M;STARTED;FLEXCAB_DELTA_MERGE;ALL;`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`" 	
	#db_connection "Q0002" "${BILLINGPROCESSINSERTFILE}" "`date +%Y-%m-%d:%H:%M:%S`;${BILLINGTYPE};STARTED;${SYSTEMNAME};${BILLINGID};${INVOICESUMMARYBILLRUNMONTH}"
	#db_connection "Q0002" "${BILLINGPROCESSINSERTFILE}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;${BILLINGTYPE};STARTED;${SYSTEMNAME};${BILLINGID};${INVOICESUMMARYBILLRUNMONTH}"

	fi
	
		RETCODE_INSERTCHECK=$?
	if [ ${RETCODE_INSERTCHECK} -ne 0 ]
	then
		echo "FAILED WHILE INSERTING NEW BILLINGID DETAILS IN : BQA_BILLING_MST" >> ${LOGFILE}
		echo "TERMINATING THE EXECUTION OF THE PROCESS BillIDGenerate.sh" >> ${LOGFILE}
		exit 1
	fi
	
	
	
	
	echo "PROCESS WILL NOW CREATE BILLINGID WISE *shared*DIRECTORIES_biren" >> ${LOGFILE}
	create_shared_billingid_dirs

	DIRCREATION_CHECK=$?

	if [ ${DIRCREATION_CHECK} -ne 0 ]
	then
		echo "ERROR WHILE CREATING BILLINGID WISE *shared* DIRECTORIES"  >> ${LOGFILE}

		echo "TERMINATING THE EXECUTION OF THE PROCESS FLAXCAB_MERGE_COOL" >> ${LOGFILE}
		
		START_PROCESS=`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`
		pID=MERGE002
	
		db_connection "Q0010" "${BILLINGPROCESSINSERTFILE}" "${BILLINGID};${pID};${START_PROCESS};FAIL;ERROR_WHILE_CREATING_SHARED_DIRECTORY;none" 
	

		exit 1
	fi

	echo "BILLINGID WISE *shared* DIRECTORIES CREATED" >> ${LOGFILE}
	
	
#looper logic start *************************************************************	
#configFile=/trans_pcat/BILLQAENV/tmp/Biren/MERGE_SCRIPT/Testing2/FLEXCABResourceMergeConfig.config
configFile=${GENCONFIGDIR}/FLEXCABResourceMergeConfig.config
echo "**********looper awk is going to start*********"  >> ${mergeLog}
mawk -F, -v BILLINGID="$BILLINGID" -v mergeLog="$mergeLog" -v temppath="$temppath" '{
	
	str="/trans_prod/BILLQAENV/GEN/SRC/EXE/SCRIPT/FlexcabDeltaMerge.sh "$0	
	partition=$5
	print partition
	if(partition==0){
	print "sh -x "str " -1 -1 "BILLINGID" >>"mergeLog
	system("sh -x "str " -1 -1 "BILLINGID" >>"mergeLog) 

	}
	else{
	
	for(i=0;i<partition;i++){
	j = sprintf("%02d", i);
	p=  sprintf("%02d", partition-1);
       print "j" j
	print "p" p 
	print "sh -x "str" "j" "p" "BILLINGID" >>"mergeLog
	system("sh -x "str" "j" "p" "BILLINGID" >>"mergeLog) 
	}
	}


	}' $configFile		
	
	echo "**********looper awk is ENDED*********"  >> ${mergeLog}
	#update merge status start
	
	echo "updating final merge success/fail status in bqa_billing_mst" >> ${mergeLog}
	if [ -f $configFile ] ; 
	then 
		
				
		# here we are cheking that if any (select distict where FAIL file failed during merge then it will insert failure status in bqa_billing_mst
		param="$BILLINGID;FAIL"
		PSD_BILLING_ID_temp="PSD_BILLING_ID.temp"
		db_connection "Q0034" "${PSD_BILLING_ID_temp}" "${param}"
		PSD_BILLING_ID=$(cat $PSD_BILLING_ID_temp)
		if [ -f $PSD_BILLING_ID_temp ] ; then rm $PSD_BILLING_ID_temp
		fi
		if [ -z "$PSD_BILLING_ID" ]
		then
			param="`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;SUCCESS;FLEXCAB_MERGE_PROCESS_SUCCESSFULLY_EXECUTED;$BILLINGID"
			#echo "param:$param" >> "Dbmerge.log"
			db_connection "Q0003" "${BILLINGPROCESSINSERTFILE}" "${param}"				
		else
			param="`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;FAIL;FLEXCAB_MERGE_PROCESS_FAILED;$BILLINGID"
			#echo "param:$param" >> "Dbmerge.log"
			db_connection "Q0003" "${BILLINGPROCESSINSERTFILE}" "${param}"	
		fi

	else
		param="`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;FAIL;FLEXCABRESOURCEMERGECONFIG_FILE_DOES_NOT_EXISTS;$BILLINGID"
		#echo "param:$param" >> "Dbmerge.log"
		db_connection "Q0003" "${BILLINGPROCESSINSERTFILE}" "${param}"	

			
	fi
	
		CURRENTDATE=`date '+%d-%m-%Y %H:%M:%S'`
		echo $CURRENTDATE >> ${mergeLog}
		#if whole merge process succeed than now start zipping billing direcgtory and moviing into shared folder.
				#		***************************zipping and moving start BIREN*******************************************************
				
						START_PROCESS=`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`
						pID="MERGEZIP3"
						echo "zipping stared" >> ${mergeLog}
						fileCode="none"
						db_connection "Q0010" "${BILLINGPROCESSINSERTFILE}" "${BILLINGID};${pID};${START_PROCESS};STARTED;FLEXCAB_MERGE_ZIPPING_PROCESS_STARTED;${fileCode}" 
						echo "after zip started query" >> ${mergeLog}
						gzip ${BILLQAREADYDIR}/${BILLINGID}/*
						ZIPSTAT=$?
						gzip ${deltaPath}*
						ZIPSTAT2=$?
						

							if [ ${ZIPSTAT} -ne 0  ] || [ ${ZIPSTAT2} -ne 0  ]
								then
									echo "${BILLINGID}:Zipping failed. making failed entry into failed file log." >> ${mergeLog}
									echo "${BILLINGID}|${START_PROCESS}" >> ${mergeLog}
									db_connection "Q0012" "${BILLINGPROCESSINSERTFILE}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;FAIL;ERROR_WHILE_ZIPPING_FLXCB_MERGE_FILES;${BILLINGID};none;${pID}"	
									ZIP_STAT=1
									param="`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;FAIL;FLEXCAB_MERGE_PROCESS_FAILED;$BILLINGID"
									db_connection "Q0003" "${BILLINGPROCESSINSERTFILE}" "${param}"
									
									
								else
									db_connection "Q0012" "${BILLINGPROCESSINSERTFILE}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;SUCCESS;FLX_MERGE_ZIPPING_PROCESS_COMPLETED_SUCCESSFULLY;${BILLINGID};none;${pID}"				
									ZIP_STAT=$?
									echo "${BILLINGID}:Zipping done successfully!. " >> ${mergeLog}
							fi


							if [ ${ZIP_STAT} -eq 0 ]
								then
								echo "FLEXCAB_MERGE_BIREN.sh:Zip Process status successfully inserted into database" >> ${mergeLog}
							else
								echo "FLEXCAB_MERGE_BIREN.sh:Failed while inserting process status" >> ${mergeLog}
								echo "FLEXCAB_MERGE_BIREN.sh:EXECUTION END TIMESTAMP:`date`" >> ${mergeLog}								
								exit 1
							fi
						
				
					
						#-------- MOVING FILES TO SHARED LOCATION -----------#
						echo "staring move process before DB" >> ${mergeLog}	
						pID="MERGEMV3"
						START_PROCESS=`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`
						db_connection "Q0010" "${BILLINGPROCESSINSERTFILE}" "${BILLINGID};${pID};${START_PROCESS};STARTED;FLX_MERGE_MOVING_PROCESS_STARTED;none" 
						echo "moving started :DB" >> ${mergeLog}	
						mv ${BILLQAREADYDIR}/${BILLINGID}/* ${SHAREDBILLQAREADYDIR}/${BILLINGID}/
						echo "after mv command"   >> ${mergeLog}	
						MOVESTAT=$?
						mv ${deltaPath}* ${SHAREDBILLQAREADYDIR}/${BILLINGID}/
						MOVESTAT2=$?
						#mv ${TEMP_OUTPUT_PATH}* ${SHAREDBILLQAREADYDIR}/${BILLINGID}/
						
						echo "MOVESTAT:${MOVESTAT}"  >> ${mergeLog}
							if [ ${MOVESTAT} -ne 0 ] || [ ${MOVESTAT2} -ne 0 ]
								then
									echo "${BILLINGID}:Moving failed. making failed entry into failed file log." >> ${mergeLog}
									echo "${BILLINGID}|${START_PROCESS}" >> ${mergeLog} 
									db_connection "Q0012" "${BILLINGPROCESSINSERTFILE}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;FAIL;ERROR_WHILE_MOVING_FILES_TO_SHARED_DIRECTORY;${BILLINGID};none;${pID}"				
											
									MOVE_STAT=1
								else
									echo "before query" >> ${mergeLog} 
									db_connection "Q0012" "${BILLINGPROCESSINSERTFILE}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;SUCCESS;MOVED_SUCCESSFULLY_TO_SHARED_DIRECTORY;${BILLINGID};none;${pID}"			
									MOVE_STAT=$?
									echo "db_stat:${MOVE_STAT}" >> ${mergeLog} 
							fi		


							if [ ${MOVE_STAT} -eq 0 ]
								then
								echo "FLEXCAB_MERGE_BIREN.sh:Process status successfully inserted into database" >> ${mergeLog}
								#SUCCESS STATUS FOR INDIVIDUAL SERVER
								
								#db_connection_graph "Q0020" "${BILLINGID}" "${BILLINGID};MPRMOVE001;${START_MOV};`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;SUCCESS;PROCESS_COMPLETED_SUCCESSFULLY"
								#db_connection_graph "Q0003" "${BILLINGID}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;SUCCESS;MICA_SNAPSHOT_SUCCESFULLY_COMPLETED;${BILLINGID}"
							
							else
								echo "FLEXCAB_MERGE_BIREN.sh:Failed while inserting process status" >> ${mergeLog}
								echo "FLEXCAB_MERGE_BIREN.sh:EXECUTION END TIMESTAMP:`date`" >> ${mergeLog}
								#db_connection_graph "Q0003" "${BILLINGID}" "`date '+%Y-%m-%d'`T`date '+%H:%M:%S'`;FAILED;ERROR_WHILE_MOVING_FILES_TO_SHARED_DIRECTORY;${BILLINGID}"
								
								exit 1
							fi
				
					
					#	***************************zipping and moving END BIREN*******************************************************
			

		echo "final status updated in bqa_billing_mst" >> ${mergeLog}

		sh -x /trans_prod/BILLQAENV/GEN/SRC/EXE/SCRIPT/customerMAP.sh
		if [ $? -ne 0 ]
		then
		echo "error in customerMAP.sh script which is called from FlexcabDeltaMergeLooper.sh." >> ${mergeLog}
		else
		echo "customerMap has been loaded successfully in DB" >> ${mergeLog}
		fi






