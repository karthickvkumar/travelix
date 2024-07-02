# docker run -t --name zap-container -p 8082:8080 -v C:\Users\Karthick\Documents\Concord\Learning\travelix\docker\tool:C:\zap\reports zaptool 
 
 Write-Host "File Loaded into Docker Machine"

Copy-Item -Path 'C:\zap\reports\report.html' -Destination 'C:\Users\Karthick\Documents\Concord\Learning\travelix\docker\tool'

 Write-Host "File Copied to Host Machine"


# # Start the spider scan
# $scanResponse = Invoke-WebRequest -Uri "http://localhost:8082/JSON/spider/action/scan/?url=https://reqres.in" -UseBasicParsing
# $scanId = ($scanResponse.Content | ConvertFrom-Json).scan

# Write-Host "Spider Scan ID $scanId"

# # Check the spider status
# do {
#     $statusResponse = Invoke-WebRequest -Uri "http://localhost:8082/JSON/spider/view/status/?scanId=$scanId" -UseBasicParsing
#     $status = ($statusResponse.Content | ConvertFrom-Json).status
#     Write-Host "Spider status: $status"
#     Start-Sleep -Seconds 5
# } while ($status -ne "100")

# # Run the active scan
# Invoke-WebRequest -Uri "http://localhost:8082/JSON/ascan/action/scan/?scanId=$scanId?url=https://reqres.in" -UseBasicParsing

# # Wait for the active scan to complete
# do {
#     $statusResponse = Invoke-WebRequest -Uri "http://localhost:8082/JSON/ascan/view/status/?scanId=$scanId" -UseBasicParsing 
#     $status = ($statusResponse.Content | ConvertFrom-Json).status
#     Write-Host "Active Scan status: $status"
#     Start-Sleep -Seconds 5
# } while ($status.status -ne "100")

# # Generate the report
# Invoke-WebRequest -Uri "http://localhost:8082/OTHER/core/other/htmlreport/?scanId=$scanId" -OutFile "C:\zap\reports\report.html"

# Write-Host "Scan completed. Report saved to C:\zap\reports\report.html"



# # Wait for ZAP to initialize
# Start-Sleep -Seconds 5

# # Run the spider scan
# $scanResponse = Invoke-WebRequest -Uri "http://localhost:8082/JSON/spider/action/scan/?url=https://reqres.in" -UseBasicParsing
# $scanId = ($scanResponse.Content | ConvertFrom-Json).scan

# Write-Host "Spider Scan ID $scanId"
# # Invoke-WebRequest -Uri "http://localhost:8082/JSON/spider/action/scan/?url=https://reqres.in" -UseBasicParsing

# # Wait for the spider to complete
# # do {
# #     $statusResponse = Invoke-WebRequest -Uri "http://localhost:8082/JSON/spider/view/status/?scanId=$scanId" -UseBasicParsing
# #     $status = ($statusResponse.Content | ConvertFrom-Json).status
# #     Start-Sleep -Seconds 5
# # } while ($status -ne "100")

# do {
#     $status = Invoke-WebRequest -Uri "http://localhost:8082/JSON/spider/view/status/?scanId=$scanId" -UseBasicParsing | ConvertFrom-Json
#     Start-Sleep -Seconds 5
# } while ($status.status -ne "100")

# # # Run the active scan
# # Invoke-WebRequest -Uri "http://localhost:8082/JSON/ascan/action/scan/?url=https://reqres.in" -UseBasicParsing

# # # Wait for the active scan to complete
# # do {
# #     $status = Invoke-WebRequest -Uri "http://localhost:8082/JSON/ascan/view/status" -UseBasicParsing | ConvertFrom-Json
# #     Start-Sleep -Seconds 5
# # } while ($status.status -ne "100")

# # Retrieve the report
# Invoke-WebRequest -Uri "http://localhost:8082/OTHER/core/other/htmlreport/?scanId=$scanId" -OutFile "C:\zap\reports\report.html"

# Write-Host "Scan completed. Report saved to C:\zap\reports\report.html"




# docker build -t zaptool .

# docker run --name zap-container -p 8082:8080 -v C:\Users\Karthick\Documents\Concord\Learning\travelix\docker\tool:C:\zap\reports zaptool


# # Copy the PowerShell script into the running container
# docker cp C:\Users\Karthick\Documents\Concord\Learning\travelix\docker\tool\powershell.ps1 zap-container:C:\zap\reports\powershell.ps1

# # Execute the PowerShell script inside the container
# docker exec -it zap-container powershell -File C:\zap\reports\powershell.ps1

# docker cp 50a772e4c8d7:C:\ZAP\report.html .

# docker cp zap-container: C:\zap\reports\report.html  C:\zap\reports\report.html

# # Define necessary variables
# $zapAddress = "http://localhost:8082"
# $apiKey = "<your-zap-api-key>"
# $contextName = "example-context"
# $loginUrl = "http://example.com/login"
# $loginRequestData = "username={%username%}&password={%password%}"
# $username = "user"
# $password = "pass"

# # Create a context
# $contextId = Invoke-RestMethod -Method Post -Uri "$zapAddress/JSON/context/action/newContext/?apikey=$apiKey&contextName=$contextName" | Select-Object -ExpandProperty contextId

# # Set the login URL
# Invoke-RestMethod -Method Post -Uri "$zapAddress/JSON/authentication/action/setAuthenticationMethod/?apikey=$apiKey&contextId=$contextId&authMethodName=formBasedAuthentication&authMethodConfigParams=loginUrl=$loginUrl&loginRequestData=$loginRequestData"

# # Create a new user
# $userId = Invoke-RestMethod -Method Post -Uri "$zapAddress/JSON/users/action/newUser/?apikey=$apiKey&contextId=$contextId&name=$username" | Select-Object -ExpandProperty userId

# # Set user credentials
# Invoke-RestMethod -Method Post -Uri "$zapAddress/JSON/users/action/setAuthenticationCredentials/?apikey=$apiKey&contextId=$contextId&userId=$userId&authCredentialsConfigParams=username=$username&password=$password"

# # Enable the user
# Invoke-RestMethod -Method Post -Uri "$zapAddress/JSON/users/action/setUserEnabled/?apikey=$apiKey&contextId=$contextId&userId=$userId&enabled=true"

# # Start the spider
# Invoke-RestMethod -Method Post -Uri "$zapAddress/JSON/spider/action/scan/?apikey=$apiKey&contextName=$contextName&url=http://example.com"

# # Start the active scan
# Invoke-RestMethod -Method Post -Uri "$zapAddress/JSON/ascan/action/scan/?apikey=$apiKey&contextId=$contextId&url=http://example.com"

# # Export the report
# Invoke-RestMethod -Method Get -Uri "$zapAddress/OTHER/core/other/htmlreport/?apikey=$apiKey" -OutFile "C:\zap\reports\report.html"

