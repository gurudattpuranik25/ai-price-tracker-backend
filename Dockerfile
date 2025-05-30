# Use official Python slim image
FROM python:3.12-slim

# Install Node.js and system dependencies for Playwright Chromium
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    wget \
    unzip \
    fonts-liberation \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libpangocairo-1.0-0 \
    libpango-1.0-0 \
    libgtk-3-0 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 18 (required by Playwright)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs

# Set working directory
WORKDIR /app

# Copy all project files
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Install Playwright and Chromium browsers
RUN npx playwright install --with-deps

# Expose Flask port
EXPOSE 5000

# Run Flask app
CMD ["python", "app.py"]
