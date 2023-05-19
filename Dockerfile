FROM ubuntu:latest

# Stop all interactive prompts and set defaults
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=EU

# install dependencies
RUN apt update && \
    apt install -y nginx mysql-server php-fpm php-mysql

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/sites-available/default

# Install WordPress
RUN mkdir /var/www/html/wordpress
ADD https://wordpress.org/latest.tar.gz /var/www/html/wordpress/
RUN tar -xzvf /var/www/html/wordpress/latest.tar.gz -C /var/www/html/wordpress --strip-components=1

# Set permissions
RUN chown -R www-data:www-data /var/www/html/wordpress
RUN chmod -R 755 /var/www/html/wordpress

# Expose ports
EXPOSE 80

# Start services
CMD service mysql start && service php8.1-fpm start && nginx -g "daemon off;"
