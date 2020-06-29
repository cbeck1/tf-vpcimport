#Creates a new workspace in TFE

provider "tfe" {
  hostname = ".."
}

resource "tfe_workspace" "demoworkspace" {
    name = "demoworkspace"
    organization = ".."
    operations = false
}