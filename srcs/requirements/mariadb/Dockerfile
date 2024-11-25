FROM alpine:3.20.2

ARG DB_NAME \
    DB_USER \
    DB_PASS
#In Docker, there are two ways of passing environment variables to an image: via ARG or via ENV. Arguments that will be used only when building the image and not after it starts are passed via ARG.

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf
#The tee command sends the echo output to a file (mariadb-server.cnf)
#sed replaces the lines, -i applies changes directly to the file.
#s substitutes every occurrence of skip-networking to skip-networking=0, globally, reenabling networking, allowing the database to listen for external connections.

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

COPY requirements/mariadb/conf/create_db.sh .
RUN chmod 777 create_db.sh && sh create_db.sh
USER mysql
CMD ["/usr/bin/mysqld", "--skip-log-error"]
