// modules/peering.bicep
// This module creates a VNet peering on an existing virtual network.

// Parameters for the parent VNet and the remote VNet
param parentVnetName string
param remoteVnetId string
param peeringName string

// Create the VNet peering resource.
// The name must be of the form: "{parentVnetName}/{peeringName}" – this produces exactly one "/" separator.
resource vnetPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-03-01' = {
  name: '${parentVnetName}/${peeringName}'
  // Set the parent to the existing virtual network using its name.
  parent: existingResource('Microsoft.Network/virtualNetworks', parentVnetName)
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
