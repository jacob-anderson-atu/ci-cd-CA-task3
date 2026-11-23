FROM python:3.14-slim

#RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

#RUN python -m pip install --no-cache-dir --upgrade pip setuptools wheel

RUN pip install --no-cache-dir -r requirements.txt

COPY app/ ./app/

ENV APP_HOST=0.0.0.0
ENV APP_PORT=5000

EXPOSE 5000

CMD ["python", "-m", "app.main"]