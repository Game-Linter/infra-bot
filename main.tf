terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.53.1"
    }
  }
}

provider "google" {
  project = "music-master-343322"
  region  = "europe-southwest1"
}

data "google_container_registry_image" "some-bot" {
  name = "discordbot"
  tag  = "latest"
  #   region = "eu"
}


resource "google_cloud_run_service" "default" {
  name = "some-bot"

  location = "europe-west1"


  template {
    spec {
      containers {
        image = data.google_container_registry_image.some-bot.image_url

        env {
          name  = "BASE"
          value = var.BASE
        }

        env {
          name  = "DISCORD_TOKEN"
          value = var.DISCORD_TOKEN
        }

        env {
          name  = "REDIS"
          value = var.REDIS
        }

        env {
          name  = "NODE_ENV"
          value = "production"
        }

        ports {
          container_port = 3000
        }

        resources {
          limits = {
            cpu    = "1000m"
            memory = "512Mi"
          }
        }

      }

      container_concurrency = 1


    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"  = "1"
        "autoscaling.knative.dev/minScale"  = "1"
        "run.googleapis.com/cpu-throttling" = false
      }
    }
  }

  traffic {
    latest_revision = true
    percent         = 100
  }
}


data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
