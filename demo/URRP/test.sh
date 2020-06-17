#!/bin/bash
v_sUSER=
v_sPass=

ORAUSER=${v_sUSER}/${v_sPass}@CFSURRPTK
DB_CONN_CMD="sqlplus -S ${ORAUSER}"

cat tableName.log | while read line
do
	table=`echo $line | awk '{print $1}'`
    x=`
		${DB_CONN_CMD} << !
		set echo off;
		set pagesize 0;
		set linesize 9999;
		select count(1) from user_tables where table_name =upper('$line');
		exit;
!
`
	if [ $x == 0 ]
	then
		echo ""$line 此表不存在，请检查！
		continue
	fi
	a=`
		${DB_CONN_CMD} << !
		set echo off;
		set pagesize 0;
		set linesize 9999;
		select count(1) from user_tab_cols where column_name ='DATA_DT' and table_name =upper('$line');
		exit;
!
`
	b=`
		${DB_CONN_CMD} << !
		set echo off;
		set pagesize 0;
		set linesize 9999;
		select count(1) from user_tab_cols where column_name ='BUSS_DATE' and table_name =upper('$line');
		exit;
!
`
	if [ $a == 1 ]
	then
		n=`
			${DB_CONN_CMD} << !
			set echo off;
			set pagesize 0;
			set linesize 9999;
			select data_type from user_tab_cols where column_name ='DATA_DT' and table_name =upper('$line');
			exit;
!
`
		if [ "$n" == "VARCHAR2" ]
		then
			y=`
				${DB_CONN_CMD} << !
				set echo off;
				set pagesize 0;
				set linesize 9999;
				select count(1) from $line where data_dt=$1;
				exit;
!
`
			if [ $y == 0 ]
			then
				echo $1 $line >> table_append.txt
			fi
		elif [ "$n" == "DATE" ]
		then
			z=`
				${DB_CONN_CMD} << !
				set echo off;
				set pagesize 0;
				set linesize 9999;
				select count(1) from $line where data_dt=to_Date($1,'yyyymmdd');
				exit;
!
`
			if [ $z == 0 ]
			then
				echo $1 $line >> table_append.txt
			fi
		break
		fi
	elif [ $b == 1 ]
	then
		q=`
			${DB_CONN_CMD} << !
			set echo off;
			set pagesize 0;
			set linesize 9999;
			select count(1) from $line where buss_date=$1;
			exit;
!
`
		if [ $q == 0 ]
		then
			echo $1 $line >> table_append.txt
		fi
	else
		echo $1 $line 此表需要全表恢复。>> table_append.txt
	fi
done
echo 查询完毕。
echo ------------------------------ >> table_append.txt