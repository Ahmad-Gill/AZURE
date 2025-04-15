param vm1Name string
param vm2Name string
param vnet1Id string
param vnet2Id string
param location string
param adminPassword string
param adminUsername string

resource vm1 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vm1Name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: 'osdisk1'
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: vm1Name
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: '${vnet1Id}/subnets/infra'
        }
      ]
    }
  }
}

resource vm2 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vm2Name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: 'osdisk2'
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: vm2Name
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: '${vnet2Id}/subnets/infra'
        }
      ]
    }
  }
}

output vm1Id string = vm1.id
output vm2Id string = vm2.id
