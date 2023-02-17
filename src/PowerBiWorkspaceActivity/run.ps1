param($workspaceName)

Write-Information "PowerBiWorkspaceActivity: $workspaceName - Processing..."

$clientId = $env:PowerBiSpClientId
$clientSecret = $env:PowerBiSpClientSecret
$tenantId = $env:PowerBiSpTenantId

$pbiSecurePassword = ConvertTo-SecureString $clientSecret -Force -AsPlainText
$pbiCredential = New-Object Management.Automation.PSCredential($clientId, $pbiSecurePassword)

Write-Information "PowerBiWorkspaceActivity: $workspaceName - Connecting to Power BI..."

Connect-PowerBIServiceAccount -ServicePrincipal `
  -TenantId $tenantId `
  -Credential $pbiCredential `
| Out-Null

Write-Information "PowerBiWorkspaceActivity: $workspaceName - Connected to Power BI"

Write-Information "PowerBiWorkspaceActivity: $workspaceName - Getting workspace..."

Get-PowerBIWorkspace -Scope Organization `
  -Filter "tolower(name) eq '${workspaceName}'"

Write-Information "PowerBiWorkspaceActivity: $workspaceName - Got workspace"

Write-Information "PowerBiWorkspaceActivity: $workspaceName - Complete"