###############################################################################
# Apache HTTP Server
#
# This is used for web development for simple websites or more dynamic
# sites such as Wordpress
#
# This Dockerfile builds an HTTP server with the following:
# - PHP 5
###############################################################################

FROM debian:jessie

MAINTAINER Jeff Chong <me@jeffchong.com>

# Install Apache HTTP Server and PHP 5
RUN apt-get update && apt-get install -y apache2 php5
RUN apt-get clean

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]
