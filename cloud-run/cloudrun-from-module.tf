module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "~> 0.10.0"

  # Required variables
  service_name = "hello-run-module"
  project_id   = var.project_id
  location     = var.region
  image        = "gcr.io/cloudrun/hello"
}