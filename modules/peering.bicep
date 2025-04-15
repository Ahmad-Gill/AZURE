// modules/peering.bicep
// This module creates a virtual network peering for an existing virtual network.

param parentVnetName string
param remoteVnetId string
param peeringName string

// Declare the parent virtual network as an existing resource.
resource parentVnet 'Microsoft.Network/virtualNetworks@2021-03-01' existing = {
  name: parentVnetName
}

// Create the virtual network peering with the proper name format.
resource vnetPeering 'Microsoft.Network/virtualNetworks/peerings@2021-05-01' = {
  name: peeringName  // Using the provided peering name parameter
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
