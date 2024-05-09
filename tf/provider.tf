terraform {
  backend "gcs" {
    bucket = "demo-tf-state-sathi"
  }
}

provider "google" {
  project = "sathi-codey"
  region  = "europe-west4"
  zone    = "europe-west4-a"
}
