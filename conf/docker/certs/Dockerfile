FROM python:slim-bullseye

# Install tools
RUN apt update
RUN apt install -y \
  openssh-client \
  openssl \
  curl

# Install libraries
RUN pip install pyjwt pyjwt[crypto]

# Setting Container
