###############################################################################
# MongoDB Docker image
#
# This Dockerfile builds an image with an instance of MongoDB along with
# supports authentication via
# - An adminstrator User
# - An application User
#
# Scripts/Config credit to legacy tutum-docker-mongodb
###############################################################################

FROM mongo:3.4

MAINTAINER Jeff Chong <me@jeffchong.com>

# Set environment variables for MongoDB
ENV AUTH yes
ENV STORAGE_ENGINE wiredTiger
ENV JOURNALING yes

# enable scripts used to run and setup the mongoDB

ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh

CMD ["/run.sh"]
