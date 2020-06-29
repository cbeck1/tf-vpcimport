# Import AWS VPC into Terraform Enterprise state

## Create a VPC resource

Set environment variables for AWS

```
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."
```

Now lets create the VPC in AWS that we will later import into Terraform Enterprise state

```
cd vpc/
terraform init
terraform apply -auto-approve
```

A VPC will be provisioned in AWS and the VPC ID will be included in Terraform output. Capture the VPC ID for use later.

If you did not capture the VPC and need to display the output again using the following command:
`terraform output -json | jq '.vpcid["value"]'`

## Setup a workspace in Terraform Enterprise

If you have not previously setup a credentials file or set a Terraform Enterprise token, we can login and setup a token.

`terraform login hostname`

This will walk through the authentication process against Terraform Enterprise to generate a user token.
The API token will be saved locally in credentials.tfrc.json and Terraform will read from this file when it requires a token.

Once authenticated we will now configure a workspace in Terraform Enterprise where we will import the VPC state.

```
cd ..
cd tfesetup/
terraform init
terraform apply -auto-approve
```

Now that we have the VPC resource created, we can proceed to the import process.

## Import the VPC into Terraform Enterprise

Before attempting to import the VPC, we will need to first configure the remote backend in your Terraform configuration.

This will allow us to run Terraform commands remotely against Terraform Enterprise.

```
cd ..
cd importvpc/
```

Open `vpcimport.tf` in your preferred text editor and add the below block.

```
terraform {
  backend "remote" {
    hostname = "..."
    organization = "..."

    workspaces {
      name = "..."
    }
  }
}
```

Once you have saved this file, then initizalize Terraform and import the VPC.

```
terraform init
terraform import aws_vpc.main vpc-xxx
```

The VPC is now in Terraform Enterprise state.

## Validation

We can validate this by browsing to Terraform Enterprise server UI and go to the workspace and view the state in the state tab.

Additionally, we can now make a change to the VPC. When we kickoff the run we should now see Terrraform indicate it will change the resource instead of creating a brand new resource.

You should still be in the `importvpc` directory, we can now kickoff the run.

`terraform apply -auto-approve`
