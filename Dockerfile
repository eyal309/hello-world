FROM python:3.6-alpine as base
RUN apk update && apk add build-base

COPY . /code/
WORKDIR /code
RUN pip install -r requirements.txt

FROM python:3.6-alpine

COPY --from=base /code/ /code
COPY --from=base /usr/local/lib/python3.6 /usr/local/lib/python3.6
COPY --from=base /usr/local/bin/gunicorn /usr/local/bin/gunicorn
WORKDIR /code

EXPOSE 8080

ENTRYPOINT ["gunicorn", "-b 0.0.0.0:3030", "app:app"]
