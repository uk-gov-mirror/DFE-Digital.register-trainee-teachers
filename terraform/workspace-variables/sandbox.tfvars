# PaaS
paas_app_environment       = "sandbox"
env_config                 = "sandbox"
paas_space_name            = "bat-prod"
paas_postgres_service_plan = "small-11"
paas_redis_service_plan    = "micro-5_x"
paas_app_start_timeout     = "180"
paas_web_app_instances     = 2
paas_web_app_memory        = 512
paas_worker_app_instances  = 2
paas_worker_app_memory     = 512
paas_worker_app_stopped    = false

#KeyVault
key_vault_resource_group = "s121p01-shared-rg"

#StatusCake
statuscake_alerts = {
  alert = {
    website_name   = "register-sandbox"
    website_url    = "https://sandbox.register-trainee-teachers.education.gov.uk/ping"
    test_type      = "HTTP"
    check_rate     = 60
    contact_group  = [188603]
    trigger_rate   = 0
    node_locations = ["UKINT", "UK1", "MAN1", "MAN5", "DUB2"]
  }
}
