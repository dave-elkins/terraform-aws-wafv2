# Complete Example

More details coming soon

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.46 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_wafv2"></a> [wafv2](#module\_wafv2) | ../.. | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_wafv2_application_integration_url"></a> [wafv2\_application\_integration\_url](#output\_wafv2\_application\_integration\_url) | The URL to use in SDK integrations with managed rule groups. |
| <a name="output_wafv2_arn"></a> [wafv2\_arn](#output\_wafv2\_arn) | Web ACL ARN |
| <a name="output_wafv2_capacity"></a> [wafv2\_capacity](#output\_wafv2\_capacity) | The Web ACL Capacity Units (WCUs) currently being used by this Web ACL |
| <a name="output_wafv2_id"></a> [wafv2\_id](#output\_wafv2\_id) | Web ACL Id |
<!-- END_TF_DOCS -->
