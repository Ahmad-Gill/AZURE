param location string = resourceGroup().location
@secure()
param Password string

module workspace '../modules/workspace.bicep' = {
  name: 'deployWorkspace'
  params: {
    name: 'loganalytics-ws'
    location: location
  }
}
module monitor '../modules/monitor.bicep' = {
  name: 'enableMonitor'
  params: {
    workspaceId: workspace.outputs.id
  }
}


module vnet1 '../modules/vnet.bicep' = {
  name: 'vnet1Deploy'
  params: {
    name: 'vnet1'
    location: location
    addressPrefix: '10.0.0.0/16'
  }
}

module vnet2 '../modules/vnet.bicep' = {
  name: 'vnet2Deploy'
  params: {
    name: 'vnet2'
    location: location
    addressPrefix: '10.1.0.0/16'
  }
}

module peering '../modules/peering.bicep' = {
  name: 'vnetPeering'
  params: {
    vnet1: vnet1.outputs.vnet
    vnet2: vnet2.outputs.vnet
  }
}

module vm1 '../modules/vm.bicep' = {
  name: 'vm1Deploy'
  params: {
    name: 'vm1'
    location: location
    subnetId: vnet1.outputs.infraSubnetId
    user:'azureuser'
    pas_:Password

  }
}

module vm2 '../modules/vm.bicep' = {
  name: 'vm2Deploy'
  params: {
    name: 'vm2'
    location: location
    subnetId: vnet2.outputs.infraSubnetId
    user:'azureuser'
    pas_:Password
  }
}

module storage1 '../modules/storage.bicep' = {
  name: 'storage1mahmadgill01gmailcom'
  params: {
    name: 'storacc1'
    location: location
    subnetId: vnet1.outputs.storageSubnetId
  }
}

module storage2 '../modules/storage.bicep' = {
  name: 'storage2mahmadgill01gmailcom'
  params: {
    name: 'storacc2'
    location: location
    subnetId: vnet2.outputs.storageSubnetId
  }
}














