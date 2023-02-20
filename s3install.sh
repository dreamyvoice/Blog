yum install -y httpd mysql
amzon-linux-extras install -y php 7.2
aws s3 cp s3://kg-bucket-1007/mzc_web02.zip
unzip mzc_web02.zip-d/var/www/html
systemctl start httpd
systemctl enable httpd
