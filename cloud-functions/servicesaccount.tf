# Services account and project services
resource "google_service_account" "account" {
  account_id   = "gcf-sa"
  display_name = "Test Service Account"
}

resource "google_project_service" "cloud_run_api" {
  service = "run.googleapis.com" // Service name
}
