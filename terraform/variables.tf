variable "project" {
  description = "Project"
  default = "new-york-taxi-njoune"
}

variable "region" {
  description = "Region"
  default = "us-central1"
}

variable "location" {
  description = "Project Location"
  default = "US"
}

variable "zone" {
  default = "us-central1-c"
}

variable "bq_dataset_name" {
  description = "Dataset Name"
  default = "zoomcamp_dataset"
}

variable "gcs_storage" {
  description = "Storage Bucket Name"
  default = "zoomcamp-bucket-syra-2025"
}
