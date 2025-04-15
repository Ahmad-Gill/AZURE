// bicep/main.bicep

param location string = 'East US'
param adminUsername string
@secure()
param adminPassword string

// Deploy VNet 1 using the vnet module
module vnet1 '../modules/vnet.bicep' = {
  name: 'vnet1Deploy'
  params: {
    vnetName: 'vnet1'
    location: location
    addressPrefixes: ['10.0.0.0/16']
    subnetPrefix: '10.0.1.0/24'
  }
}

// Deploy VNet 2 using the vnet module
module vnet2 '../modules/vnet.bicep' = {
  name: 'vnet2Deploy'
  params: {
    vnetName: 'vnet2'
    location: location
    addressPrefixes: ['10.1.0.0/16']
    subnetPrefix: '10.1.1.0/24'
  }
}

// Create bidirectional VNet Peering between vnet1 and vnet2
// This module creates two peerings—one from vnet1 to vnet2, and another from vnet2 to vnet1.
module peering '../modules/peering.bicep' = {
  name: 'vnetPeering'
  dependsOn: [
    vnet1
    vnet2
  ]
  params: {
    vnet1Id: vnet1.outputs.vnetId
    vnet2Id: vnet2.outputs.vnetId
  }
}

// Deploy VM in VNet 1 using the vm module
module vm1 '../modules/vm.bicep' = {
  name: 'vm1Deploy'
  dependsOn: [
    vnet1
  ]
  params: {
    vmName: 'vm1'
    location: location
    subnetId: '${vnet1.outputs.vnetId}/subnets/infra'
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}

// Deploy VM in VNet 2 using the vm module
module vm2 '../modules/vm.bicep' = {
  name: 'vm2Deploy'
  dependsOn: [
    vnet2
  ]
  params: {
    vmName: 'vm2'
    location: location
    subnetId: '${vnet2.outputs.vnetId}/subnets/infra'
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}

// Deploy Storage Account 1 using the storage module
module storage1 '../modules/storage.bicep' = {
  name: 'storage1Deploy'
  params: {
    storageAccountName: 'stg1${uniqueString(resourceGroup().id)}'
    location: location
  }
}

// Deploy Storage Account 2 using the storage module
module storage2 '../modules/storage.bicep' = {
  name: 'storage2Deploy'
  params: {
    storageAccountName: 'stg2${uniqueString(resourceGroup().id)}'
    location: location
  }
}
