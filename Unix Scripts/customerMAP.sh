#customerMAP.sh
#-------------------------------Developed_By_BIREN_PATEL-------------------------------------------------
if test -s ${RASHOME}/.passwd
	then
		
		INPUT_PATH=`grep -w "FLEXCAB_SNAPSHOT_INPUT_BASE_PATH" ${RASHOME}/.passwd | cut -f2 -d"="`
		export INPUT_PATH
		echo "INPUT_PATH:${INPUT_PATH}"

		TEMP_OUTPUT_PATH=`grep -w "FLEXCAB_SNAPSHOT_TEMP_OUTPUT_PATH" ${RASHOME}/.passwd | cut -f2 -d"="`
		export TEMP_OUTPUT_PATH
		
		FINAL_OUTPUT_PATH=`grep -w "FLEXCAB_SNAPSHOT_OUTPUT_PATH" ${RASHOME}/.passwd | cut -f2 -d"="`
		export FINAL_OUTPUT_PATH
	else
		echo ".passwd FILE DOESNOT EXISTS IN HOME DIRECTORY"
		echo "TERMINATING THE EXECUTION OF THE PROCESS BillIDGenerate.sh"
		exit 1
fi

customerMAP="${TEMP_OUTPUT_PATH}customerMAP"

T04008=`ls -1 ${INPUT_PATH}FLEXCAB.REFERENCE.T04008.INITIAL.20??????`
T04205=`ls -1 ${INPUT_PATH}FLEXCAB.REFERENCE.T04205.INITIAL.20??????`
T04237=`ls -1 ${INPUT_PATH}FLEXCAB.REFERENCE.T04237.INITIAL.20??????`
T04676=`ls -1 ${INPUT_PATH}FLEXCAB.REFERENCE.T04676.INITIAL.20??????`
T04701=`ls -1 ${INPUT_PATH}FLEXCAB.REFERENCE.T04701.INITIAL.20??????`
END_DATE="31.12.9999"

#header attribute in output file
#echo "CIDN|CUSTOMER_NAME|PNB_IND|CUST_TYPE|CUST_STAT_CD|OWNSHP_CD|AUST_CO_NBR|ST_NBR_SFX|ST_TYPE|ST_NAME|LCLTY_NAME|STATE_ABBR|CUST_STA_DT|CUST_END_DT|OWNERSHIP_DESC|ULT_PRNT_CIDN|PRNT_CIDN|CHLD_CIDN|INHT_OWNSHP_CD_IND|INHT_MKTG_SEG_IND|INHT_CUST_TYPE_IND|INHT_PNB_IND|INHT_INDSTRY_IND|INHT_ACN_IND|CHLD_IMMED_CHLDN|CUST_REL_DESC|ABN|SEGMENT|SIEBEL_MKT_SEG|SIEBEL_BUS_UNIT|MNGD_IND" >"customerMAP"
> $customerMAP


mawk 'function trim(str){
	sub("^[ ]*","",str);
	sub("[ ]*$","",str);
	return str;
	}
	function dateFormat(date){
	return  substr(date,7,4) "-" substr(date,4,2) "-" substr(date,1,2)
	}	
	BEGIN{
		#reading T04205 into Array
		while(getline < "'${T04205}'" ){
			ID_T04205=substr($0,1,1)
			if(ID_T04205==1){
				OWNSHP_CD_4205     =trim(substr($0,2,3))
				EFF_END_DT         =trim(substr($0,119,10))
				
				if(EFF_END_DT== "'${END_DATE}'"){
					arr_T04205[OWNSHP_CD_4205]=$0
				}
				
			}
								
		}
		#reading T04237 into Array
		while(getline < "'${T04237}'"){
			ID_T04237=substr($0,1,1)
			delta_indicator=substr($0,length-18,1)
		#	print "delta Ind:" delta_indicator > "tempLog"
			if(ID_T04237==1 && delta_indicator != "D" ){
				CHLD_CIDN4237             =trim(substr($0,32,10))
				arr_T04237[CHLD_CIDN4237] =$0
			}
		}
		
		#reading T04676 into Array
		while(getline < "'${T04676}'"){
			ID_T04676=substr($0,1,1)
			delta_indicator=substr($0,length-18,1)
			print "delta Ind:" delta_indicator > "tempLog"
			if(ID_T04676==1 && delta_indicator != "D" ){
				CIDN4676=trim(substr($0,12,10))
				arr_T04676[CIDN4676]=$0
			}
		}
		
		#reading T04701 into Array
		while(getline < "'${T04701}'"){
			ID_T04701=substr($0,1,1)
			if(ID_T04701==1 ){					
				CDBOR_OWN_CD	=trim(substr($0,8,3))
				arr_T04701[CDBOR_OWN_CD]      =$0
			}
		}
		
	}
{   ID=substr($0,1,1)
	delta_indicator=substr($0,length-18,1)
	print "delta Ind#:" delta_indicator > "tempLog"
	if(ID==1 && delta_indicator != "D"  ){
		#T04008 attribute start biren		
	#	PRNT_CIDN	=trim(substr($0,608,10))
		CIDN        =trim(substr($0,12,10))
		PNB_IND     =trim(substr($0,42,1))
		CUST_TYPE   =trim(substr($0,43,3))
		CUST_STAT_CD=trim(substr($0,46,1))
		OWNSHP_CD   =trim(substr($0,332,3))
	#	ABN         ="ABN"
		AUST_CO_NBR =trim(substr($0,335,9))
		ST_NBR_SFX  =trim(substr($0,422,1))  
		ST_TYPE     =trim(substr($0,423,4))  
		ST_NAME     =trim(substr($0,427,30))
		LCLTY_NAME  =trim(substr($0,459,30))
		STATE_ABBR  =trim(substr($0,489,3))
		CUST_STA_DT =trim(substr($0,22,10))
		CUST_END_DT =trim(substr($0,32,10))

		#logic to make customerName 
			Name_Role_CD   =trim(substr($0,247,1))
			Cust_Role_Name =trim(substr($0,248,50))
			Cust_Giv_Nms   =trim(substr($0,298,30))
			if(Name_Role_CD=='C'){
		CUSTOMER_NAME      =Cust_Role_Name			
			}
			else{
		CUSTOMER_NAME      =Cust_Giv_Nms" "Cust_Role_Name		
			}
		
		
		
		#T04205 attribute start biren
		OWNERSHIP_DESC=""
		
		#T04237 attribute start biren
		ULT_PRNT_CIDN      =""
		PRNT_CIDN		   =""
		CHLD_CIDN          =""
		INHT_OWNSHP_CD_IND =""
		INHT_MKTG_SEG_IND  =""
		INHT_CUST_TYPE_IND =""
		INHT_PNB_IND       =""
		INHT_INDSTRY_IND   =""
		INHT_ACN_IND       =""
		CHLD_IMMED_CHLDN   =""
		CUST_REL_DESC      =""
		
		#T04676 attribute start biren
		ABN                =""
		
		#T04701 attribute start biren
		SEGMENT			   ="Others"	
		SIEBEL_MKT_SEG     =""
		SIEBEL_BUS_UNIT	   =""
		MNGD_IND           =""
		#other deriving attribute
		

		#looking up in T04205 
				line=arr_T04205[OWNSHP_CD]
				if(line!=""){
					OWNERSHIP_DESC =trim(substr(line,37,72))
				}
				
		
		#looking up in T04237 	
		
		child_cidn_found="false"
				line=arr_T04237[CIDN]
				REL_TYPE_CD=substr(line,42,1)
				#print line > "test"
				if(line!="" && REL_TYPE_CD=="M"){
					child_cidn_found="true"
					ULT_PRNT_CIDN =trim(substr(line,12,10))
					PRNT_CIDN     =trim(substr(line,22,10))
					CHLD_CIDN=CIDN
					if(length(ULT_PRNT_CIDN)==0){
						ULT_PRNT_CIDN=CIDN
					}
					if(length(PRNT_CIDN)==0){
						PRNT_CIDN=CIDN
					}
					#replace with substr
					INHT_OWNSHP_CD_IND  =trim(substr(line,54,1))
					INHT_MKTG_SEG_IND   =trim(substr(line,55,1))
					INHT_CUST_TYPE_IND  =trim(substr(line,56,1))
					INHT_PNB_IND        =trim(substr(line,57,1))
					INHT_INDSTRY_IND    =trim(substr(line,58,1))
					INHT_ACN_IND        =trim(substr(line,59,1))
					CHLD_IMMED_CHLDN    =trim(substr(line,60,4))
					CUST_REL_DESC       =trim(substr(line,64,20))
					
					
					
					
					
				}
		else if(child_cidn_found=="false"){
			CHLD_CIDN=CIDN
			ULT_PRNT_CIDN=CIDN
			PRNT_CIDN=CIDN
		}		
		#looking up in T04676 	
				line=arr_T04676[CIDN]
				if(line!=""){
					#replace with substr
					ABN  =trim(substr(line,22,11))
			
				}
		#looking up in T04701 	
						
				line=arr_T04701[OWNSHP_CD]
				if(line!=""){
					SIEBEL_MKT_SEG  =trim(substr(line,37,30))
					SIEBEL_BUS_UNIT=trim(substr(line,67,30))	
					MNGD_IND   	   =trim(substr(line,97,1))	
					if(SIEBEL_BUS_UNIT=="Business" && MNGD_IND=="Y"){
						SEGMENT="TB Managed"
					}
					else if (SIEBEL_BUS_UNIT=="Enterprise" && MNGD_IND=="Y"){
						SEGMENT="GES"
					}
					else{
						SEGMENT="Others"
					}
				
				}
		
		#line=CIDN"|"CUSTOMER_NAME"|"PNB_IND"|"CUST_TYPE"|"CUST_STAT_CD"|"OWNSHP_CD"|"AUST_CO_NBR"|"ST_NBR_SFX"|"ST_TYPE"|"ST_NAME"|"LCLTY_NAME"|"STATE_ABBR"|"CUST_STA_DT"|"CUST_END_DT
		#line=line"|"OWNERSHIP_DESC
		#line=line"|"ULT_PRNT_CIDN"|"PRNT_CIDN"|"CHLD_CIDN"|"INHT_OWNSHP_CD_IND"|"INHT_MKTG_SEG_IND"|"INHT_CUST_TYPE_IND"|"INHT_PNB_IND"|"INHT_INDSTRY_IND"|"INHT_ACN_IND"|"CHLD_IMMED_CHLDN"|"CUST_REL_DESC
		#line=line"|"ABN
		#line=line"|"SEGMENT"|"SIEBEL_MKT_SEG"|"SIEBEL_BUS_UNIT"|"MNGD_IND
		#print line >> "'${customerMAP}'"
		print CIDN"|"CUSTOMER_NAME"|"PNB_IND"|"CUST_TYPE"|"CUST_STAT_CD"|"OWNSHP_CD"|"AUST_CO_NBR"|"ST_NBR_SFX"|"ST_TYPE"|"ST_NAME"|"LCLTY_NAME"|"STATE_ABBR"|"CUST_STA_DT"|"CUST_END_DT"|"OWNERSHIP_DESC"|"ULT_PRNT_CIDN"|"PRNT_CIDN"|"CHLD_CIDN"|"INHT_OWNSHP_CD_IND"|"INHT_MKTG_SEG_IND"|"INHT_CUST_TYPE_IND"|"INHT_PNB_IND"|"INHT_INDSTRY_IND"|"INHT_ACN_IND"|"CHLD_IMMED_CHLDN"|"CUST_REL_DESC"|"ABN"|"SEGMENT"|"SIEBEL_MKT_SEG"|"SIEBEL_BUS_UNIT"|"MNGD_IND >> "'${customerMAP}'"
		
	}
	
}' $T04008



#sh -x /trans_prod/BILLQAENV/GEN/SRC/EXE/SCRIPT/CustomerMapload.sh
#if [ $? -ne 0 ]
#then
#echo "error while converting date format and loading in db." >> "${TEMP_OUTPUT_PATH}customerMAP_log"
#else
#echo "customerMap has been loaded successfully in DB" >> "${TEMP_OUTPUT_PATH}customerMAP_log"
#fi



