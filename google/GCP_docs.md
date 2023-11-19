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

## Notes on Cost

Unless you have a special deal with cloud company, you will
be charged for using the cloud VM. Please keep an eye on your bill,
because sometimes, there are costs that you may
not be aware of, such as bandwidth cost, storage cost, etc.
Understanding where your expense is can help you reduce it.
Moreover, to avoid wasting money, remember to
suspend your VMs if you are not working on them. Although a
suspended VM still incurs storage cost (usually very small), it
does not incur any computing costs. You can easily resume them
when you are ready to continue your work.
