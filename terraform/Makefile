.PHONY: init plan apply destroy
all: init plan apply

init:
	terraform init

plan:
	terraform plan -var-file="local.tfvars" -out=.terraform-plan 

apply:
	terraform apply .terraform-plan 

destroy:
	terraform destroy -var-file="local.tfvars" -auto-approve

