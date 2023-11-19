This doesn't quite work yet, for some portion of the setupscript that enables password authentication doesn't work.  

1. Activate Cloud Shell and set current project with "gcloud config set project PROJECT_ID"
2. git clone https://github.com/DanJenkins-Developer/seedlabs-cloud-port.git into your prefered directory
3. Run "terraform init" to add the necessary plugins and build the .terraform directory.
4. Run "terraform plan" to verrify syntx
5. Run "terraform apply" to create the VM.

Set up script adapted from "Creating a SEED VM on the Cloud" install script provided by kevin-w-du
https://github.com/seed-labs/seed-labs/blob/master/manuals/cloud/seedvm-cloud.md