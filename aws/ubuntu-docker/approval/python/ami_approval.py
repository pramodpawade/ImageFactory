#Python script to save/delete golden ami based on inspec test result from validation phase
import os
import boto3

aws_access_key=os.environ['aws_access_key']
aws_secret_key=os.environ['aws_secret_key']
aws_region=os.environ['aws_region']
aws_ami=os.environ['aws_ami']
inspec_test_result=os.environ['inspec_test_result']
vm_aws_accounts=os.environ['vm_aws_accounts']
vm_aws_accounts_list=vm_aws_accounts.split(',')


#Create ec2 resource client using the aws credentials
ec2 = boto3.resource(
		'ec2', 
		region_name = aws_region,
		aws_access_key_id = aws_access_key,
		aws_secret_access_key = aws_secret_key)

image = ec2.Image(aws_ami)
if inspec_test_result == 'failure':
 print ("inspec_test_result : failure") 
 image.deregister() #AWS API to deregister the ami
 print ("Golden AMI deregistered successfully")
elif inspec_test_result == 'success':
 print ("inspec_test_result : success")
 image.modify_attribute(  #AWS API to share the ami to provided AWS accounts
    Attribute='launchPermission',        
    OperationType='add',
    UserIds=vw_aws_accounts_list,
    DryRun=False
 )
 print ("Golden AMI shared to the provided AWS accounts.")
