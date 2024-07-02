# Use the official Windows Server Core image as the base
FROM mcr.microsoft.com/windows/servercore:ltsc2019

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
RUN node --version
RUN npm --version

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

# Build the React app
RUN npm run build

# RUN npm install -g serve
# RUN serve -s build

# Copy build output from the build environment
# COPY /app/build ./build

# Install IIS (Internet Information Services)
# Install IIS
RUN powershell -NoProfile -Command \
    Install-WindowsFeature -name Web-Server; \
    Install-WindowsFeature -name Web-WebServer; \
    Install-WindowsFeature -name Web-Common-Http; \
    Install-WindowsFeature -name Web-Static-Content; \
    Install-WindowsFeature -name Web-Default-Doc; \
    Install-WindowsFeature -name Web-Dir-Browsing; \
    Install-WindowsFeature -name Web-Http-Errors; \
    Install-WindowsFeature -name Web-App-Dev; \
    Install-WindowsFeature -name Web-Asp-Net45; \
    Install-WindowsFeature -name Web-Net-Ext45; \
    Install-WindowsFeature -name Web-ISAPI-Ext; \
    Install-WindowsFeature -name Web-ISAPI-Filter; \
    Install-WindowsFeature -name Web-Includes; \
    Install-WindowsFeature -name Web-WebSockets; \
    Install-WindowsFeature -name Web-Filtering; \
    Install-WindowsFeature -name Web-Mgmt-Console

# Copy custom IIS configuration file
COPY website.conf C:/website.conf

# Copy the React app build files to the IIS wwwroot directory
COPY build/ /inetpub/wwwroot/

# Expose the default port for IIS
EXPOSE 80

# Start IIS
CMD ["powershell", "Start-Service", "w3svc", ";", "ping", "-t", "localhost"]

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