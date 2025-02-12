# Terraform Documentation

This documentation is automatically generated for all Terraform modules in this repository.

## Table of Contents

- [`environment/`](#module-environment-)
- [`modules//networking/`](#module-modules--networking-)

# Module: `environment/`

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_networking"></a> [networking](#module\_networking) | ../modules/networking | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | n/a | `list(string)` | n/a | yes |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | n/a | `string` | n/a | yes |
| <a name="input_database_subnets"></a> [database\_subnets](#input\_database\_subnets) | n/a | `list(string)` | n/a | yes |
| <a name="input_db_ingress_rules"></a> [db\_ingress\_rules](#input\_db\_ingress\_rules) | Dynamic ingress NACLS rules to database subnet | <pre>list(object({<br/>    port        = number<br/>    protocol    = string<br/>    description = string<br/>  }))</pre> | n/a | yes |
| <a name="input_enable_vpc_endpoint_dynamodb"></a> [enable\_vpc\_endpoint\_dynamodb](#input\_enable\_vpc\_endpoint\_dynamodb) | n/a | `bool` | n/a | yes |
| <a name="input_enable_vpc_endpoint_s3"></a> [enable\_vpc\_endpoint\_s3](#input\_enable\_vpc\_endpoint\_s3) | n/a | `bool` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | n/a | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | n/a | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `any` | n/a | yes |
| <a name="input_vertical_id"></a> [vertical\_id](#input\_vertical\_id) | n/a | `any` | n/a | yes |
| <a name="input_vpc_additional_cidrs"></a> [vpc\_additional\_cidrs](#input\_vpc\_additional\_cidrs) | n/a | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | n/a |
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | n/a |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | n/a |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | n/a |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | n/a |

---

# Module: `modules//networking/`

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_association.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_association) | resource |
| [aws_network_acl_rule.allow_db_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.deny](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route.private_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public-route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_route_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public-route-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.database_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_ipv4_cidr_block_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability Zones | `list(string)` | n/a | yes |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | VPC CIDR | `string` | n/a | yes |
| <a name="input_database_subnets"></a> [database\_subnets](#input\_database\_subnets) | Private Subnets for Database | `list(string)` | `[]` | no |
| <a name="input_db_ingress_rules"></a> [db\_ingress\_rules](#input\_db\_ingress\_rules) | Dynamic ingress NACLS rules to database subnet | <pre>list(object({<br/>    port        = number<br/>    protocol    = string<br/>    description = string<br/>  }))</pre> | n/a | yes |
| <a name="input_enable_vpc_endpoint_dynamodb"></a> [enable\_vpc\_endpoint\_dynamodb](#input\_enable\_vpc\_endpoint\_dynamodb) | Enable VPC Endpoint for DynamoDB | `bool` | n/a | yes |
| <a name="input_enable_vpc_endpoint_s3"></a> [enable\_vpc\_endpoint\_s3](#input\_enable\_vpc\_endpoint\_s3) | Enable VPC Endpoint for S3 | `bool` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | prefix Name | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Private Subnets | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Public Subnets | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region | `string` | n/a | yes |
| <a name="input_vpc_additional_cidrs"></a> [vpc\_additional\_cidrs](#input\_vpc\_additional\_cidrs) | IF you need, you can add new CIDRS for VPC | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | List of availability zones |
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | List of private subnets for database |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of private subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of public subnets |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | CIDR block of vpc |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | n/a |

---

