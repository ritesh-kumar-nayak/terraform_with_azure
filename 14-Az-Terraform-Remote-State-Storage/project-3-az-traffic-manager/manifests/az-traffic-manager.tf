# Resorce1: Traffic Manager Profile
resource "azurerm_traffic_manager_profile" "tm_profile" {
    name = "tmprofile-${random_string.random_name.id}"   # Name has to be unique across azure cloud
    resource_group_name = azurerm_resource_group.rg.name
    traffic_routing_method = "Weighted"
    dns_config {
      relative_name = "tmprofile-${random_string.random_name.id}"
      ttl = 100
    }
    monitor_config {
      protocol = "HTTPS"
      port = 80
      path = "/"
      interval_in_seconds = 30
      timeout_in_seconds = 9
      tolerated_number_of_failures = 3
    }

    tags = local.common_tags
  
}


# Traffic Manager Endpoint - Project-1-EastUs2

resource "azurerm_traffic_manager_azure_endpoint" "tm_endoint_project1_eastus2" {
    name = "tm-project1-eastus2"
    profile_id = azurerm_traffic_manager_profile.tm_profile.id
    weight = 50
   target_resource_id = data.terraform_remote_state.project1_eastus.outputs.web_lb_public_ip_id  # This is being refered from Remote datasource
   # target = data.terraform_remote_state.project1_eastus.outputs.web_lb_public_ip
    priority    = 1  # Explicitly set priority
}

# Traffic Manager Endpoint - Project-2-WestUs2
resource "azurerm_traffic_manager_azure_endpoint" "tm_endoint_project1_westus2" {
    name = "tm-project1-westus2"
    profile_id = azurerm_traffic_manager_profile.tm_profile.id
    weight = 50
    target_resource_id = data.terraform_remote_state.project2_westus.outputs.web_lb_public_ip_id # This is being refered from Remote datasource
    #target = data.terraform_remote_state.project2_westus.outputs.web_lb_public_ip
    priority    = 2  # Explicitly set priority

}