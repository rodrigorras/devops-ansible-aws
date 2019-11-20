var1=$(aws rds describe-db-instances | grep Address | awk '{ print $2}'  | tr -d '"' | tr -d ',')
echo $var1
#mysql -h $var1 -P 3306 -u admin -p1nsecure < create_database.sql
#mysql -h $Var1 -P 3306 -u admin -p1nsecure 
