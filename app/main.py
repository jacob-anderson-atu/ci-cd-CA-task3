import os

from flask import Flask, jsonify
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
# Expose application request and response metrics
metrics = PrometheusMetrics(app)

metrics.info(
        "app_info",
        "Application information",
        version="1.0.0",
)

@app.route('/')
def home():
    return jsonify(
        application="DevOps Pipeline Demo",
        status="running",
        version="1.0.0"
    )

@app.route('/health')
def health():
    return jsonify(
        status="healthy"
    )

if __name__ == '__main__':
    host = os.getenv("APP_HOST", "127.0.0.1") # defaults, docker can override binds
    port = int(os.getenv("APP_PORT", "5000"))
    app.run(host=host, port=port)