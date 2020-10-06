FROM centos:centos7
LABEL Description="pdns base on centos7" Version="0.7"
RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y && \
    yum install pdns-backend-geoip -y && \
    yum install net-tools -y && \
    yum install bind-utils -y && \
    yum clean all
COPY pdns.conf /etc/pdns/pdns.conf
COPY endpoint.sh /usr/sbin/endpoint.sh
COPY checkall.sh /usr/sbin/checkall.sh
WORKDIR /etc/pdns/
ENTRYPOINT ["/usr/sbin/endpoint.sh"]
EXPOSE 53/UDP
EXPOSE 53/TCP
