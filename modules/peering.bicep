// modules/peering.bicep
// This module creates a virtual network peering for an existing virtual network.

// Input parameters: the parent VNet’s name, the remote VNet's resource ID,
// and the name to use for the peering.
param parentVnetName string
param remoteVnetId string
param peeringName string

// Declare the parent virtual network as an existing resource.
resource parentVnet 'Microsoft.Network/virtualNetworks@2021-03-01' existing = {
  name: parentVnetName
}

// Create the virtual network peering with the proper name format.
resource vnetPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-03-01' = {
  name: peeringName  // Only the peering name, without slashes
  parent: parentVnet
  properties: {
    remoteVirtualNetwork: {
      id: remoteVnetId
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

output peeringResourceId string = vnetPeering.id
