

output "function_v1_uri" {
  value = google_cloudfunctions_function.function.https_trigger_url
}

output "function_v2_uri" {
  value = google_cloudfunctions2_function.function.service_config[0]
}

output "function_v2_module_uri" {
  value = module.cloud_functions2.function_uri
}