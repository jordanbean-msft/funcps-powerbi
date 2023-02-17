param($context)

$workspaceNames = @('Power BI Workspace 1')#, 'Power BI Workspace 2', 'Power BI Workspace 3')

$parallelTasks = foreach ($workspaceName in $workspaceNames) {
  Invoke-DurableActivity -FunctionName 'PowerBiWorkspaceActivity' `
    -Input $workspaceName `
    -NoWait
}

Write-Information "PowerBiWorkspaceOrchestrator: Waiting for parallel tasks to complete..."

Wait-ActivityFunction -Task $parallelTasks

Write-Information "PowerBiWorkspaceOrchestrator: Parallel tasks complete"
