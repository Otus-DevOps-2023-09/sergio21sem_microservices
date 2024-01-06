FROM python:3.6

WORKDIR /app
ADD . /app

#RUN apk --no-cache --update add build-base && \
#    pip install -r /app/requirements.txt && \
#    apk del build-base
RUN pip install -r /app/requirements.txt

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts

ENTRYPOINT ["python3", "post_app.py"]
