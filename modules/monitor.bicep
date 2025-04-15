param location string

resource monitor 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'monitorSetting'
  location: location
  properties: {
    logs: []
    metrics: []
    storageAccount: {
      id: storageAccount1Id
    }
    eventHub: {
      eventHubAuthorizationRuleId: ''
    }
  }
}

output monitorId string = monitor.id
