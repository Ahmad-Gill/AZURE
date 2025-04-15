param location string = resourceGroup().location

resource vnet1 'Microsoft.Network/virtualNetworks@2021-05-01' = {
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

resource vnet2 'Microsoft.Network/virtualNetworks@2021-05-01' = {
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

// Add peering from vnet1 to vnet2
module peering1 'modules/peering.bicep' = {
  name: 'vnet1ToVnet2Peering'
  scope: resourceGroup()  // assuming both VNets are in same RG
  params: {
    vnet1Name: vnet1.name
    vnet1ResourceGroup: resourceGroup().name
    vnet2Id: vnet2.id
    peeringName: 'vnet1ToVnet2'
  }
}

// Optional: Add peering from vnet2 to vnet1 (if bidirectional)
module peering2 'modules/peering.bicep' = {
  name: 'vnet2ToVnet1Peering'
  scope: resourceGroup()
  params: {
    vnet1Name: vnet2.name
    vnet1ResourceGroup: resourceGroup().name
    vnet2Id: vnet1.id
    peeringName: 'vnet2ToVnet1'
  }
}
