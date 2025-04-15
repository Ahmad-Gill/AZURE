param location string
param password string

// Example resource definition in a module
resource peeringResource 'Microsoft.Network/virtualNetworks/peerings@2021-03-01' = {
  name: 'vnetPeering1'  // Ensure valid naming without '/'
  properties: {
    remoteVirtualNetwork: {
      id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Network/virtualNetworks/{remoteVnet}'
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
  }
}
