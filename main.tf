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
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 20  # 20GB boot disk size
    }
  }


   metadata_startup_script = <<-EOF

    # Step 2.c: Install software and configure the systemd
    # export DEBIAN_FRONTEND=noninteractive  # Set non-interactive mode

    #!/bin/bash
	sudo -i
	#=================================================================
	# Most cloud platforms create a default account in the system.
	# We will not use this account for SEED labs. Instead, we will
	# create a new account called "seed", give it the privilege
	# to run "sudo" commands. 
	#=================================================================

	#================================================
	# Create a user account called "seed" if it does not exist. 
	# For security, we will not set the password for this account, 
	#   so nobody can ssh directly into this account. You need to 
	#   set up public keys to ssh directly into this account.
	sudo useradd -m -s /bin/bash seed 

	# Allow seed to run sudo commands without password
	sudo cp Files/System/seed_sudoers  /etc/sudoers.d/
	sudo chmod 440 /etc/sudoers.d/seed_sudoers

	# Set the USERID shell variable.
	USERID=seed

	# Set password for the seed user.
	# Replace 'yourpassword' with the actual password you want to set.
	echo 'seed:13881qwe' | sudo chpasswd

	# Edit the SSH server configuration to enable password authentication
	echo "Enabling PasswordAuthentication in SSH configuration..."
	sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

	# Restart the SSH service to apply the changes
	sudo service ssh restart


	echo "Password authentication for SSH has been enabled."



    EOF


  network_interface {
    subnetwork = google_compute_subnetwork.default.id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
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
