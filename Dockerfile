FROM php:8.2-apache                                                                                                               
  RUN rm -f /etc/apache2/mods-enabled/mpm_event.conf \                                                                                    && rm -f /etc/apache2/mods-enabled/mpm_event.load \
      && rm -f /etc/apache2/mods-enabled/mpm_worker.conf \
      && rm -f /etc/apache2/mods-enabled/mpm_worker.load \
      && ln -sf /etc/apache2/mods-available/mpm_prefork.conf /etc/apache2/mods-enabled/mpm_prefork.conf \
      && ln -sf /etc/apache2/mods-available/mpm_prefork.load /etc/apache2/mods-enabled/mpm_prefork.load \
      && a2enmod rewrite \
      && docker-php-ext-install pdo pdo_mysql

  RUN sed -i 's|AllowOverride None|AllowOverride All|g' /etc/apache2/apache2.conf

  # Clever Cloud route le trafic vers le port 8080 du conteneur, pas le 80
  # par défaut d'Apache — on déplace l'écoute pour que son health check passe.
  RUN sed -i 's/80/8080/' /etc/apache2/ports.conf \
      && sed -i 's/:80>/:8080>/' /etc/apache2/sites-enabled/000-default.conf

  COPY . /var/www/html/

  RUN mkdir -p /var/www/html/uploads/avatars \
      && chown -R www-data:www-data /var/www/html/uploads \
      && chmod -R 775 /var/www/html/uploads

  EXPOSE 8080
  CMD ["apache2-foreground"]
