param location string
param storageAccount1Id string  // Add this parameter to receive the storage account ID

resource monitor 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'monitorSetting'
  location: location
  properties: {
    logs: []
    metrics: []
    storageAccount: {
      id: storageAccount1Id  // Use the passed storage account ID
    }
    eventHub: {
      eventHubAuthorizationRuleId: ''
    }
  }
}

output monitorId string = monitor.id  // Output the monitor ID
