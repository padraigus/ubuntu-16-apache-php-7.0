FROM 1and1internet/ubuntu-16-apache:latest
MAINTAINER james.wilkins@fasthosts.co.uk
ARG DEBIAN_FRONTEND=noninteractive
RUN \
  apt-get update && \
  apt-get install -y libapache2-mod-php7.0 php7.0-cli php7.0-common php7.0-curl php7.0-gd php7.0-mysql php7.0-sqlite php7.0-xml php7.0-zip php7.0-mbstring php7.0-mcrypt php7.0-intl && \
  sed -i -e 's/max_execution_time = 30/max_execution_time = 360/g' /etc/php/7.0/apache2/php.ini && \
  sed -i -e 's/upload_max_filesize = 2M/upload_max_filesize = 50M/g' /etc/php/7.0/apache2/php.ini && \
  sed -i -e 's/DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm/DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm/g' /etc/apache2/mods-available/dir.conf && \
  cd /tmp && \
  curl -sS https://getcomposer.org/installer | php && \
  mv composer.phar /usr/local/bin/composer && \
  chmod a+x /usr/local/bin/composer && \
  cd / && \
  rm -rf /tmp/composer && \
  apt-get remove -y python-software-properties software-properties-common && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/* && \
  chmod 777 -R /var/www

  # rm -rf /tmp/* && \
  # mkdir -m 777 /tmp/sockets && \
  # rm -rf /var/lib/apt/lists/* && \
  # chmod -R 755 /hooks /init
EXPOSE 8080
