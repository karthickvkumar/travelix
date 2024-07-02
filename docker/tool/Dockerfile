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

# Print the current working directory and list files
# RUN powershell -Command "\
#     Write-Output 'Current Directory:'; \
#     Get-Location; \
#     Write-Output 'Files in Current Directory:'; \
#     Get-ChildItem -Path C:\\ZAP"

WORKDIR C:\\zap\\ZAP_2.15.0

# Set the working directory
# WORKDIR $ZAP_DIR

# Expose ZAP port
EXPOSE 8080

# Start ZAP in interactive mode
CMD ["CMD", "/K", "ZAP.bat",  "-cmd", "-port", "8082", "-host", "0.0.0.0", "-config", "api.disablekey=true", "-quickurl", "https://reqres.in/", "-quickprogress", "-quickout", "C:\\zap\\reports\\report.html"]
# ENTRYPOINT ["cmd", "/S", "/C", "zap.bat", "-quickurl", "https://reqres.in/", "-quickprogress", "-cmd", "-quickout", "C:\\ZAP\\report.html"]