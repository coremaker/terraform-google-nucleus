plugin "google" {
    enabled = true
    version = "0.19.0"
    source  = "github.com/terraform-linters/tflint-ruleset-google"
}
 
rule "terraform_naming_convention" {
    enabled = true
}

rule "terraform_unused_declarations" {
    enabled = true
}   

rule "terraform_typed_variables" {
    enabled = true
}
