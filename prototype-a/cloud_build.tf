resource "google_cloudbuild_trigger" "basic_express_trigger" {
  name           = "basic-express-trigger"
  included_files = ["nodejs-containers/basic-express/**"]
  github {
    owner = var.github_repo_owner
    name  = var.github_repo_name
    # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger#included_files
    push {
      branch = "^main$"
    }
  }
  service_account = google_service_account.cloud_build_basic_express_sa.id
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger#service_account
  filename   = "nodejs-containers/basic-express/cloudbuild.yaml"
  depends_on = [google_project_service.cloud_run]
  # https://github.com/Lioric/go-cloud/blob/0a3580612654e801b29df8d786d64f53da227867/samples/guestbook/gcp/main.tf
}

# need to connect github repo in console first for this to work
