@secure() param Password string // Mark Password as secure

// Define the location as 'East US' explicitly
var location = 'East US'

// Define the resource group with the name 'NEW' and location set to 'East US'
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'NEW'
  location: location
}

// Use the relative path to the peering module
module peering '../modules/peering.bicep' = {
  name: 'peeringDeployment'
  scope: subscription() // Set the scope to subscription
  params: {
    location: location
    password: Password
  }
}

// Example of defining a virtual network resource
resource vnet 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: 'vnet1'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
  }
}

// Define a subnet within the virtual network
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-03-01' = {
  parent: vnet
  name: 'subnet1'
  properties: {
    addressPrefix: '10.0.1.0/24'
  }
}
