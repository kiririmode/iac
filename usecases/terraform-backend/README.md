# terraform-backend

terraform の remote backend を構成します。

# Usage

TODO: きちんと書く

最初に、config/backend-${env}.conf の内容を修正してください。
その後、以下を実行します。

```bash
$ terraform plan -var-file=../../config/backend-${env}.conf
$ terraform apply -var-file=../../config/backend-${env}.conf
```
