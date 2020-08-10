csplit appendTable.cfg /SJHF/ -n 2 -s {*} -f nmd -b "%02d.cfg"
rm -f nmd00.cfg
sed -i '1d' nmd01.cfg
sed -i '1d' nmd02.cfg
#!/bin/bash   
#分行读取
cat nmd01.cfg  |grep -i ^xibi.l > list01.cfg 
cat nmd01.cfg  |grep -i ^libi.l > list02.cfg 
cat nmd01.cfg  |grep -i ^lcni.l > list03.cfg 
echo "exp_mode=data_only">trunkxibappend.cfg
count=1
cat list01.cfg | while read line       
do
        #echo "Line $count:$line"
        #colum=`$line`
        tablenamexib=`echo ${line%=*}` #提取表名
        if [ $count -eq 1 ]
        then
                echo "$tablenamexib">tabletmpxib.cfg
        else
                echo "$tablenamexib">>tabletmpxib.cfg
        fi
        let count++
done
        uniq -d tabletmpxib.cfg

        tablesxib=`paste -d "," -s - <tabletmpxib.cfg`
echo "tables=$tablesxib">>trunkxibappend.cfg
echo "query=(">>trunkxibappend.cfg

cat list01.cfg | while read line        
do
querytablexib=`echo $line`
echo "$querytablexib">>trunkxibappend.cfg
done
echo ")">>trunkxibappend.cfg


#LIB
echo "exp_mode=data_only">trunklibappend.cfg
count=1
cat list02.cfg | while read line       
do

        tablenamelib=`echo ${line%=*}` #提取表名
        if [ $count -eq 1 ]
        then
                echo "$tablenamelib">tabletmplib.cfg
        else
                echo "$tablenamelib">>tabletmplib.cfg
        fi
        let count++
done
 uniq -d tabletmplib.cfg
		
        tableslib=`paste -d "," -s - <tabletmplib.cfg`
echo "tables=$tableslib">>trunklibappend.cfg
echo "query=(">>trunklibappend.cfg
cat list02.cfg | while read line        
#分行读取
do
querytablelib=`echo $line`
echo "$querytablelib">>trunklibappend.cfg
done
echo ")">>trunklibappend.cfg
#LCN
echo "exp_mode=data_only">trunklcnappend.cfg
count=1
cat list03.cfg | while read line       
do
        #echo "Line $count:$line"
        #colum=`$line`
        tablenamelcn=`echo ${line%=*}` #提取表名
        if [ $count -eq 1 ]
        then
                echo "$tablenamelcn">tabletmplcn.cfg
        else
                echo "$tablenamelcn">>tabletmplcn.cfg
        fi
        let count++
done
 uniq -d tabletmplcn.cfg
        tableslcn=`paste -d "," -s - <tabletmplcn.cfg`
echo "tables=$tableslcn">>trunklcnappend.cfg
echo "query=(">>trunklcnappend.cfg
cat list03.cfg | while read line        
#分行读取
do
querytablelcn=`echo $line`
echo "$querytablelcn">>trunklcnappend.cfg
done
echo ")">>trunklcnappend.cfg

cat nmd01.cfg  |grep -i ^xibi.l > delete.txt
 if [ $? -ne 0 ]
        then
                rm -f trunkxibappend.cfg
        else
                echo "trunk有xib哟"
        fi
		rm -f delete.txt
cat nmd01.cfg  |grep -i ^libi.l > delete.txt
 if [ $? -ne 0 ]
        then
                rm -f trunklibappend.cfg
        else
                echo "trunk有lib哟"
        fi
		rm -f delete.txt
cat nmd01.cfg  |grep -i ^lcni.l > delete.txt
 if [ $? -ne 0 ]
        then
                rm -f trunklcnappend.cfg
        else
                echo "trunk有lcn哟"
        fi
		rm -f delete.txt
echo "nmd这是branch"
#branch
cat nmd02.cfg  |grep -i ^xibi.l > branch01.cfg 
cat nmd02.cfg  |grep -i ^libi.l > branch02.cfg 
cat nmd02.cfg  |grep -i ^lcni.l > branch03.cfg 
echo "exp_mode=data_only">branchxibappend.cfg
count=1
cat branch01.cfg | while read line       
do
        #echo "Line $count:$line"
        #colum=`$line`
        tablenamexib=`echo ${line%=*}` #提取表名
        if [ $count -eq 1 ]
        then
                echo "$tablenamexib">tabletmpxib.cfg
        else
                echo "$tablenamexib">>tabletmpxib.cfg
        fi
        let count++
done
        tablesxib=`paste -d "," -s - <tabletmpxib.cfg`
echo "tables=$tablesxib">>branchxibappend.cfg
echo "query=(">>branchxibappend.cfg

cat branch01.cfg | while read line        
do
querytablexib=`echo $line`
echo "$querytablexib">>branchxibappend.cfg
done
echo ")">>branchxibappend.cfg


#LIB
echo "exp_mode=data_only">branchlibappend.cfg
count=1
cat branch02.cfg | while read line       
do
        #echo "Line $count:$line"
        #colum=`$line`
        tablenamelib=`echo ${line%=*}` #提取表名
        if [ $count -eq 1 ]
        then
                echo "$tablenamelib">tabletmplib.cfg
        else
                echo "$tablenamelib">>tabletmplib.cfg
        fi
        let count++
done
		
        tableslib=`paste -d "," -s - <tabletmplib.cfg`
echo "tables=$tableslib">>branchlibappend.cfg
echo "query=(">>branchlibappend.cfg
cat branch02.cfg | while read line        
#分行读取
do
querytablelib=`echo $line`
echo "$querytablelib">>branchlibappend.cfg
done
echo ")">>branchlibappend.cfg


#LCN
echo "exp_mode=data_only">branchlcnappend.cfg
count=1
cat branch03.cfg | while read line       
do
        #echo "Line $count:$line"
        #colum=`$line`
        tablenamelcn=`echo ${line%=*}` #提取表名
        if [ $count -eq 1 ]
        then
                echo "$tablenamelcn">tabletmplcn.cfg
        else
                echo "$tablenamelcn">>tabletmplcn.cfg
        fi
        let count++
done
        tableslcn=`paste -d "," -s - <tabletmplcn.cfg`
echo "tables=$tableslcn">>branchlcnappend.cfg
echo "query=(">>branchlcnappend.cfg
cat branch03.cfg | while read line        
#分行读取
do
querytablelcn=`echo $line`
echo "$querytablelcn">>branchlcnappend.cfg
done
echo ")">>branchlcnappend.cfg

cat nmd02.cfg  |grep -i ^xibi.l > delete.txt
 if [ $? -ne 0 ]
        then
                rm -f branchxibappend.cfg
        else
                echo "branch有xib哟"
        fi
		rm -f delete.txt
cat nmd02.cfg  |grep -i ^libi.l > delete.txt
 if [ $? -ne 0 ]
        then
                rm -f branchlibappend.cfg
        else
                echo "branch有lib哟"
        fi
		rm -f delete.txt
cat nmd02.cfg  |grep -i ^lcni.l > delete.txt
 if [ $? -ne 0 ]
        then
                rm -f branchlcnappend.cfg
        else
                echo "branch有lcn哟"
        fi
		rm -f delete.txt

rm -f list03.cfg list02.cfg list01.cfg list00.cfg nmd01.cfg nmd02.cfg branch01.cfg branch02.cfg branch03.cfg tabletmp*
echo "finish"
exit 0

