param location string
param Password string

// Define the resource group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'myResourceGroup'
  location: location
}

// Include submodule for peering
module peering 'modules/peering.bicep' = {
  name: 'peeringDeployment'
  scope: rg // Ensure scope is explicitly defined
  params: {
    location: location
    password: Password
  }
}

// Example of defining a resource with proper naming convention
resource vnet 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: 'vnet1'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
  }
}

// Ensure all resources have names without '/'
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-03-01' = {
  parent: vnet
  name: 'subnet1'
  properties: {
    addressPrefix: '10.0.1.0/24'
  }
}
