#!bin

boundary=$(uuidgen) && \
  jinja2 -D recipient=blaise@me.com -D subject="test email" -D boundary=$boundary message.txt.jinja2 > message.txt && uuencode -m consular-service-request-form-completed.pdf consular-service-request-form-completed.pdf >> message.txt && echo "" >> message.txt && echo "--$boundary--" >> message.txt