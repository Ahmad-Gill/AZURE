param location string = 'eastus'
param adminUsername string
@secure()
param adminPassword string

// Deploy VNet 1
module vnet1 '../modules/vnet.bicep' = {
  name: 'vnet1Deploy'
  params: {
    vnetName: 'vnet1'
    location: location
    addressPrefixes: ['10.1.0.0/16']
    subnetPrefix: '10.1.0.0/24'
  }
}

// Deploy VNet 2
module vnet2 '../modules/vnet.bicep' = {
  name: 'vnet2Deploy'
  params: {
    vnetName: 'vnet2'
    location: location
    addressPrefixes: ['10.2.0.0/16']
    subnetPrefix: '10.2.0.0/24'
  }
}

// VNet Peering: vnet1 → vnet2
module peerVnet1toVnet2 '../modules/peering.bicep' = {
  name: 'peerVnet1toVnet2'
  params: {
    vnet1Id: vnet1.outputs.vnetId
    vnet2Id: vnet2.outputs.vnetId
  }
  dependsOn: [
    vnet1
    vnet2
  ]
}

// VNet Peering: vnet2 → vnet1
module peerVnet2toVnet1 '../modules/peering.bicep' = {
  name: 'peerVnet2toVnet1'
  params: {
    vnet1Id: vnet1.outputs.vnetId
    vnet2Id: vnet2.outputs.vnetId
  }
  dependsOn: [
    vnet1
    vnet2
  ]
}

// Deploy VM in VNet 1
module vm1 '../modules/vm.bicep' = {
  name: 'vm1Deploy'
  params: {
    vmName: 'vm1'
    location: location
    subnetId: '${vnet1.outputs.vnetId}/subnets/infra'
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
  dependsOn: [
    vnet1
  ]
}

// Deploy VM in VNet 2
module vm2 '../modules/vm.bicep' = {
  name: 'vm2Deploy'
  params: {
    vmName: 'vm2'
    location: location
    subnetId: '${vnet2.outputs.vnetId}/subnets/infra'
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
  dependsOn: [
    vnet2
  ]
}

// Storage Account 1
module storage1 '../modules/storage.bicep' = {
  name: 'storage1Deploy'
  params: {
    storageAccountName: 'stg1${uniqueString(resourceGroup().id)}'
    location: location
  }
}

// Storage Account 2
module storage2 '../modules/storage.bicep' = {
  name: 'storage2Deploy'
  params: {
    storageAccountName: 'stg2${uniqueString(resourceGroup().id)}'
    location: location
  }
}
