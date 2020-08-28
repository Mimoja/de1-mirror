# DE1 Downstream Git fork

This Repository is a downstream fork of the decent espresso software. It extends Johns
amazing work by:

- Support for Acaia scales

To enable the usage of this repository copy the updater.tcl from this repo to you /sdcare/de1plus folder
or change the following lines in your updater.tcl:

```
diff --git a/updater.tcl b/updater.tcl
index e97065c..1d7e130 100644
--- a/updater.tcl
+++ b/updater.tcl
@@ -353,7 +353,7 @@ proc check_timestamp_for_app_update_available { {check_only 0} } {
 
     set host "http://decentespresso.com"
     set progname "de1plus"
-    set url_timestamp "$host/download/sync/$progname/timestamp.txt"    
+    set url_timestamp "https://raw.githubusercontent.com/Mimoja/de1-mirror/main/timestamp.txt"
 
     set remote_timestamp {}
 
@@ -477,7 +477,7 @@ proc start_app_update {} {
     ##############################################################################################################
     # get manifest both as raw TXT and as gzip compressed, to detect tampering 
     #set url_manifest "$host/download/sync/$progname/manifest.txt"
-    set url_manifest_gz "$host2/download/sync/$progname/manifest.gz"
+    set url_manifest_gz "https://raw.githubusercontent.com/Mimoja/de1-mirror/main/manifest.gz"
     set remote_manifest_gz {}
     set remote_manifest {}
     catch {
@@ -594,7 +594,7 @@ proc start_app_update {} {
         unset -nocomplain arr
         array set arr $v
         set fn "$tmpdir/$arr(filesha)"
-        set url "$host/download/sync/$progname/[percent20encode $k]"
+        set url "https://raw.githubusercontent.com/Mimoja/de1-mirror/main/[percent20encode $k]"
         
         catch {
             decent_http_get_to_file $url $fn
```
