csplit fullTable.cfg /SJHF/ -n 2 -s {*} -f tmd -b "%02d.cfg"
rm -f tmd00.cfg
sed -i '1d' tmd01.cfg
sed -i '1d' tmd02.cfg
cat tmd01.cfg  |grep -i ^xibi.l > full01.cfg 
cat tmd01.cfg  |grep -i ^libi.l > full02.cfg 
cat tmd01.cfg  |grep -i ^lcni.l > full03.cfg 
echo "exp_mode=full">trunkxibfull.cfg
        ftablesxib=`paste -d "," -s - <full01.cfg`
echo "tables=$ftablesxib">>trunkxibfull.cfg
echo "query=(">>trunkxibfull.cfg
echo ")">>trunkxibfull.cfg

echo "exp_mode=full">trunklibfull.cfg
        ftableslib=`paste -d "," -s - <full02.cfg`
echo "tables=$ftableslib">>trunklibfull.cfg
echo "query=(">>trunklibfull.cfg
echo ")">>trunklibfull.cfg

echo "exp_mode=full">trunklcnfull.cfg
        ftableslcn=`paste -d "," -s - <full03.cfg`
echo "tables=$ftableslcn">>trunklcnfull.cfg
echo "query=(">>trunklcnfull.cfg
echo ")">>trunklcnfull.cfg

cat tmd01.cfg  |grep -i ^xibi.l > delete.txt
 if [ $? -ne 0 ]
        then
                rm -f trunkxibfull.cfg
        else
                echo "trunk有xib哟"
        fi
		rm -f delete.txt
cat tmd01.cfg  |grep -i ^libi.l > delete.txt
 if [ $? -ne 0 ]
        then
                rm -f trunklibfull.cfg
        else
                echo "trunk有lib哟"
        fi
		rm -f delete.txt
cat tmd01.cfg  |grep -i ^lcni.l > delete.txt
 if [ $? -ne 0 ]
        then
                rm -f trunklcnfull.cfg
        else
                echo "trunk有lcn哟"
        fi
		rm -f delete.txt
		
echo "-----老子是branch哒"
cat tmd02.cfg  |grep -i ^xibi.l > bfull01.cfg
cat tmd02.cfg  |grep -i ^libi.l > bfull02.cfg 
cat tmd02.cfg  |grep -i ^lcni.l > bfull03.cfg
echo "exp_mode=full">branchxibfull.cfg
        ftablesxib=`paste -d "," -s - <bfull01.cfg`
echo "tables=$ftablesxib">>branchxibfull.cfg
echo "query=(">>branchxibfull.cfg
echo ")">>branchxibfull.cfg

echo "exp_mode=full">branchlibfull.cfg
        ftableslib=`paste -d "," -s - <bfull02.cfg`
echo "tables=$ftableslib">>branchlibfull.cfg
echo "query=(">>branchlibfull.cfg
echo ")">>branchlibfull.cfg

echo "exp_mode=full">branchlcnfull.cfg
        ftableslcn=`paste -d "," -s - <bfull03.cfg`
echo "tables=$ftableslcn">>branchlcnfull.cfg
echo "query=(">>branchlcnfull.cfg
echo ")">>branchlcnfull.cfg

cat tmd02.cfg  |grep -i ^xibi.l > delete.txt
 if [ $? -ne 0 ]
        then
                rm -f branchxibfull.cfg
        else
                echo "branch有xib哟"
        fi
		rm -f delete.txt
cat tmd02.cfg  |grep -i ^libi.l > delete.txt
 if [ $? -ne 0 ]
        then
                rm -f branchlibfull.cfg
        else
                echo "branch有lib哟"
        fi
		rm -f delete.txt
cat tmd02.cfg  |grep -i ^lcni.l > delete.txt
 if [ $? -ne 0 ]
        then
                rm -f branchlcnfull.cfg
        else
                echo "branch有lcn哟"
        fi
		rm -f delete.txt
rm -f *full0*.cfg 
rm -f tmd0*.cfg

today=`date +%m%d`
rm -f 数据恢复$today.zip
zip 数据恢复$today.zip *append.cfg *full.cfg
echo "full finish"
exit 0

