resource "tls_private_key" "rsa_private_key" {
  algorithm = "RSA"
  #rsa_bits  = 4096
}


resource "acme_registration" "acme_registration" {
  account_key_pem = tls_private_key.rsa_private_key.private_key_pem
  email_address   = var.dsc-acme_email_address
}


resource "acme_certificate" "acme_certificate" {
  account_key_pem           = acme_registration.acme_registration.account_key_pem
  common_name               = "${var.dsc-cloudflare_a_record_name}.zsoltika.uk"

  dns_challenge {
    provider = "cloudflare"
  }
}


resource "azurerm_storage_blob" "blob-fileset-root" {
  for_each = fileset("${path.root}/files_upload", "**") # ** = recursive

  name                   = each.key
  storage_account_name   = var.dsc-storage_account_name
  storage_container_name = var.dsc-container_2_name
  type                   = "Block"
  content_md5            = filemd5("/files_upload/${each.key}")
  source                 = "${path.root}/files_upload/${each.key}"
}


resource "azurerm_storage_blob" "blob-fileset-dsc_module" {
  for_each = fileset("${path.module}/files_upload", "**") # ** = recursive

  name                   = each.key
  storage_account_name   = var.dsc-storage_account_name
  storage_container_name = var.dsc-container_2_name
  type                   = "Block"
  content_md5            = filemd5("${path.module}/files_upload/${each.key}")
  source                 = "${path.module}/files_upload/${each.key}"
}


resource "azurerm_storage_blob" "blob-acme_private_key" {
  name                   = "acme.key"
  storage_account_name   = var.dsc-storage_account_name
  storage_container_name = var.dsc-container_1_name
  type                   = "Block"
  source_content         = acme_certificate.acme_certificate.private_key_pem
}

resource "azurerm_storage_blob" "blob-acme_certificate" {
  name                   = "acme.crt"
  storage_account_name   = var.dsc-storage_account_name
  storage_container_name = var.dsc-container_1_name
  type                   = "Block"
  source_content         = acme_certificate.acme_certificate.certificate_pem
}

/*
resource "null_resource" "public_ip_check" {
  
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = "echo ${var.dsc-cloudflare_public_ip}"
  }
}
*/

resource "cloudflare_record" "webserver_host" {
  zone_id = var.dsc-cloudflare_zone_id
  name    = var.dsc-cloudflare_a_record_name
  value   = var.dsc-cloudflare_public_ip
  type    = "A"
  ttl     = 3600
}
