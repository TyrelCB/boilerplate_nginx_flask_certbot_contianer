# Use an official Python runtime as a parent image
FROM python

# Install dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    certbot \
    python3-certbot-nginx \
    && apt-get clean

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Flask
RUN pip install --no-cache-dir -r requirements.txt

# Copy Nginx configuration file
COPY nginx.conf /etc/nginx/sites-available/default

# Expose port 80 and 443
EXPOSE 80 443

# Command to run the Flask application and Nginx
CMD service nginx start && certbot --nginx --non-interactive --agree-tos --email youremail@domain.com -d yourdomain.com && python app.py
