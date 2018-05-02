#Python script to remove launch permissions for golden images older than given threshold in weeks
import os
from datetime import datetime, timedelta
import boto3

aws_access_key=os.environ['aws_access_key']
aws_secret_key=os.environ['aws_secret_key']
aws_region=os.environ['aws_region']
ami_threshold_weeks=int(os.environ['ami_threshold_weeks'])

#Create EC2 client using the aws credentials
ec2 = boto3.client(
		'ec2', 
		region_name = aws_region,
		aws_access_key_id = aws_access_key,
		aws_secret_access_key = aws_secret_key)


#Gather AMIs and figure out which ones to delete
my_images = ec2.describe_images( #AWS API to get the images owned by VM_ImageFactory
     Filters=[{"Name" :"tag:Owner", "Values":["VM_ImageFactory"] }],
     DryRun=False
     )

#Keep everything younger than given threshold in weeks
old_images = set()
today_date = datetime.now().utcnow().date()
print("Scanning ImageFactory golden images...")
for image in my_images['Images']:     
     for tag in image['Tags']:
          if tag['Key'] == "CreatedDate" :           
           image_creation_date=datetime.strptime(tag['Value'],"%Y-%m-%d").date()           
           image_threshold_date=image_creation_date + timedelta(weeks=ami_threshold_weeks)           
           if image_threshold_date < today_date:
             old_images.add(image['ImageId'])
             print ("image id:%s" %image['ImageId'])
             print ("image_creation_date:%s" %image_creation_date)
             print ("image_threshold_date:%s" %image_threshold_date)             

#Create EC2 resource to remove permissions
aws_ec2 = boto3.resource(
		'ec2', 
		region_name = aws_region,
		aws_access_key_id = aws_access_key,
		aws_secret_access_key = aws_secret_key)

#Remove launch permissions for images not younger than given threshold in weeks
if len(old_images) > 0 :
   for old_image in old_images :     
     target_image = aws_ec2.Image(old_image)
     target_image.reset_attribute( #AWS API to remove launch permissions
         Attribute='launchPermission',
         DryRun=False
          )
     print("Image %s expired!! Launch permissions removed" %old_image)
else:
     print("All images are younger than %s weeks!!" %ami_threshold_weeks)
