# get python alpine (official on docker hub)
FROM python:3.7-alpine
#MAINTAINER: Mitch

# recommended setting
ENV PYTHONUNBUFFERED 1

# copy requirements and install in container
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# Create app dir, switch to it and copy local into container
RUN mkdir /app
WORKDIR /app
COPY ./app /app

#switch to designated user for security  purposes (we don't want to run as root)
RUN adduser -D adduser
USER user
