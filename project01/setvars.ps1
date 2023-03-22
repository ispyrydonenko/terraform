# $env:TF_VAR_sql_admin_password = "4-v3ry-53cr37-p455w0rd"
# $env:TF_VAR_sql_admin_login = "sqladm"
$env:TF_VAR_DOCKER_REGISTRY_SERVER_USERNAME = ""
$env:TF_VAR_DOCKER_REGISTRY_SERVER_PASSWORD = ""

terraform fmt -recursive ../
