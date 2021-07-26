FROM python:3.8-alpine
WORKDIR /project_web1
ENV FLASK_APP=app.py
ENV FLASK_RUN_PORT=80
ENV FLASK_RUN_HOST=0.0.0.0
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
EXPOSE 80
COPY . .
CMD ["flask", "run"]