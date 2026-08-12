# تحقق من أن web_server.py موجود
ls -la /root/Arab/web_server.py

# إذا لم يكن موجوداً، أنشئه:
cat > /root/Arab/web_server.py <<'EOF'
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Bot is running"

@app.route("/health")
def health():
    return "OK", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=10000, debug=False, threaded=True)
EOF
