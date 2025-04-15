// modules/vnet.bicep
param vnetName string
param addressPrefix string
param infraSubnetPrefix string
param storageSubnetPrefix string

resource vnet 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: vnetName
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: 'infraSubnet'
        properties: {
          addressPrefix: infraSubnetPrefix
        }
      }
      {
        name: 'storageSubnet'
        properties: {
          addressPrefix: storageSubnetPrefix
        }
      }
    ]
  }
}

output infraSubnetId string = vnet.properties.subnets[0].id
output storageSubnetId string = vnet.properties.subnets[1].id
