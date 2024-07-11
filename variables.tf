variable "subscription_group_name" {
  description = "Subscription name used to tag resources"
  type        = string
}

variable "customer_names" {
  description = "List of customer names to create apps for"
  type        = list(string)
}

variable "subscription_id" {
  description = "The Subscription ID for Azure (sub1)"
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID for Azure (sub1)"
  type        = string
}

variable "client_id" {
  description = "The Client ID for the Azure Service Principal (sub1)"
  type        = string
}

variable "client_secret" {
  description = "The Client Secret for the Azure Service Principal (sub1)"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "The environment to deploy to"
  type        = string
  default     = "test"
  
}