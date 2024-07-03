# Use the official Windows Server Core image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Use the official .NET Framework 4.8 image
FROM mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2019

# Set environment variables for ZAP
ENV ZAP_DIR="C:\\Program Files\\ZAP\\Zed Attack Proxy"

# Download and install Chocolatey
RUN powershell -NoProfile -Command " \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

# Verify Chocolatey installation
RUN choco --version

# Install OpenJDK 11 using Chocolatey and capture logs
RUN powershell -NoProfile -Command " \
    Start-Process -FilePath choco -ArgumentList 'install openjdk11 -y' -Wait -NoNewWindow -PassThru | Tee-Object -FilePath C:\choco_install_log.txt; \
    if (-not $?) { cat C:\choco_install_log.txt; exit 1 }"

# Verify the installation
RUN powershell -NoProfile -Command " \
    $env:PATH += ';C:\Program Files\OpenJDK\openjdk-11.0.2\bin'; \
    java -version"

# Create the directory for the script if it doesn't exist
RUN powershell -Command "if (-Not (Test-Path -Path 'C:\\zap')) { New-Item -Path 'C:\\zap' -ItemType Directory }"

# Download and install ZAP
RUN curl -L -o v2.15.0.zip https://github.com/zaproxy/zaproxy/releases/download/v2.15.0/ZAP_2.15.0_Core.zip && \
powershell -Command "Expand-Archive -Path v2.15.0.zip -DestinationPath C:\ZAP" && \
del v2.15.0.zip


WORKDIR C:\\zap\\ZAP_2.15.0

# Expose ZAP port
EXPOSE 8080
COPY zap.ps1 ./

# Expose the port your app runs on
EXPOSE 8082

# Start ZAP using the startup script
CMD ["powershell.exe", "-File", "zap.ps1"]

# Start ZAP in interactive mode
# CMD ["CMD", "/K", "ZAP.bat",  "-cmd", "-port", "8082", "-host", "0.0.0.0", "-config", "api.disablekey=true", "-quickurl", "http://localhost:3000/", "-quickprogress", "-quickout", "C:\\zap\\reports\\report.html"]

# CMD ["CMD", "/C", "timeout /t 30 && ZAP.bat -cmd -port 8082 -host 0.0.0.0 -config api.disablekey=true -quickurl http://localhost:3000/ -quickprogress -quickout C:\\zap\\reports\\report.html"]

