FROM n8nio/n8n

# Switch to root user to install packages
USER root

# Install Chromium and dependencies for Puppeteer (Use apk for Alpine)
RUN apk add --no-cache \
  chromium \
  nss \
  freetype \
  harfbuzz \
  libx11 \
  libxcomposite \
  libxcursor \
  libxdamage \
  libxrandr \
  libgbm \
  libpango \
  libasound2 \
  atk \
  gtk+3.0

# Switch back to node user for security
USER node

# Install Puppeteer
RUN npm install -g puppeteer@latest

# Set environment variables for Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Expose the correct port
ENV N8N_PORT=5678
EXPOSE 5678

# Start n8n
CMD ["n8n", "start"]
