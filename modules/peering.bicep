// modules/peering.bicep
// This module creates a virtual network peering for an existing virtual network.

// Input parameters: the parent VNet’s name, the remote VNet's resource ID,
// and the name to use for the peering.
param parentVnetName string
param remoteVnetId string
param peeringName string

// (Optional) Declare the parent virtual network as an existing resource.
// This declaration is optional if you don't need to reference properties of the parent.
resource parentVnet 'Microsoft.Network/virtualNetworks@2021-03-01' existing = {
  name: parentVnetName
}

// Create the virtual network peering. When you use the 'parent' property,
// the resource name should be just the child name without any slashes.
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
