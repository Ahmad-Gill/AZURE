param vnet1Name string
param vnet2Name string
param addressPrefix string
param infraSubnetPrefix string
param storageSubnetPrefix string

resource vnet1 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: vnet1Name
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

resource vnet2 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: vnet2Name
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
