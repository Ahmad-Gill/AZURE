param vnet1 object
param vnet2 object



//Peer from vnet1 to vnet2
resource peer1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: '${vnet1.name}/to-${vnet2.name}'
  properties: {
    remoteVirtualNetwork: {
      id: vnet2.id      //This tells Azure that the remote VNET  is the second VNET
    }
    allowVirtualNetworkAccess: true
  }
}

resource peer2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: '${vnet2.name}/to-${vnet1.name}'
  properties: {
    remoteVirtualNetwork: {
      id: vnet1.id
    }
    allowVirtualNetworkAccess: true
  }
}
