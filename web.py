from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Bot is running"

@app.route("/health")
def health():
    return "OK", 200

def start_web():
    app.run(
        host="0.0.0.0",
        port=10000,
        debug=False,
        threaded=True
    )

if __name__ == "__main__":
    start_web()
