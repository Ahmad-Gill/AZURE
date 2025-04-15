param storageAccount1Name string
param storageAccount2Name string
param vnet1Id string
param vnet2Id string
param location string

resource storage1 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccount1Name
  location: location
  properties: {
    sku: {
      name: 'Standard_ZRS'
    }
    kind: 'StorageV2'
    networkAcls: {
      virtualNetworkRules: [
        {
          id: '${vnet1Id}/subnets/storage'
        }
      ]
    }
  }
}

resource storage2 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccount2Name
  location: location
  properties: {
    sku: {
      name: 'Standard_ZRS'
    }
    kind: 'StorageV2'
    networkAcls: {
      virtualNetworkRules: [
        {
          id: '${vnet2Id}/subnets/storage'
        }
      ]
    }
  }
}

output storageAccount1Id string = storage1.id
output storageAccount2Id string = storage2.id
