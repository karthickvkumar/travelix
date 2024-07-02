#  .\zap.bat -quickurl https://www.reqres.com/ -quickprogress -cmd -quickout C:\zap\reports\report.html

# Start ZAP in daemon mode
Start-Process -FilePath "C:\ZAP\ZAP.exe" -ArgumentList "-daemon -port 4000 -host 0.0.0.0 -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true -config api.disablekey=true" -NoNewWindow

# Wait for ZAP to initialize
Start-Sleep -Seconds 10

# Run the spider scan
Invoke-WebRequest -Uri "http://localhost:4000/JSON/spider/action/scan/?url=http://web:3000&apikey="

# Wait for the spider to complete
do {
    $status = Invoke-WebRequest -Uri "http://localhost:4000/JSON/spider/view/status/?apikey=" | ConvertFrom-Json
    Start-Sleep -Seconds 5
} while ($status.status -ne "100")

# Run the active scan
Invoke-WebRequest -Uri "http://localhost:4000/JSON/ascan/action/scan/?url=http://web:3000&apikey="

# Wait for the active scan to complete
do {
    $status = Invoke-WebRequest -Uri "http://localhost:4000/JSON/ascan/view/status/?apikey=" | ConvertFrom-Json
    Start-Sleep -Seconds 5
} while ($status.status -ne "100")

# Retrieve the report
Invoke-WebRequest -Uri "http://localhost:4000/OTHER/core/other/htmlreport/?apikey=" -OutFile "C:\ZAP\report.html"

Write-Host "Scan completed. Report saved to C:\ZAP\report.html"
