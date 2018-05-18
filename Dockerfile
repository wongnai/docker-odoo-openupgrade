FROM debian:stretch
MAINTAINER Odoo S.A. <info@odoo.com>

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG C.UTF-8

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
            node-less \
            python3-pip \
            python3-setuptools \
            python3-renderpm \
            xz-utils \
            expect-dev \
            python-lxml \
            python-simplejson \
            python-serial \
            python-yaml \
            python-passlib \
            python-psycopg2 \
            python-werkzeug \
            realpath \
            python3-dev \
            build-essential \
            python3 ruby-compass \
            fontconfig libfreetype6 libxml2 libxslt1.1 libjpeg62-turbo zlib1g \
            libfreetype6 liblcms2-2 libtiff5 tk tcl libpq5 \
            libldap-2.4-2 libsasl2-2 libx11-6 libxext6 libxrender1 \
            locales-all zlibc \
            libsasl2-dev python-dev libldap2-dev libssl-dev \
            bzip2 ca-certificates curl gettext-base git gnupg2 nano \
            openssh-client postgresql-client telnet xz-utils \
        && curl -o wkhtmltox.tar.xz -SL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
        && echo '3f923f425d345940089e44c1466f6408b9619562 wkhtmltox.tar.xz' | sha1sum -c - \
        && tar xvf wkhtmltox.tar.xz \
        && cp wkhtmltox/lib/* /usr/local/lib/ \
        && cp wkhtmltox/bin/* /usr/local/bin/ \
        && cp -r wkhtmltox/share/man/man1 /usr/local/share/man/ \
        && rm -rf /var/lib/apt/lists/
 
COPY ./requirements.txt /

RUN pip3 install -r requirements.txt
RUN pip3 install --ignore-installed git+https://github.com/OCA/openupgradelib.git@master

COPY ./odoo.conf.template /etc/odoo/

ENV ODOO_RC /etc/odoo/odoo.conf

ENTRYPOINT ["/entrypoint.sh"]
CMD ["migrate"]
