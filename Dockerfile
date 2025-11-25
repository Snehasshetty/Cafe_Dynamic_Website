FROM php:7.4-apache

# Fix Debian repo if needed
RUN sed -i 's|http://deb.debian.org/debian/|http://ftp.debian.org/debian/|g' /etc/apt/sources.list

# Install mysqli
RUN apt-get update -y && docker-php-ext-install mysqli

# Copy website files
COPY . /var/www/html/

# Set correct permissions for Apache
RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

# Expose port
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
