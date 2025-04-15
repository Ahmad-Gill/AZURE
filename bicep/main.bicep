// main.bicep

// Define resource group to deploy to
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'myResourceGroup'
  location: 'East US' // Directly specify the location here
}

// Define virtual network 1
resource vnet1 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: 'vnet1'
  location: rg.location // Assign location directly from the resource group
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
  }
}

// Define virtual network 2
resource vnet2 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: 'vnet2'
  location: rg.location // Assign location directly from the resource group
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
  }
}

// Import peering module for creating peering between VNet 1 and VNet 2
module peering1 '../modules/peering.bicep' = {
  name: 'vnet1ToVnet2Peering'
  params: {
    vnet1Name: vnet1.name
    vnet1ResourceGroup: rg.name
    vnet2Id: vnet2.id
    peeringName: 'vnet1ToVnet2'
  }
}

// Import peering module for creating peering between VNet 2 and VNet 1
module peering2 '../modules/peering.bicep' = {
  name: 'vnet2ToVnet1Peering'
  params: {
    vnet1Name: vnet2.name
    vnet1ResourceGroup: rg.name
    vnet2Id: vnet1.id
    peeringName: 'vnet2ToVnet1'
  }
}

// Output for the virtual networks and peering
output vnet1Name string = vnet1.name
output vnet2Name string = vnet2.name
output peering1Name string = peering1.name
output peering2Name string = peering2.name
