# Cloud Functions v1
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