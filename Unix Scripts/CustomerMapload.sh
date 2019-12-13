#CustomerMapload
if test -s ${RASHOME}/.passwd
	then
		SQL_SERVER_HOME=`grep -w "SQL_SERVER_HOME" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SQL_SERVER_HOME
		echo "SQL_SERVER_HOME:${SQL_SERVER_HOME}"
		
		SQL_DBO=`grep -w "SQL_DBO" ${RASHOME}/.passwd | cut -f2 -d"="`
		export SQL_DBO
		echo "SQL_DBO :${SQL_DBO}"
		
		GENSQLDIR=`grep -w "GENSQLDIR" ${RASHOME}/.passwd | cut -f2 -d"="`
		export GENSQLDIR
		echo "GENSQLDIR:${GENSQLDIR}"
		
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


		DEFAULT_PARAMETER=`grep -w "DEFAULT_PARAMETER" ${RASHOME}/.passwd | cut -f2 -d"="`
		export DEFAULT_PARAMETER		
			
		TEMP_OUTPUT_PATH=`grep -w "FLEXCAB_SNAPSHOT_TEMP_OUTPUT_PATH" ${RASHOME}/.passwd | cut -f2 -d"="`
		export TEMP_OUTPUT_PATH


		fi


CUST_output="${TEMP_OUTPUT_PATH}customerMAP"
CUST_output_tmp="${TEMP_OUTPUT_PATH}customerMAP_tmp"

awk -F"|" 'function Convdate(date){
if (date != ""){
change=substr(date,7,4) "-" substr(date,4,2) "-" substr(date,1,2);
return change;

}
}

{
CIDN=$1
CUSTOMER_NAME=$2
PNB_IND=$3
CUST_TYPE=$4
CUST_STAT_CD=$5
OWNSHP_CD=$6
AUST_CO_NBR=$7
ST_NBR_SFX=$8
ST_TYPE=$9
ST_NAME=$10
LCLTY_NAME=$11
STATE_ABBR=$12
CUST_STA_DT=Convdate($13)
CUST_END_DT=Convdate($14)
OWNERSHIP_DESC=$15
ULT_PRNT_CIDN=$16
PRNT_CIDN=$17
CHLD_CIDN=$18
INHT_OWNSHP_CD_IND=$19
INHT_MKTG_SEG_IND=$20
INHT_CUST_TYPE_IND=$21
INHT_PNB_IND=$22
INHT_INDSTRY_IND=$23
INHT_ACN_IND=$24
CHLD_IMMED_CHLDN=$25
CUST_REL_DESC=$26
ABN=$27
SEGMENT=$28
SIEBEL_MKT_SEG=$29
SIEBEL_BUS_UNIT=$30
MNGD_IND=$31




print CIDN"|"CUSTOMER_NAME"|"PNB_IND"|"CUST_TYPE"|"CUST_STAT_CD"|"OWNSHP_CD"|"AUST_CO_NBR"|"ST_NBR_SFX"|"ST_TYPE"|"ST_NAME"|"LCLTY_NAME"|"STATE_ABBR"|"CUST_STA_DT"|"CUST_END_DT"|"OWNERSHIP_DESC"|"ULT_PRNT_CIDN"|"PRNT_CIDN"|"CHLD_CIDN"|"INHT_OWNSHP_CD_IND"|"INHT_MKTG_SEG_IND"|"INHT_CUST_TYPE_IND"|"INHT_PNB_IND"|"INHT_INDSTRY_IND"|"INHT_ACN_IND"|"CHLD_IMMED_CHLDN"|"CUST_REL_DESC"|"ABN"|"SEGMENT"|"SIEBEL_MKT_SEG"|"SIEBEL_BUS_UNIT"|"MNGD_IND > "'${CUST_output_tmp}'"



}' $CUST_output



	LOADEROUTPUT="${TEMP_OUTPUT_PATH}customerMAP_loader_sql_log"
	QUERY="truncate table  pbc_ras_customer_map"
	${SQL_SERVER_HOME} ${DEFAULT_PARAMETER} -S ${SERVER_NAME} -U ${SQL_USR} -P ${SQL_PWD} -W -h -1 -o ${LOADEROUTPUT} <<-END
	set nocount on
	${QUERY}
	GO
	END
						
bcp ${SQL_DBO}.dbo.pbc_ras_customer_map in ${CUST_output_tmp} -f ${GENSQLDIR}/pbc_ras_customer_map.Fmt -S ${SERVER_NAME} -U ${SQL_USR} -P ${SQL_PWD} -e pbc_ras_customer_map.er 


if [ -f $CUST_output_tmp ]
then
rm $CUST_output_tmp
fi
