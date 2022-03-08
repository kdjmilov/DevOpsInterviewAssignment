FROM python:3.7-alpine

RUN apk update

COPY requirements.txt .

RUN pip3 install virtualenv
RUN python -m virtualenv newvenv

COPY . .

RUN pip3 install requirements.txt

CMD ["python3", "microservice/main.py"]