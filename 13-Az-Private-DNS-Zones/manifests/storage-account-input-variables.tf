variable "storage_account_name" {
  description = "Name of the storage accoun"
  type        = string

}
variable "storage_account_tier" {
  description = "Storage account tier"
  type        = string

}
variable "storage_account_access_tier" {
  description = "storag account access tier"
  type        = string
  default     = "Cool"

}
variable "storage_account_replication_type" {
  description = "Storage Account Replication Type"
  type        = string

}
variable "storage_account_kind" {
  description = "Storage account kind"
  type        = string

}
variable "static_websit_index_document" {
  description = "static website index document"
  type        = string

}
variable "static_website_error_404_document" {
  description = "static website error 404"
  type        = string

}
variable "httpd_files" {
  default = ["app1.conf"]
  type    = list(string)
}