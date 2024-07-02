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

# Set the working directory
WORKDIR /app

COPY ../../package.json ./
COPY ../..package-lock.json ./

RUN npm install 

COPY ../../ ./

# Install dependencies
RUN npm install

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]

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