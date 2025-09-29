# Use lightweight Python image
FROM python:3.9-alpine

# Set working directory
WORKDIR /app

# Copy application files
COPY index.html .
COPY style.css .
COPY script.js .

# Expose port 8000
EXPOSE 8000

# Start Python's built-in HTTP server (NO pip install needed)
CMD ["python", "-m", "http.server", "8000"]