$zapUrl = "http://localhost:4000"

try {
    $response = Invoke-RestMethod -Uri "$zapUrl/JSON/core/view/version/"
    Write-Output "ZAP is running. Version: $($response.version)"
} catch {
    Write-Output "ZAP is not running or not accessible at $zapUrl."
}
