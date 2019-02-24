# MaliciousAPK
Scripts and algoritms to create a DeepLearning model to detect malicious applications (APK) for Android.

*DataSet_AndroSamples.csv*: Contains the parsed information used to train the system. Consider to improve the ammount of information for better and more identifications.

*APK_Malicious_JNotebook.html*: This is a Juniper Notebook creatud on IBM Watson to create and validate the system. Take a look to this file.

**APK_Analyzer**

*vt_request.py*: Requests VirusTotal for an specific md5. Usage: vt_requests.py <MD5>

*apk_analyzer.sh*: obtains the MD5 hash for each file in the folder, then obtains the package name and permissions for the APK file. Also uses the vt_requests.py script to obtaind VT information and finally saves all the information in a sqlite database.


