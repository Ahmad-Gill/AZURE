param location string = 'East US'
param adminUsername string
@secure()
param adminPassword string

module vnet1 '../modules/vnet.bicep' = {
  name: 'vnet1Module'
  params: {
    vnetName: 'vnet1'
    location: location
    addressPrefixes: ['10.0.0.0/16']
  }
}

module vnet2 '../modules/vnet.bicep' = {
  name: 'vnet2Module'
  params: {
    vnetName: 'vnet2'
    location: location
    addressPrefixes: ['10.1.0.0/16']
  }
}


module peering '../modules/peering.bicep' = {
  name: 'vnetPeering'
  params: {
    parentVnetName: 'vnet1'
    remoteVnetId: vnet2.outputs.vnetId
    peeringName: 'vnet1-to-vnet2'
  }
}

module vm1 '../modules/vm.bicep' = {
  name: 'vm1Deploy'
  params: {
    vmName: 'vm1'
    location: location
    subnetId: '${vnet1.outputs.vnetId}/subnets/infra'
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}

module vm2 '../modules/vm.bicep' = {
  name: 'vm2Deploy'
  params: {
    vmName: 'vm2'
    location: location
    subnetId: '${vnet2.outputs.vnetId}/subnets/infra'
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}

module storage1 '../modules/storage.bicep' = {
  name: 'storage1Deploy'
  params: {
    storageAccountName: 'stg1${uniqueString(resourceGroup().id)}'
    location: location
  }
}

module storage2 '../modules/storage.bicep' = {
  name: 'storage2Deploy'
  params: {
    storageAccountName: 'stg2${uniqueString(resourceGroup().id)}'
    location: location
  }
}

