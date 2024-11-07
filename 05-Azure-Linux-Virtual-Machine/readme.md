To generate an SSH key pair for provisioning an Azure Linux VM via Terraform, use the following command:

`ssh-keygen -m PEM -t rsa -b 4096 -C "azureuser@myserver" -f terraform-azure.pem`

This command generates two files:

**terraform-azure.pem**: A private key file, used for securely logging into the VM.
**terraform-azure.pem.pub**: The corresponding public key, which will be placed inside the VM during VM provisioning for authentication.
The .pem file allows secure SSH access, while the .pub file ensures proper authentication when provisioning the VM through Terraform.

chmod 400 terraform-azure.pem