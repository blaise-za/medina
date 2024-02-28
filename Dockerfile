FROM ruby:3.2.0

RUN apt update && apt upgrade -y
RUN gem install mailcatcher
RUN apt install -y git autoconf automake libtool gettext texinfo pkg-config sharutils
RUN git clone https://git.marlam.de/git/msmtp.git
WORKDIR /msmtp
RUN autoreconf -i
RUN ./configure; make; make install
RUN apt install -y python3-pip
RUN pip install -U Jinja2
WORKDIR /

EXPOSE 1080 1025

ENTRYPOINT [ "/bin/bash" ]