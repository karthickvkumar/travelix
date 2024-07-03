# Use the official Windows Server Core image as the base
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Use the official .NET Framework 4.8 image
# FROM mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2019

# # Download and install Chocolatey
# RUN powershell -NoProfile -Command " \
#     [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
#     iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

# # Verify Chocolatey installation
# RUN choco --version

# # Install OpenJDK 11 using Chocolatey and capture logs
# RUN powershell -NoProfile -Command " \
#     Start-Process -FilePath choco -ArgumentList 'install openjdk11 -y' -Wait -NoNewWindow -PassThru | Tee-Object -FilePath C:\choco_install_log.txt; \
#     if (-not $?) { cat C:\choco_install_log.txt; exit 1 }"

# # Verify the installation
# RUN powershell -NoProfile -Command " \
#     $env:PATH += ';C:\Program Files\OpenJDK\openjdk-11.0.2\bin'; \
#     java -version"

# # Create the directory for the script if it doesn't exist
# RUN powershell -Command "if (-Not (Test-Path -Path 'C:\\zap')) { New-Item -Path 'C:\\zap' -ItemType Directory }"

# # Download and install ZAP
# RUN curl -L -o v2.15.0.zip https://github.com/zaproxy/zaproxy/releases/download/v2.15.0/ZAP_2.15.0_Core.zip && \
# powershell -Command "Expand-Archive -Path v2.15.0.zip -DestinationPath C:\ZAP" && \
# del v2.15.0.zip


# WORKDIR C:\\zap\\ZAP_2.15.0

# Set up environment variables for Node.js installation
ENV NODE_VERSION 16.17.0
ENV NODE_DOWNLOAD_URL https://nodejs.org/dist/v16.17.0/node-v16.17.0-x64.msi

# Download and install Node.js
RUN powershell -Command \
    $ErrorActionPreference = 'Stop'; \
    Invoke-WebRequest -Uri $env:NODE_DOWNLOAD_URL -OutFile nodejs.msi; \
    Start-Process msiexec.exe -ArgumentList '/i', 'nodejs.msi', '/quiet', '/norestart' -NoNewWindow -Wait; \
    Remove-Item -Force nodejs.msi

#Check Node Version   
# RUN node --version
# RUN npm --version

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Update caniuse-lite database
RUN npx update-browserslist-db@latest

# Copy the rest of the application code
COPY . .

EXPOSE 3000

CMD ["cmd", "/c", "npm start"]
# RUN npm start
# Build the React app
# RUN npm run build

# RUN npm install -g serve
# RUN serve -s build

# Copy build output from the build environment
# COPY /app/build ./build

# Install IIS (Internet Information Services)
# Install IIS
# RUN powershell -NoProfile -Command \
#     Install-WindowsFeature -name Web-Server; \
#     Install-WindowsFeature -name Web-WebServer; \
#     Install-WindowsFeature -name Web-Common-Http; \
#     Install-WindowsFeature -name Web-Static-Content; \
#     Install-WindowsFeature -name Web-Default-Doc; \
#     Install-WindowsFeature -name Web-Dir-Browsing; \
#     Install-WindowsFeature -name Web-Http-Errors; \
#     Install-WindowsFeature -name Web-App-Dev; \
#     Install-WindowsFeature -name Web-Asp-Net45; \
#     Install-WindowsFeature -name Web-Net-Ext45; \
#     Install-WindowsFeature -name Web-ISAPI-Ext; \
#     Install-WindowsFeature -name Web-ISAPI-Filter; \
#     Install-WindowsFeature -name Web-Includes; \
#     Install-WindowsFeature -name Web-WebSockets; \
#     Install-WindowsFeature -name Web-Filtering; \
#     Install-WindowsFeature -name Web-Mgmt-Console

# # Copy custom IIS configuration file
# COPY website.conf C:/website.conf

# # Copy the React app build files to the IIS wwwroot directory
# COPY build/ /inetpub/wwwroot/

# Expose the default port for IIS
# EXPOSE 80

# Expose ports for React App (3000) and OWASP ZAP (8082)
# EXPOSE 3000
# EXPOSE 8080
# EXPOSE 8082

# Copy entrypoint script into container
# COPY entrypoint.ps1 .

# Start IIS
# CMD ["powershell", "Start-Service", "w3svc", ";", "ping", "-t", "localhost"]

# Set entrypoint to PowerShell and run the script
# ENTRYPOINT ["powershell", "-File", "entrypoint.ps1"]

# ===========================================
# Stage 1: Build the React app
# FROM node:16 as build

# WORKDIR /app

# COPY package.json ./
# COPY package-lock.json ./
# RUN npm install 

# COPY . ./
# RUN npm run build

# # Stage 2: Serve the React app
# FROM nginx:alpine

# COPY --from=build /app/build /usr/share/nginx/html

# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]