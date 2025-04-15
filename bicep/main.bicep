// bicep/main.bicep

// Define a location parameter
param location string = 'East US'  // Default value if not passed

// Create Virtual Network 1 with address space 10.0.0.0/16
resource vnet1 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: 'vnet1'
  location: location  // Use the location parameter
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

// Create Virtual Network 2 with address space 10.1.0.0/16
resource vnet2 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: 'vnet2'
  location: location  // Use the location parameter
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
  }
}

// Deploy VNet peering from vnet1 to vnet2 using the peering module.
// The module is located at ../modules/peering.bicep relative to this file.
module peering1 '../modules/peering.bicep' = {
  name: 'peeringFromVnet1'
  scope: resourceGroup() // Deploy into the current resource group (NEW)
  params: {
    parentVnetName: vnet1.name
    remoteVnetId: vnet2.id
    peeringName: 'vnet1ToVnet2'
  }
}

// Deploy VNet peering from vnet2 to vnet1 (for bidirectional connectivity)
module peering2 '../modules/peering.bicep' = {
  name: 'peeringFromVnet2'
  scope: resourceGroup()
  params: {
    parentVnetName: vnet2.name
    remoteVnetId: vnet1.id
    peeringName: 'vnet2ToVnet1'
  }
}

output vnet1Id string = vnet1.id
output vnet2Id string = vnet2.id
