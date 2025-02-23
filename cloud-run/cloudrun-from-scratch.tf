resource "google_cloud_run_v2_service" "default" {
  name     = "hello-run-resource"
  location = var.region
  client   = "terraform"
  ingress  = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
  template {
    containers {
      name  = "hello-run-resource"
      image = "gcr.io/cloudrun/hello"
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "noauth" {
  location = google_cloud_run_v2_service.default.location
  name     = google_cloud_run_v2_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}