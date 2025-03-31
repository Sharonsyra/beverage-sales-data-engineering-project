variable "project" {
  description = "Project"
  default = null
}

variable "region" {
  description = "Region"
  default = null
}

variable "location" {
  description = "Project Location"
  default = null
}

variable "zone" {
  default = null
}

variable "bq_dataset_name" {
  default = null
  description = "Dataset Name"
}

variable "gcs_storage" {
  default = null
  description = "Storage Bucket Name"
#  default = "zoomcamp-bucket-syra-2025"
}
