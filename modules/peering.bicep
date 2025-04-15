param vnet1Id string
param vnet2Id string

// Use the resourceId to declare existing VNets based on full ID
resource vnet1 'Microsoft.Network/virtualNetworks@2021-03-01' existing = {
  scope: resourceGroup()
  name: last(split(vnet1Id, '/'))
}

resource vnet2 'Microsoft.Network/virtualNetworks@2021-03-01' existing = {
  scope: resourceGroup()
  name: last(split(vnet2Id, '/'))
}

// VNet1 → VNet2 Peering
resource peering1 'Microsoft.Network/virtualNetworks/peerings@2021-08-01' = {
  name: 'peering-vnet1-to-vnet2'
  parent: vnet1
  properties: {
    remoteVirtualNetwork: {
      id: vnet2Id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

// VNet2 → VNet1 Peering
resource peering2 'Microsoft.Network/virtualNetworks/peerings@2021-08-01' = {
  name: 'peering-vnet2-to-vnet1'
  parent: vnet2
  properties: {
    remoteVirtualNetwork: {
      id: vnet1Id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

output peering1Id string = peering1.id
output peering2Id string = peering2.id
