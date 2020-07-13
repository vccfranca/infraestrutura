provider "aws" {
  region = "us-east-1"
  alias  = "dev1"
  shared_credentials_file = "Arquivo credentials"
  profile = "nome_profile"
}

provider "aws" {
  region = "us-east-2"
  alias  = "dev2"
  shared_credentials_file = "Arquivo credentials"
  profile = "nome_profile"
}