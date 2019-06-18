FROM centos
LABEL maintainer="Me"

RUN yum clean all && \
    yum -y update && \
    yum -y install httpd php && \
    ln -sf /dev/stdout /var/log/httpd/access_log  && \
    ln -sf /dev/stderr /var/log/httpd/error_log && \
    chmod -R g+w /var/www/html && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    rm -f /etc/httpd/conf.d/{userdir.conf,welcome.conf}

RUN echo '<?php echo phpinfo(); ?>' > /var/www/html/index.php


HEALTHCHECK CMD curl --fail http://localhost:80/ || exit 1

EXPOSE 80
ENV HOME /var/www/html

CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
