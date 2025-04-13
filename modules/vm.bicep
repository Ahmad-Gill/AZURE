

//  their values are passed from the main Bicep file when  deploy the module.
param name string
param location string
param subnetId string
param user string
@secure()
param pas_ string








// used for commution with that vm
resource nic 'Microsoft.Network/networkInterfaces@2021-05-01' = {     //  API version 2021-05-01
  name: '${name}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetId         // only for a specific subnet 
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
} 


// Actual code of creating VM

resource vm 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    storageProfile: {      // used buitin images
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-smalldisk'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: name
      adminUsername: user
      adminPassword: pas_
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}
