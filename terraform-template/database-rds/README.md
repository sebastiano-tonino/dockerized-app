# Database RDS

```sh
export envfile=
export workspace=
```

```sh
tofu init --var-env=$envfile
```


```sh
terraform workspace new $workspace
```
```sh
terraform workspace select $workspace
```

```sh
tofu plan --var-env=$envfile
```

```sh
tofu apply --var-env=$envfile
```