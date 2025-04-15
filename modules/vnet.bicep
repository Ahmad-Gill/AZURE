param vnetName string
param location string
param addressPrefixes array = ['10.0.0.0/16']

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
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

output vnetId string = vnet.id
