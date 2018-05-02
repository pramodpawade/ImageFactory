#Python script to extract AMI ID from Packer in Image Build Phase
import os
import boto3
import time

#Get Bamboo log(written by Packer) params dynamically
plan_storagetag=os.environ['plan_storagetag']
jobkey=os.environ['jobkey']
build_no=os.environ['build_no']

log_file_folder=plan_storagetag+"-"+jobkey
log_file=plan_storagetag+"-"+jobkey+"-"+build_no

#To wait for Bamboo to write logs
time.sleep(180)

packer_log_path= "/home/bamboo/bamboo-agent-home/temp/log_spool/" + log_file + ".log"
print ("packer_log_file = "+packer_log_path)

search_str = "AMI: ami-"
search_file = open(packer_log_path, "r")

#Module to search the specific sting and extract AMI id from Bamboo Log written by Packer
for line in search_file:
    if line.strip().find(search_str) != -1:        
        ami_id=line.split("AMI:")[1].strip()
		
		#Create new file and write extracted AMI ID
        with open("packer_output_amid_"+build_no+".txt", "w") as new_file:
            new_file.write("packer_ami_id="+ami_id)
search_file.close()

print ("AMI Id " +ami_id+ " extracted from Packer successfully.")
