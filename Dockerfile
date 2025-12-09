FROM php:7.4-apache

RUN apt-get update -y && docker-php-ext-install mysqli
RUN a2enmod rewrite

COPY cafe/ /var/www/html/   # <-- UPDATE THIS FOLDER NAME

RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

RUN echo "DirectoryIndex index.php index.html" >> /etc/apache2/apache2.conf

EXPOSE 80
CMD ["apache2-foreground"]
