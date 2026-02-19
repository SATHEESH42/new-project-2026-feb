# Use lightweight nginx alpine image
FROM nginx:alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy our nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy website files to nginx folder
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]


# Apache httpd alpine image
FROM httpd:alpine

# Remove default website
RUN rm -rf /usr/local/apache2/htdocs/*

# Copy apache config
COPY httpd.conf /usr/local/apache2/conf/httpd.conf

# Copy website files
COPY . /usr/local/apache2/htdocs/

EXPOSE 80

CMD ["httpd-foreground"]
  