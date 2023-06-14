output "dsc-webserver_dns_name" {
  value = cloudflare_record.webserver_host.hostname
}