locals {

  VM1 = "${var.platform1}-${var.platform2}"
  VM2 = "${var.platform-db1}-${var.platform-db2}"
 }

 variable "platform1" {
    type        = string
    default     = "netology"
    description = "instance 1 name" 
 }
 variable "platform2" {
    type        = string
    default     = "prod"
    description = "instance 1 name1" 
 }

 variable "platform-db1" {
    type        = string
    default     = "netology"
    description = "instance 2 name" 
 }
 variable "platform-db2" {
    type        = string
    default     = "test"
    description = "instance 2 name1" 
 }