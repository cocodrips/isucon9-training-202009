FROM python:3

RUN mkdir -p /opt/webapp
WORKDIR /opt/webapp

ENV PYTHONPATH=/opt/webapp

ADD requirements.txt /opt/webapp
RUN pip install -r requirements.txt

# TODO: DELETE
ADD requirements.dev.txt /opt/webapp
RUN pip install -r requirements.dev.txt

CMD ["gunicorn" ,"app:app", "--reload", "-b", "0.0.0.0:8000", "--workers=5" ]
