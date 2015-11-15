<!-- dx-header -->
# ICGC Data Fetcher (DNAnexus Platform App)

Fetches Data from the ICGC Data Portal to DNAnexus projects
<!-- /dx-header -->

This applet supports data download from the ICGC Data Portal using the ICGC Storage Client tool (v1.0.0).

# Downloading a single file

To download a single file, provide the object-id (UUID) of the file to download in the parameter "object_ids".

# Downloading multiple files

To download multiple files, provide a manifest file listing the UUIDs of the files to download. Manifest files can be created using repository search on the ICGC data portoal. Alternatively, provide multiple object-ids (UUIDs) as an array of strings in the parameter "object_ids". Only one of object_ids or manifest should be specified. The app will raise an error if both object_ids and manifest file are given.

# Access Token

A valid access token is necessary for data download from the ICGC data portal. Please refer to the ICGC user guide for information on obtaining an access token.

