resource "google_compute_network" "vpc_network" {
  name                    = "my-custom-mode-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "default" {
  name          = "my-custom-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-west1"
  network       = google_compute_network.vpc_network.id
}

# Create a single Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "ubuntu-vm"
  machine_type = "e2-medium"
  zone         = "us-west1-a"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      #image = "ubuntu-os-cloud/ubuntu-2004-lts"
      image = "seed-labs-ubuntu"
      size  = 20  # 20GB boot disk size
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.default.id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  metadata = {
   ssh-keys = "ubuntu:${file("/home/admin_/.ssh/id_rsa.pub")}"  
}

connection {
  type        = "ssh"
  host        = self.network_interface[0].access_config[0].nat_ip
  user        = "ubuntu"  # or the appropriate username
  private_key = file("/home/admin_/.ssh/id_rsa")  # path to your private key
}

provisioner "file" {
   source= "/home/admin_/tf-tutorial/src-cloud"
   destination="/tmp/src-cloud"
}
# provisioner "remote-exec" {
#    inline = [
#    "chmod +x /tmp/src-cloud/install.sh",
#    "cd /tmp/src-cloud",
#    "sudo /tmp/src-cloud/install.sh"
# ]
# }
}

output "instance_startup_script" {
  value = google_compute_instance.default.metadata_startup_script
  description = "The startup script used by the instance"
}


resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "vnc" {
  name = "allow-vnc-again"
  allow {
    ports    = ["5901-5910"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["vnc"]
}
