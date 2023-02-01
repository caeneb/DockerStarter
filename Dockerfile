FROM python:3.8-slim-bullseye

RUN apt-get update

COPY ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

RUN mkdir /bind
RUN mkdir -p /bind/data
RUN mkdir -p /bind/logs

COPY ./code /code
WORKDIR /code
RUN chmod +x /code/cli.py

ENTRYPOINT ["/code/cli.py"]
CMD ["--help"]