FROM centos

LABEL Name="DevOps" \
      EmailID="devops@gmail.com" \
      Mobile="8995509660"

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-* && \
    yum update -y && \
    yum install -y httpd zip unzip wget && \
    yum clean all

# Download and unzip the template
ADD https://github.com/Gaurav1517/demo-project/archive/refs/heads/main.zip  /var/www/html

WORKDIR /var/www/html

RUN unzip  main.zip && \
    cp -rvf demo-project-main/* .
  #  rm -rf clinic-website-template klinik.zip

# Expose the HTTP port
EXPOSE 80

# Start Apache server in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
