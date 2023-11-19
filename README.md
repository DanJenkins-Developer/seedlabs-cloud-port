Steps for creating vm from image:

1. Activate Cloud Shell and set current project with "gcloud config set project PROJECT_ID"
2. Download the Seedlabs .vmdk image from https://storage.cloud.google.com/seed-labs-bucket/seed-labs-ubuntu.vmdk
3. Create an image in Compute Engine and use the .vmdk file as the source. Name this image "seed-labs-ubuntu"
4. Activate Cloud Shell and set current project with "gcloud config set project PROJECT_ID"
5. git clone https://github.com/DanJenkins-Developer/seedlabs-cloud-port.git into your prefered directory
6. Run "terraform init" to add the necessary plugins and build the .terraform directory.
7. Run "terraform plan" to verrify syntx
8. Run "terraform apply" to create the VM.



Steps for creating vm from scratch:

1. Activate Cloud Shell and set current project with "gcloud config set project PROJECT_ID"
2. git clone https://github.com/DanJenkins-Developer/seedlabs-cloud-port.git into your prefered directory
3. Run "terraform init" to add the necessary plugins and build the .terraform directory.
4. Run "terraform plan" to verrify syntx
5. Run "terraform apply" to create the VM.

Set up script adapted from "Creating a SEED VM on the Cloud" install script provided by kevin-w-du
https://github.com/seed-labs/seed-labs/blob/master/manuals/cloud/seedvm-cloud.md