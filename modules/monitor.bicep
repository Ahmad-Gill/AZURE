// Parameters
param workspaceId string  // i have no account so i have no id 

// Diagnostic settings resource
resource diagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'default'
  scope: resourceGroup()  // make it in resourcegroup  apply to all teh resources under taht group
  properties: {
    workspaceId: workspaceId // This workspace stores the diagnostic logs
    logs: [
      {
        category: 'Administrative'
        enabled: true
        retentionPolicy: {   //logs aren't deleted after a set period
          enabled: false
          days: 0
        }
      }
    ]
  }
}
