# Creating a SEED VM from an Image

This document provides instructions on configuring your GCP cloud environment for running a preconfigured SEED lab VM. Original instructions for creating a SEED lab VM in the Cloud were provided by kevin-w-du on [Github](https://github.com/seed-labs/seed-labs/blob/master/manuals/cloud/seedvm-cloud.md). The terraform file in the \create_form_scratch directory attempts to automate this process. 

The ultimate goal project is to convert this setup to be used in Apache CloudStack. At this point configuration takes place within GCP and the terraform file is ran inside the cloud shell.


## Step 1: Download custom SEED labs image

First download the custom SEED labs image we created onto your local machine. 

- [Seed Labs . image](./create_vm_aws.md)

This image was created by following the steps provided by SEED Labs, see their [github](https://github.com/seed-labs/seed-labs/blob/master/manuals/cloud/seedvm-cloud.md.). They only provided the steps to download dependencies and create the user's while we provide the actual image. 

## Step 2: Upload the .vmdk image to a bucket via the Cloud Storage API

- [Cloud Storage API](https://cloud.google.com/storage)

In order to create an image in Compute Engine from a .vmdk file it has to be stored in a bucket first within GCP. 

## Step 3  Create an image in Compute Engine

Go to images in Compute Engine and click the create image button. Choose the .vmdk file as the source. 
You will have to select it from the bucket you just uploaded it to. Name this image "seed-labs-ubuntu".

## Step 4 (Option B: Access the VM Using SSH

To run VNC, you need to have reasonable bandwidth. If your VNC performance
is bad, you should switch to SSH. You can get by with many of the
SEED labs using just terminals. There are many ways to SSH into the
cloud VM:

- Most cloud platforms provide a default browser-based SSH client.
  Google cloud's SSH client even allows you to upload and download files,
  which is very convenient.

- You can also find many third-party SSH clients. Some clouds may have
  disabled the password authentication in SSH, so you have to use
  public keys for the authentication.
  You need to generate public/private key pairs on your SSH client machine,
  and save the public key into the `/home/seed/.ssh/authorized_keys` file on
  the server machine. You can easily find
  instructions from online resources, so we will not provide one here.


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
