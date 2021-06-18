
resource "google_compute_global_address" "ext-ip-cg-appserver" {
  name = "global-ext-ip-cg-appserver"
}

resource "google_dns_managed_zone" "cg-dev" {
  name     = "dev-zone"
  dns_name = "cg-dev.${var.project_name}.${var.org_name}."
}

resource "google_dns_record_set" "cg-frontend" {
  name = "lb.${google_dns_managed_zone.cg-dev.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.cg-dev.name

  rrdatas = [google_compute_global_address.ext-ip-cg-appserver.address]
  depends_on = [
    google_compute_global_address.ext-ip-cg-appserver,
    google_dns_managed_zone.cg-dev
  ]
}

