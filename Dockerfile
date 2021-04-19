FROM httpd:2.4-alpine
MAINTAINER john "john@123.com"
ENV REFRESHED_AT=2021-02-01 \
APACHE_RUN_USER=www-data \
APACHE_RUN_GROUP=www-data \
APACHE_LOG_DIR=/var/log/apache2 \
APACHE_PID_FILE=/var/run/apache2.pid \
APACHE_RUN_DIR=/var/run/apache2 \
APACHE_LOCK_DIR=/var/lock/apache2

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR \ 
&& sed -i \
        -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
        -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
        -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
        conf/httpd.conf \
&& echo "Include /blog/blog.conf" >> /usr/local/apache2/conf/httpd.conf \
&& apk update
VOLUME ["/blog", "$APACHE_LOG_DIR"]
#ENTRYPOINT ["/usr/sbin/httpd"]
#CMD ["-D", "FOREGROUND"]
EXPOSE 80 443
