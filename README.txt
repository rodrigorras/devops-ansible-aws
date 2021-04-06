

Hello Gentleman,

*My script also works for multiple Instances of Web Servers pointing to the same database
*I finally decided to go with Dynamic Hosts (which is awesome!)


This provisioning is a provision of  AWS + ANSIBLE, VANHACKs Challenge:
=======================================================================

- This solution need the Dynamic Host Resolution from this link: https://aws.amazon.com/blogs/apn/getting-started-with-ansible-and-dynamic-amazon-ec2-inventory-management/

- My solution for some time utilizes AWSCLI to query RDS Instance Public DNS, because the rds ansible module is not so advanced yet.

- I need to export 5 Variables in Environment VARS:
	- copy ec2.py to /etc/ansible
	- sudo apt install mysql-client-core-5.7
	- Install awscli -> apt install awscli -y 
	-  export EC2_INI_PATH=/etc/ansible/ec2.ini
       	- export ANSIBLE_INVENTORY=/etc/ansible/ec2.py	
	-  export EC2_REGION=us-east-1
	-  export AWS_ACCESS_KEY_ID = xxxxxxxxxxxxxxxxxx
        -  export AWS_SECRET_ACCESS_KEY= xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


0) I used my local Laptop as Ansible-Controller, so I had to generate my key id_rsa locally and import to inside "Amazon Keys"


1) My Playbook is divided into 4 Smaller ones:
	
	- main.yml   
 		- create-sec-group.yml
		- Deploy-EC-Instance.yml
                - rds_provision.yml
		- CDN-basic.yml


2) Each one is responsible for solving its tasks

	- create-sec-group  -> Creates a new fresh Security Group
	- Deploy-EC-Instace -> Create a Instace of Web Server, Configure it Secure Group according to the last one, install Apache, PHP and Start HTTP,PHP Services
	- rds_provision     -> Provision the Database MYSQL in RDS, Create a Database from .sql DDL, run the queries,change default security policty to accept 3306
        - CDN-Basic	    -> Provides a Basic Configuration of CDN, correctly gets the EC2 Instance DNS Name and set CloudFront

*rds_provision also has a special feature, it's a BASH script to collect the RDS EndPointAddress, which is not implemented in Ansible rds module. 


3)After Configuring the Dynamic host list you can run with:

****Remember to configure it with Dynamic Host https://aws.amazon.com/blogs/apn/getting-started-with-ansible-and-dynamic-amazon-ec2-inventory-management/

  ansible-playbook file.yml -v
  ansible-playbook -u ec2-user file.yml -v 
 


4)The very last Step is to uncompress the site-content.tar.gz inside /var/www/html/RodrigoRios folder. First, of course, you have to create the RodrigoRios folder.

*Piece of Cake if the id_rsa.pub keys used in the beginning (step 0)
	
	scp site-content.tar.gz ec2-user@xxx.xxx.xxx.xxx

5) Inside the EC2 Instace - The website is cool. PHP site as well as the database modelling were enterily made by me.

Inside the EC2 Instace
-----------------------
$> sudo mkdir /var/www/html/RodrigoRios
$> mv ~/site-content.tar.gz /var/www/html/RodrigoRios
$> go to RodrigoRios folder and
$> sudo tar -xvzf site-content.tar.gz
$> now the site is online, with database service, and capable of inserting queries and showing Good Stuff

DONE! \o/

