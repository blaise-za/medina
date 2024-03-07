FROM dmitryrck/msmtp

RUN apt update && apt upgrade -y
# RUN gem install mailcatcher
# RUN apt install -y git autoconf automake libtool gettext texinfo pkg-config sharutils build-essential debhelper dh-apparmor debhelper-compat libgnutls28-dev libgsasl7-dev libsecret-1-dev po-debconf
# RUN git clone https://git.marlam.de/git/msmtp.git
# WORKDIR /msmtp
# RUN cp /etc/apt/sources.list /etc/apt/sources.list~
# RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
# RUN sed -Ei 's/^deb /deb-src /' /etc/apt/sources.list
# RUN apt update
# RUN apt build-dep msmtp
# RUN autoreconf -i
# RUN ./configure; make; make install
RUN apt install -y python3-pip sharutils uuid-runtime
RUN pip3 install jinja2-cli
# WORKDIR /

# EXPOSE 1080 1025

ENTRYPOINT [ "/bin/bash" ]