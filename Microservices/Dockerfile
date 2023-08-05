FROM python:3.10-slim

ARG STAGE

RUN echo "import os" > /say_hello.py
RUN echo "print('Stage: $STAGE')" >> /say_hello.py
RUN echo "print(os.getenv('ACCOUNT'))" >> /say_hello.py

ENTRYPOINT python /say_hello.py