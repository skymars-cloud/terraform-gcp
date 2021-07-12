//data "google_dns_keys" "zone1_dns_keys" {
//  managed_zone = google_dns_managed_zone.zone1.id
//}

resource "google_dns_managed_zone" "zone1" {
  name = "publiczone.example.com"
  dns_name = "publiczone.example.com."
  description = "Example public hosted zone"
  visibility = "public"

  dnssec_config {
    state = "off"
  }
  
}

