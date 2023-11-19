# Automating the creation of SEED lab VMs in GCP via Cloud Shell

This document provides instructions on configuring your GCP cloud environment to run preconfigured SEED lab VMs. Original instructions for creating a SEED lab VM in the Cloud were provided by kevin-w-du on [Github](https://github.com/seed-labs/seed-labs/blob/master/manuals/cloud/seedvm-cloud.md). 

Keep in mind Our ultimate goal project is to convert this setup to be used in Apache CloudStack. At this point configuration takes place within GCP and the terraform file is ran inside the cloud shell.

The terraform file in the \create_form_scratch directory attempts to automate creating the VM from scratch. It creates an ubuntu vm, along with vpc network and firewall rules for vnc and ssh, then uses the "remote-exec" type to invoke the install.sh script after creation.

The terraform file in \create_from_image automates setting up a Seed Labs VM from an image of an already created VM. Therefore, it doesn't use the install.sh script. 

Theoretically these two solutions could be combined. First, an admin would run the terraform setup form \create_form_scratch to create the initial Seed Labs VM. Next, they would create an image in GCP from this VM. Finally, they would use this newly created image as the boot disk parameter in the \create_from_image terraform file to create a copy of the Seed Labs VM for each user wanting to complete a lab. 

## Step 1: Download custom SEED labs image

First download the custom SEED labs image we created onto your local machine. 

(This is not available right now I have to either enable public access to the bucket I have the image in or download it and put it in a .zip file)
- [Seed Labs . image](./create_vm_aws.md)

## Step 2: Upload the .vmdk image to a bucket via the Cloud Storage API

- [Cloud Storage API](https://cloud.google.com/storage)

In order to create an image in Compute Engine from a .vmdk file it has to be stored in a bucket first within GCP. 

## Step 3  Create an image in Compute Engine

Go to images in Compute Engine and click the create image button. Choose the .vmdk file as the source. You will have to select it from the bucket you just uploaded it to. Name this image "seed-labs-ubuntu" so that it is the same as the boot disk parmeter in the terraform file.

## Step 4 Clone this repository Cloud Shell and run terraform file

```
git clone https://github.com/DanJenkins-Developer/seedlabs-cloud-port.git
```
Change directories into the /create_from_image directory
```
cd ~/seedlabs-cloud-port/create_from_image
```
At this point, you can run `terraform init` to add the necessary plugins and build the `.terraform directory`.
```
terraform init
```
You can validate the Terraform code that you've built so far by running `terraform plan`.
```
terraform plan
```

To create the VM, run `terraform apply`
```
terraform apply
```
## Step 5 Log in to the new Seed Labs VM
Log in via SSH to the user `seed` on the VM with password `dees`. 


## Issues

- VNC probably won't work right now. I've noticed that it will work on inital setup of a Seed Labs VM, but if you 1) stop the vm and then start if again or 2) create a Seed Labs VM from the image it won't.

## Notes

It seems like converting from a GCP to CloudStack terraform config might be pretty easy. Just look at this [article](https://www.shapeblue.com/automating-infrastructure-with-cloudstack-and-terraform/) on Automating Infrastructure with CloudStack and Terraform. Seems like all the resources we are using in the configs currently have equivilents in cloud stack. 


