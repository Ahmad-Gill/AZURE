param vnet1Name string
param vnet2Name string
param location string

resource vnet1 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: vnet1Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'infra'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'storage'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

resource vnet2 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: vnet2Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'infra'
        properties: {
          addressPrefix: '10.1.1.0/24'
        }
      }
      {
        name: 'storage'
        properties: {
          addressPrefix: '10.1.2.0/24'
        }
      }
    ]
  }
}

output vnet1Id string = vnet1.id
output vnet2Id string = vnet2.id
