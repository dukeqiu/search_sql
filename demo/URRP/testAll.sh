rm -rf table_append.txt
cat runDate.txt | while read date
do
	echo 正在查询$date的数据，请稍后...
	sh test.sh $date
done
echo 请在table_append.txt中查看缺失的数据