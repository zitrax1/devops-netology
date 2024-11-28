locals {

  VM1 = "${var.platform1}-${var.platform2}"
  VM2 = "${var.nat}-${var.instance}"
  VM3 = "${var.priv}-${var.priv1}"
 }

 variable "platform1" {
    type        = string
    default     = "public"
    description = "instance 1 name" 
 }
 variable "platform2" {
    type        = string
    default     = "machine"
    description = "instance 1 name1" 
 }

 variable "nat" {
    type        = string
    default     = "nat"
    description = "instance 2 name" 
 }
 variable "instance" {
    type        = string
    default     = "machine"
    description = "instance 2 name1" 
 }

  variable "priv" {
    type        = string
    default     = "private"
    description = "instance 2 name" 
 }
 variable "priv1" {
    type        = string
    default     = "machine"
    description = "instance 2 name1" 
 }