FROM dmitryrck/msmtp

RUN apt update && apt upgrade -y
RUN apt install -y python3-pip sharutils uuid-runtime
RUN pip3 install jinja2-cli

ENTRYPOINT [ "/bin/bash" ]