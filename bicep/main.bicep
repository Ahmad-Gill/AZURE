// bicep/main.bicep
// Static definitions for location and resource group

var location = 'East US'

// The resource group name is NEW.
// (This deployment is assumed to run in an existing resource group "NEW", 
// provided via your ARM deployment configuration.)
//
// Create VNet1
resource vnet1 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: 'vnet1'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

// Create VNet2
resource vnet2 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: 'vnet2'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
  }
}

// Deploy VNet Peering from vnet1 to vnet2.
// This module will create a peering resource under vnet1.
module peering1 '../modules/peering.bicep' = {
  name: 'peeringFromVnet1'
  scope: resourceGroup() // Deploy into the current resource group ("NEW")
  params: {
    parentVnetName: vnet1.name
    remoteVnetId: vnet2.id
    peeringName: 'vnet1ToVnet2'
  }
}

// (Optional) Deploy VNet Peering from vnet2 to vnet1 for bidirectional connectivity.
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
