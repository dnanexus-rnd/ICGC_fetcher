<!-- dx-header -->
# ICGC Data Fetcher (DNAnexus Platform App)

Fetches controlled-access files from the AWS mirror of ICGC data
<!-- /dx-header -->

This applet supports data retrieval using the ICGC DCC Storage Client tool (v1.0.0). You can use it either to bring files in for immediate processing in a workflow, or to import them into your secure DNAnexus projects for later use. The data fetch should be very fast, because the DCC storage client accesses a mirror of the data in Amazon S3.

## Prerequisite: access token

You'll need an access token from the ICGC Data Portal for an account approved for cloud data access. Please refer to the *User Guide: ICGC Data Analysis in the Cloud* (TODO: link) for detailed instructions on generating an access token.

Create a file whose content is exactly this token, upload it to your DNAnexus project, and provide this file as the `access_token` input.

## Fetching a single file

To fetch a single file, provide the object-id (UUID) of the file in the `object_ids` input.

## Fetching multiple files

There are two ways to fetch multiple files at once:

1. Provide multiple object-ids (UUIDs) as an array of strings in the `object_ids` input.
2. Provide a manifest file listing the UUIDs of the files to download in the `manifest` input. Manifest files can be created using repository file search in the ICGC Data Portal, as described in *User Guide: ICGC Data Analysis in the Cloud*.

Only one of `object_ids` or `manifest` should be specified.

# Command-line usage examples

```
dx run ICGC_fetcher -i access_token=my_access_token.txt -i object_ids=ddcdd044-adda-5f09-8849-27d6038f8ccd
```

```
dx run ICGC_fetcher -i access_token=my_access_token.txt -i manifest=my_manifest.tsv
```

where `my_access_token.txt` and `my_manifest.tsv` are files resident in the same DNAnexus project.
