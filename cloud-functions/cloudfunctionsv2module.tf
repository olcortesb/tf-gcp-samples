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
