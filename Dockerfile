FROM n8nio/n8n

# Install Chromium and dependencies for Puppeteer
RUN apt-get update && apt-get install -y \
  chromium-browser \
  libx11-xcb1 libxcb-dri3-0 \
  libxcomposite1 libxcursor1 libxdamage1 \
  libxrandr2 libgbm1 libpango-1.0-0 \
  libasound2 libatk1.0-0 libgtk-3-0 \
  && rm -rf /var/lib/apt/lists/*

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
