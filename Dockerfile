FROM php:7.4-apache

# Install MySQL extension
RUN apt-get update -y && docker-php-ext-install mysqli

# Enable Apache rewrite
RUN a2enmod rewrite

# Copy application files
COPY mompopcafe/ /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

# Make sure Apache serves PHP first
RUN echo "DirectoryIndex index.php index.html" >> /etc/apache2/apache2.conf

EXPOSE 80

CMD ["apache2-foreground"]
