# entrypoint.ps1

# Start ZAP in command line mode
# Start-Process -FilePath "cmd.exe" -ArgumentList "/K", "ZAP.bat", "-cmd", "-port", "8082", "-host", "0.0.0.0", "-config", "api.disablekey=true", "-quickurl", "http://localhost:3000/", "-quickprogress", "-quickout", "C:\zap\reports\report.html" -Wait

# docker run -t --name zap-container  -p 3000:8080 -p 8082:8080 -v C:\Users\Karthick\Documents\Concord\Learning\travelix\docker\tool:C:\zap\reports zap

# Start the React application
# Start-Service w3svc; ping -t localhost

# Start-Process -NoNewWindow -FilePath "cmd.exe" -ArgumentList "/C", "npm start"

# Wait for OWASP ZAP to start up
Start-Sleep -Seconds 10

# Start OWASP ZAP in the background
Start-Process -NoNewWindow -FilePath "cmd.exe" -ArgumentList "/C", "C:\zap\ZAP_2.15.0\ZAP.bat", "-cmd", "-port", "8082", "-host", "0.0.0.0", "-config", "api.disablekey=true", "-quickurl", "http://localhost:3000/", "-quickprogress", "-quickout", "C:\zap\reports\report.html" -Wait

# Wait indefinitely to keep the script running
Start-Sleep -Seconds 999999