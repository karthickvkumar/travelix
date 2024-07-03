Start-Sleep -Seconds 30
.\ZAP.bat -cmd -port 8082 -host 0.0.0.0 -config api.disablekey=true -quickurl http://react:3000/ -quickprogress -quickout C:\zap\reports\report.html
