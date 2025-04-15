// modules/peering.bicep
// This module creates a virtual network peering for an existing virtual network.

// Input parameters: the parent VNet’s name, the remote VNet's resource ID,
// and the name to use for the peering.
param parentVnetName string
param remoteVnetId string
param peeringName string

// Declare the parent virtual network as an existing resource.
// Explicitly set the scope to the current resource group so that
// Bicep looks for the VNet in the correct place.
resource parentVnet 'Microsoft.Network/virtualNetworks@2021-03-01' existing = {
  scope: resourceGroup()
  name: parentVnetName
}

// Create the virtual network peering using the provided peeringName.
// Note: When using the 'parent' property, the name of the child resource
// should be just the unique child identifier without any slashes.
resource vnetPeering 'Microsoft.Network/virtualNetworks/peerings@2021-05-01' = {
  name: peeringName
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
