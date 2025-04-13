param name string
param location string
param subnetId string

resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: name
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_ZRS' // ZRS is the requirement
  }
  properties: {
    networkAcls: {
      virtualNetworkRules: [
        {
          id: subnetId       //This means that traffic from the specified virtual network is allowed.
          action: 'Allow'
        }
      ]
      defaultAction: 'Deny'
    }
  }
}
