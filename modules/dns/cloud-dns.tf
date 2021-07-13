//data "google_dns_keys" "zone1_dns_keys" {
//  managed_zone = google_dns_managed_zone.zone1.id
//}

resource "google_dns_managed_zone" "zone1" {
  name        = "publiczone"
  dns_name    = "publiczone.gsecurity.net."
  description = "Example public hosted zone"
  visibility  = "public"
  project     = var.project_id

  dnssec_config {
    //        state = "on"
    state = "off"
    //    kind          = "dns#managedZoneDnsSecConfig"
    //    non_existence = "nsec3"
    //    default_key_specs {
    //      key_type = "keySigning"
    //      //      key_type = "zoneSigning"     //      ZONE_SIGNING / RSASHA1 / 1024
    //      key_length = 1024
    //      kind       = "dns#dnsKeySpec"
    //      algorithm = "rsasha1"
    //      //      ecdsap256sha256 ecdsap384sha384 rsasha1 rsasha256 rsasha512   //algorithm allowed values
    //    }
  }

}

