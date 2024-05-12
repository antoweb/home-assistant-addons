# VERSION:		  0.1
# DESCRIPTION:  Run AWS CLI in a container
# AUTHOR:		    Denis Carriere <carriere.denis@gmail.com>
# COMMENTS:
#	This file describes how to build AWS CLI in a container with all
#	dependencies installed.
#	Tested on Ubuntu Willy
# USAGE:
#	# Download AWS CLI Dockerfile
#	wget https://raw.githubusercontent.com/DenisCarriere/awscli/master/Dockerfile
#
#	# Build AWS CLI image
#	docker build -t awscli .
#
#	docker run -it awscli --version
#

# Base docker image
ARG BUILD_FROM
FROM ${BUILD_FROM}

ENV LANG C.UTF-8

COPY rootfs /

# add aws-cli and deps
RUN apk add -v --update --no-cache \
        python3 \
        py3-pip \
        groff \
        less \
        jq \
        && \
    pip3 install --upgrade awscli

COPY run.sh /run.sh

RUN chmod 755 /run.sh

CMD ["/run.sh"]