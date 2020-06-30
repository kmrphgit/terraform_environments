data "azurerm_management_group" "root_mgmt" {
    name = "root_mgmt"
}

resource "azurerm_role_definition" "almost_owner" {
  name        = "kloudmorph_owner"
  scope       = data.azurerm_management_group.root_mgmt.id
  description = "This is a custom role created via Terraform"

  permissions {
    actions     = ["*"]
    not_actions = [
        "Microsoft.Authorization/elevateAccess/action",
        "Microsoft.Authorization/classicAdministrators/read",
        "Microsoft.Authorization/classicAdministrators/write",
        "Microsoft.Authorization/classicAdministrators/delete",
        "Microsoft.Authorization/roleAssignments/read",
        "Microsoft.Authorization/roleAssignments/write",
        "Microsoft.Authorization/roleAssignments/delete",
        "Microsoft.Authorization/permissions/read",
        "Microsoft.Authorization/locks/read",
        "Microsoft.Authorization/locks/write",
        "Microsoft.Authorization/locks/delete",
        "Microsoft.Authorization/roleDefinitions/read",
        "Microsoft.Authorization/roleDefinitions/write",
        "Microsoft.Authorization/roleDefinitions/delete",
        "Microsoft.Authorization/providerOperations/read",
        "Microsoft.Authorization/policySetDefinitions/read",
        "Microsoft.Authorization/policySetDefinitions/write",
        "Microsoft.Authorization/policySetDefinitions/delete",
        "Microsoft.Authorization/policyDefinitions/read",
        "Microsoft.Authorization/policyDefinitions/write",
        "Microsoft.Authorization/policyDefinitions/delete",
        "Microsoft.Authorization/policyAssignments/read",
        "Microsoft.Authorization/policyAssignments/write",
        "Microsoft.Authorization/policyAssignments/delete",
        "Microsoft.Authorization/operations/read",
        "Microsoft.Authorization/classicAdministrators/operationstatuses/read",
        "Microsoft.Authorization/denyAssignments/read",
        "Microsoft.Authorization/denyAssignments/write",
        "Microsoft.Authorization/denyAssignments/delete",
        "Microsoft.Authorization/policyAssignments/resourceManagementPrivateLinks/read",
        "Microsoft.Authorization/policyAssignments/resourceManagementPrivateLinks/write",
        "Microsoft.Authorization/policyAssignments/resourceManagementPrivateLinks/delete",
        "Microsoft.Authorization/policyAssignments/resourceManagementPrivateLinks/privateEndpointConnectionProxies/read",
        "Microsoft.Authorization/policyAssignments/resourceManagementPrivateLinks/privateEndpointConnectionProxies/write",
        "Microsoft.Authorization/policyAssignments/resourceManagementPrivateLinks/privateEndpointConnectionProxies/delete",
        "Microsoft.Authorization/policyAssignments/resourceManagementPrivateLinks/privateEndpointConnectionProxies/validate/action",
        "Microsoft.Authorization/policyAssignments/resourceManagementPrivateLinks/privateEndpointConnections/read",
        "Microsoft.Authorization/policyAssignments/resourceManagementPrivateLinks/privateEndpointConnections/write",
        "Microsoft.Authorization/policyAssignments/resourceManagementPrivateLinks/privateEndpointConnections/delete",
        "Microsoft.Authorization/policyAssignments/privateLinkAssociations/read",
        "Microsoft.Authorization/policyAssignments/privateLinkAssociations/write",
        "Microsoft.Authorization/policyAssignments/privateLinkAssociations/delete"
    ]
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id, # /subscriptions/00000000-0000-0000-0000-000000000000
  ]
}
