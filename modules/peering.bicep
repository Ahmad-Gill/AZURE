param vnet1Name string
param vnet1ResourceGroup string
param vnet2Id string
param peeringName string

resource vnet1 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: vnet1Name
  scope: resourceGroup(vnet1ResourceGroup)
}

resource vnetPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: '${vnet1.name}/${peeringName}'
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
