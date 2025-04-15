param location string
param storageAccount1Id string

resource monitor 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'monitorSetting'
  properties: {
    logs: []
    metrics: []
    storageAccountId: storageAccount1Id
    eventHubAuthorizationRuleId: ''
  }
}

output monitorId string = monitor.id
