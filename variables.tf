variable "BASE" {
  type      = string
  sensitive = true

  default = "NWE4MGY0MDgyYWIxNGU4ZGE3ZThmMmI5MmRjNmZhMTA6YTk2MzZkYWMxNTkwNDc2ZWEzNDFkZTJiNGQ2MDQzMWMK"
}
variable "DISCORD_TOKEN" {
  type      = string
  sensitive = true

  default = "NzI0MDEwNjY4NzUxMzIzMTk2.GCEU0W.ScSDqdC58sCKbvufhBqSgXRpuf1jm2C4Y9tXuE"
}
variable "REDIS" {
  type      = string
  sensitive = true

  default = "redis://:FsylLY2vWwyJ3MCfK028mRaX1nAyeQU9@redis-11962.c250.eu-central-1-1.ec2.cloud.redislabs.com:11962/0"
}
