# Use lightweight Python image
FROM python:3.9-alpine

# Set working directory
WORKDIR /app

# Copy application files
COPY index.html .
COPY style.css .
COPY script.js .

# Install Python HTTP server
RUN pip install --no-cache-dir http-server

# Expose port 8000
EXPOSE 8000

# Start HTTP server
CMD ["python", "-m", "http.server", "8000"]