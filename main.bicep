param location string = resourceGroup().location
param vnet1Name string
param vnet2Name string
param vm1Name string
param vm2Name string
param storageAccount1Name string
param storageAccount2Name string
param adminUsername string
@secure() param adminPassword securestring

module vnetModule './modules/vnet.bicep' = {
  name: 'vnetDeployment'
  params: {
    vnet1Name: vnet1Name
    vnet2Name: vnet2Name
    location: location
  }
}

module vmModule './modules/vm.bicep' = {
  name: 'vmDeployment'
  params: {
    vm1Name: vm1Name
    vm2Name: vm2Name
    vnet1Id: vnetModule.outputs.vnet1Id
    vnet2Id: vnetModule.outputs.vnet2Id
    location: location
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}

module storageModule './modules/storage.bicep' = {
  name: 'storageDeployment'
  params: {
    storageAccount1Name: storageAccount1Name
    storageAccount2Name: storageAccount2Name
    vnet1Id: vnetModule.outputs.vnet1Id
    vnet2Id: vnetModule.outputs.vnet2Id
    location: location
  }
}

module monitorModule './modules/monitor.bicep' = {
  name: 'monitorDeployment'
  params: {
    location: location
    storageAccount1Id: storageModule.outputs.storageAccount1Id
  }
}
