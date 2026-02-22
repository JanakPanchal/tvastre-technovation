FROM httpd:2.4-alpine

# Enable common modules used by .htaccess rules in this project
RUN sed -i 's/^#LoadModule rewrite_module/LoadModule rewrite_module/' /usr/local/apache2/conf/httpd.conf \
    && sed -i 's/^#LoadModule deflate_module/LoadModule deflate_module/' /usr/local/apache2/conf/httpd.conf \
    && sed -i 's/^#LoadModule expires_module/LoadModule expires_module/' /usr/local/apache2/conf/httpd.conf \
    && sed -i 's/^#LoadModule headers_module/LoadModule headers_module/' /usr/local/apache2/conf/httpd.conf

# Allow .htaccess overrides and use index.html as default
RUN printf '\n<Directory "/usr/local/apache2/htdocs">\n    AllowOverride All\n    Require all granted\n</Directory>\nDirectoryIndex index.html\n' >> /usr/local/apache2/conf/httpd.conf

COPY . /usr/local/apache2/htdocs/

EXPOSE 80
