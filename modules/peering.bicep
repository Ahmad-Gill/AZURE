param vnet1Name string
param vnet2Name string
param resourceGroupName string
param location string

resource vnet1 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: vnet1Name
  scope: resourceGroup(resourceGroupName)
}

resource vnet2 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: vnet2Name
  scope: resourceGroup(resourceGroupName)
}

resource peering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: 'peering-${vnet1.name}-to-${vnet2.name}'
  parent: vnet1
  location: location
  properties: {
    remoteVirtualNetwork: {
      id: vnet2.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

resource peering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: 'peering-${vnet2.name}-to-${vnet1.name}'
  parent: vnet2
  location: location
  properties: {
    remoteVirtualNetwork: {
      id: vnet1.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}
