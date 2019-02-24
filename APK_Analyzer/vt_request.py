#!/usr/bin/python
#by @echavarro
#usage 		vt_requests.py <MD5>
#response 	Number of posivite engines, Scan Date, Kaspersky verdict 
import requests, sys
import json
import time

params = {'apikey': 'your VT API here', 'resource': ''}
headers = {
  "Accept-Encoding": "gzip, deflate",
  "User-Agent" : "gzip,  vt-requets.py"
  }
params['resource']=str(sys.argv[1])
response = requests.get('https://www.virustotal.com/vtapi/v2/file/report',
  params=params, headers=headers)
json_response = response.json()
print json_response['positives'],json_response['scan_date'],json_response['scans']['Kaspersky']['result']
#time.sleep(5)