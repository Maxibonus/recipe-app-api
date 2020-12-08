# get python alpine (official on docker hub)
FROM python:3.7-alpine
#MAINTAINER: Mitch

# recommended setting
ENV PYTHONUNBUFFERED 1

# copy requirements and install in container
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Create app dir, switch to it and copy local into container
RUN mkdir /app
WORKDIR /app
COPY ./app /app

#switch to designated user for security  purposes (we don't want to run as root)
RUN adduser -D adduser
USER user
