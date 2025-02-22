# Cloud Functions v2
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

resource "google_cloud_run_service_iam_member" "member" {
  location = google_cloudfunctions2_function.function.location
  service  = google_cloudfunctions2_function.function.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}