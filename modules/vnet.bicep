param name string
param location string
param addressPrefix string
param infraSubnetPrefix string
param storageSubnetPrefix string

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: 'infra'
        properties: {
          addressPrefix: infraSubnetPrefix
        }
      }
      {
        name: 'storage'
        properties: {
          addressPrefix: storageSubnetPrefix
        }
      }
    ]
  }
}

output vnet object = vnet
output infraSubnetId string = vnet.properties.subnets[0].id
output storageSubnetId string = vnet.properties.subnets[1].id
