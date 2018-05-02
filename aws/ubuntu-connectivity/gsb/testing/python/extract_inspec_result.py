#Python script to extract Validation result from Inspec in Image Validation Phase
import os
import boto3
import time

#Get Bamboo log(written by Inspec) params dynamically
plan_storagetag=os.environ['plan_storagetag']
jobkey=os.environ['jobkey']
build_no=os.environ['build_no']

log_file_folder=plan_storagetag+"-"+jobkey
log_file=plan_storagetag+"-"+jobkey+"-"+build_no

#To wait for Bamboo to write logs
time.sleep(180)

inspec_log_path= "/home/bamboo/bamboo-agent-home/temp/log_spool/" + log_file + ".log"
print ("inspec_log_path = "+inspec_log_path)

search_str = "Test Summary: "
search_file = open(inspec_log_path, "r")

#Module to search the specific string and extract Inspec result from Bamboo Log
for line in search_file:
    if line.strip().find(search_str) != -1:         
        inspec_failure_count=int((line.split(",")[1].strip()).split(" ")[0])        
        if inspec_failure_count == 0:
            inspec_result = "success"
        elif inspec_failure_count != 0:
            inspec_result = "failure"
        print ("Extracted inspec result:"+inspec_result)     

        #Create new file and write Inspec Result     
        with open("inspec_validation_result_"+build_no+".txt", "w") as new_file:
            new_file.write("inspec_validation_result="+inspec_result)
search_file.close()

print ("Validation Result extracted from Inspec Test Famework successfully.")
