# gcp-terraform-samples
Examples of GCP with terraform

# Cloud Functions
This project is an example demonstrating how to deploy Google Cloud Functions v1 and v2 using resources and modules with `terraform`.

## Pre requisites

- terraform 
```bash
terrafor --version
# Your version of Terraform is out of date! The latest version
# is 1.9.1. You can update by downloading from https://www.terraform.io/downloads.html
```
- gcloud (google cloud cli)

```bash
gcloud --version                                                          
# Google Cloud SDK 483.0.0
# bq 2.1.6
# core 2024.06.28
# gcloud-crc32c 1.0.0
# gsutil 5.30
```

## The sources Code:

The sources code is in the folder `helloworldHttp`, base on example of google [Link](https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git)

This code is packaged in a zip file and uploaded to a storage bucket. 

## Google Cloud Functions v1
- Using `terraform` resources for deploy the functions

```js
// File cloudfunctionsv1.tf
// Cloud Functions v1
resource "google_cloudfunctions_function" "function" {
  name                  = "function-v1-resource"
  description           = "My function"
  runtime               = "nodejs10"
  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.default.name
  source_archive_object = google_storage_bucket_object.object.name
  trigger_http          = true
  timeout               = 60
  entry_point           = "helloHttp"
  labels = {
    my-label = "my-label-value"
  }
  environment_variables = {
    MY_ENV_VAR = "my-env-var-value"
  }
}

```

## Google cloud Functions v2
- Base on Cloud Run services

### Google cloud Functions v2 Resources
- Using `terraform` resources for v2 

```js
// file cloudfunctionsv2.tf
// Cloud Functions v2
resource "google_cloudfunctions2_function" "function" {
  name        = "function-v2-resource"
  location    = "us-central1"
  description = "a new function"

  build_config {
    runtime     = "nodejs16"
    entry_point = "helloHttp" # Set the entry point 
    source {
      storage_source {
        bucket = google_storage_bucket.default.name
        object = google_storage_bucket_object.object.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "256M"
    timeout_seconds    = 60
    ingress_settings   = "ALLOW_INTERNAL_ONLY"
  }
}

```

### Google cloud Functions v2 Module
- Using `terraform` module for v2 functions
```js
// file cloudfunctionsv2module.tf
module "cloud_functions2" {
  source  = "GoogleCloudPlatform/cloud-functions/google"
  version = "~> 0.6"

  # Required variables
  function_name     = "function-v2-module"
  project_id        = var.project_id
  function_location = var.region
  runtime           = "nodejs16"
  entrypoint        = "helloHttp"
  storage_source = {
    bucket = google_storage_bucket.default.name
    object = google_storage_bucket_object.object.name
  }
  service_config = {
    max_instance_count = 1
    available_memory   = "256M"
    timeout_seconds    = 60
    ingress_settings   = "ALLOW_INTERNAL_ONLY"
  }
}
```


# Deploy / Destroy

```bash
$ terraform init
$ terraform fmt
$ terraform validate
$ terraform apply -auto-approve
```
Destroy all resouces
```bash
$ terraform destroy
```

# References
- https://cloud.google.com/functions/docs/tutorials/terraform?hl=es-419
- https://cloud.google.com/nodejs/docs/setup?hl=es-419
- https://github.com/GoogleCloudPlatform/terraform-google-cloud-functions