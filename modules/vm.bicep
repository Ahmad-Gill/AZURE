param vm1Name string
param vm2Name string
param vnet1Id string
param vnet2Id string
param location string
param adminUsername string
@secure() param adminPassword securestring

resource vm1 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vm1Name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        name: '${vm1Name}-osDisk'
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
          id: '${vnet1Id}/networkInterfaces/${vm1Name}-nic'
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
      vmSize: 'Standard_DS1_v2'
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        name: '${vm2Name}-osDisk'
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
          id: '${vnet2Id}/networkInterfaces/${vm2Name}-nic'
        }
      ]
    }
  }
}

output vm1Id string = vm1.id
output vm2Id string = vm2.id
