FROM python:3.9-alpine
WORKDIR /app
COPY index.html .
COPY contact.html .
COPY style.css .
COPY script.js .
EXPOSE 8000
CMD ["python", "-m", "http.server", "8000"]
