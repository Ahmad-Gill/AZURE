param vnetName string
param location string
param addressPrefixes array = ['10.1.0.0/16']  // Adjusted to 10.1.0.0/16

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
          addressPrefix: '10.1.0.0/24'  // Adjusted to be inside the 10.1.0.0/16 range
        }
      }
    ]
  }
}

output vnetId string = vnet.id
