param vnet1Name string
param vnet2Name string
param vnet1Id string
param vnet2Id string

resource vnet1 'Microsoft.Network/virtualNetworks@2021-03-01' existing = {
  name: vnet1Name
}

resource vnet2 'Microsoft.Network/virtualNetworks@2021-03-01' existing = {
  name: vnet2Name
}

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
