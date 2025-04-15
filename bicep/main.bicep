// main.bicep

// Use a parameter for location because resourceGroup().location is not evaluable at compile time.
param location string

// Virtual Network 1: Create a VNet named 'vnet1' in the specified location.
resource vnet1 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: 'vnet1'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
  }
}

// Virtual Network 2: Create a VNet named 'vnet2' in the specified location.
resource vnet2 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: 'vnet2'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
  }
}

// Module call: Peering from vnet1 to vnet2.
// The module file is located at ../modules/peering.bicep relative to this main file.
module peering1 '../modules/peering.bicep' = {
  name: 'vnet1ToVnet2Peering'
  params: {
    vnet1Name: vnet1.name
    // Although we cannot use rg.location, resourceGroup().name is allowed.
    vnet1ResourceGroup: resourceGroup().name
    vnet2Id: vnet2.id
    peeringName: 'vnet1ToVnet2'
  }
}

// Module call: Peering from vnet2 to vnet1 (for bidirectional connectivity).
module peering2 '../modules/peering.bicep' = {
  name: 'vnet2ToVnet1Peering'
  params: {
    // When called from here, vnet1Name represents the VNet whose peering is being defined.
    vnet1Name: vnet2.name
    vnet1ResourceGroup: resourceGroup().name
    vnet2Id: vnet1.id
    peeringName: 'vnet2ToVnet1'
  }
}

output vnet1Name string = vnet1.name
output vnet2Name string = vnet2.name
output peering1Name string = peering1.name
output peering2Name string = peering2.name
