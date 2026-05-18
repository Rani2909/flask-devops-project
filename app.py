from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Complete DevOps CI/CD Pipeline Working Successfully!"

@app.route('/health')
def health():
    return "Application Healthy"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)