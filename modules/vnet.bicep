param vnetName string
param location string
param addressPrefixes array  // e.g., ['10.0.0.0/16'] or ['10.1.0.0/16']
param subnetPrefix string      // e.g., '10.0.1.0/24' or '10.1.1.0/24'

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: [
      {
        name: 'infra'
        properties: {
          addressPrefix: subnetPrefix
        }
      }
    ]
  }
}

output vnetId string = vnet.id
