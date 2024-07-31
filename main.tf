terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.39.1"
    }
  }

  backend "gcs" {
    bucket  = "tf-migrate-bug-bash-bucket"
    prefix  = "deepflow/terraform/state"
  }
}

provider "google" {
  project = "hc-d8aabc271a62452c9193eb26451"
  region  = "us-central1"
}

resource "google_project_iam_custom_role" "gcs_viewer_role" {
  role_id     = "gcsViewerRole"  # Unique ID for the role within the project
  title       = "GCS Viewer Role"
  description = "Custom role with GCS Viewer permissions, updated on ${timestamp()}"
  project     = "hc-d8aabc271a62452c9193eb26451"

  permissions = [
    # Google Cloud Storage permissions
    "storage.buckets.get",
    "storage.buckets.list",
    "storage.objects.get",
    "storage.objects.list",
    "storage.objects.getIamPolicy",
    "storage.objects.setIamPolicy",
  ]

  stage = "GA"  # General Availability stage
}

output "role_name" {
  value = google_project_iam_custom_role.gcs_viewer_role.name
}
