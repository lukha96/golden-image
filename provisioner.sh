#!/usr/bin/env bash
# 

#its recommend to use a sleep command to give time enough for EC2 creation
sleep 30

# update package
sudo apt-get -y update

# install git 
sudo apt install git

# install SSM
sudo snap install amazon-ssm-agent --classic
sudo snap start amazon-ssm-agent

# install cloudwatch agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
chmod a+x amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status


# install docker
sudo apt-get update
sudo apt-get install docker.io -y
sudo docker run hello-world


# install MySQL client

sudo apt-get install mysql-client-core-5.7 -y
sudo apt-get install jq -y


