param vnet1 object
param vnet2 object

resource peer1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: '${vnet1.name}/to-${vnet2.name}'
  properties: {
    remoteVirtualNetwork: {
      id: vnet2.id
    }
    allowVirtualNetworkAccess: true
  }
}

resource peer2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: '${vnet2.name}/to-${vnet1.name}'
  properties: {
    remoteVirtualNetwork: {
      id
::contentReference[oaicite:12]{index=12}
 
