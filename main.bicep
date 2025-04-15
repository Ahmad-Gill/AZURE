param location string = resourceGroup().location

// VNet 1 parameters
param vnet1Name string = 'vnet-example-1'
param vnet1AddressPrefix string = '10.0.0.0/16'
param vnet1InfraPrefix string = '10.0.1.0/24'
param vnet1StoragePrefix string = '10.0.2.0/24'

// VNet 2 parameters
param vnet2Name string = 'vnet-example-2'
param vnet2AddressPrefix string = '10.1.0.0/16'
param vnet2InfraPrefix string = '10.1.1.0/24'
param vnet2StoragePrefix string = '10.1.2.0/24'

// VM parameters
param vm1Name string = 'vm-example-1'
param vm2Name string = 'vm-example-2'
param adminUsername string = 'azureuser'
@secure()
param adminPassword string

// Storage Account parameters
param storage1Name string = 'storage1example'
param storage2Name string = 'storage2example'

// Deploy VNet 1
module vnet1Module 'modules/vnet.bicep' = {
  name: 'vnet1Deploy'
  params: {
    vnetName: vnet1Name
    addressPrefix: vnet1AddressPrefix
    infraSubnetPrefix: vnet1InfraPrefix
    storageSubnetPrefix: vnet1StoragePrefix
  }
}

// Deploy VNet 2
module vnet2Module 'modules/vnet.bicep' = {
  name: 'vnet2Deploy'
  params: {
    vnetName: vnet2Name
    addressPrefix: vnet2AddressPrefix
    infraSubnetPrefix: vnet2InfraPrefix
    storageSubnetPrefix: vnet2StoragePrefix
  }
}

// Peer the VNets
module peerModule 'modules/peerVnets.bicep' = {
  name: 'peerVnets'
  dependsOn: [ vnet1Module, vnet2Module ]
  params: {
    vnet1Name: vnet1Name
    vnet2Name: vnet2Name
  }
}

// Deploy VM in VNet 1
module vm1Module 'modules/vm.bicep' = {
  name: 'vm1Deploy'
  dependsOn: [ vnet1Module ]
  params: {
    vmName: vm1Name
    location: location
    subnetId: vnet1Module.outputs.infraSubnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}

// Deploy VM in VNet 2
module vm2Module 'modules/vm.bicep' = {
  name: 'vm2Deploy'
  dependsOn: [ vnet2Module ]
  params: {
    vmName: vm2Name
    location: location
    subnetId: vnet2Module.outputs.infraSubnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}

// Deploy Storage Account 1
module storage1Module 'modules/storage.bicep' = {
  name: 'storage1Deploy'
  dependsOn: [ vnet1Module ]
  params: {
    storageAccountName: storage1Name
    location: location
    storageAccountSku: 'Standard_ZRS'
    storageSubnetId: vnet1Module.outputs.storageSubnetId
  }
}

// Deploy Storage Account 2
module storage2Module 'modules/storage.bicep' = {
  name: 'storage2Deploy'
  dependsOn: [ vnet2Module ]
  params: {
    storageAccountName: storage2Name
    location: location
    storageAccountSku: 'Standard_ZRS'
    storageSubnetId: vnet2Module.outputs.storageSubnetId
  }
}
