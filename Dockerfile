FROM python:3.10-slim

RUN apt update && apt install -y git gcc libpq-dev && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/alrsasbwd37-ai/alrys.git /root/Arab

WORKDIR /root/Arab

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install randomstuff

# إنشاء Config
RUN mkdir -p /root/Arab/Arab/Config && \
cat > /root/Arab/Arab/Config/iqthon_config.py <<'EOF'
import os

class Config:
    BOT_TOKEN = os.environ.get("BOT_TOKEN", "")
    STRING_SESSION = os.environ.get("STRING_SESSION", "")
    SESSION_NAME = os.environ.get("SESSION_NAME", "")

    API_ID = int(os.environ.get("API_ID", 0))
    APP_ID = API_ID

    API_HASH = os.environ.get("API_HASH", "")
    APP_HASH = API_HASH

    DATABASE_URL = os.environ.get("DATABASE_URL", None)
    DB_URI = DATABASE_URL

    REDIS_URI = os.environ.get("REDIS_URI", None)

    COMMAND_HANDLER = os.environ.get("COMMAND_HANDLER", ".")

    OWNER_ID = int(os.environ.get("OWNER_ID", 0))

    SUDO_USERS = list(
        map(int, filter(None, os.environ.get("SUDO_USERS", "").split()))
    )

    RANDOM_STUFF_API_KEY = os.environ.get(
        "RANDOM_STUFF_API_KEY", ""
    )

    LOG_GROUP = os.environ.get("LOG_GROUP", None)

    PM_LOGGER_GROUP_ID = int(
        os.environ.get("PM_LOGGER_GROUP_ID", 0)
    )

    PRIVATE_GROUP_BOT_API_ID = int(
        os.environ.get("PRIVATE_GROUP_BOT_API_ID", 0)
    )

    HEROKU_API_KEY = os.environ.get("HEROKU_API_KEY", None)
    HEROKU_APP_NAME = os.environ.get("HEROKU_APP_NAME", None)

    UPSTREAM_REPO = os.environ.get(
        "UPSTREAM_REPO",
        "TelethonAr"
    )

    BOTLOG = False
    BOTLOG_CHATID = "me"
EOF

RUN echo "from .iqthon_config import Config" > /root/Arab/Arab/Config/__init__.py


# إصلاح الاستيرادات
RUN find /root/Arab/Arab/core -name "*.py" \
-exec sed -i 's/from \.\.Config import Config/from Arab.Config.iqthon_config import Config/g' {} \;

RUN find /root/Arab/Arab/helpers -name "*.py" \
-exec sed -i 's/from \.\.Config import Config/from Arab.Config.iqthon_config import Config/g' {} \;


# إصلاح session
RUN sed -i \
's/Config.API_ID/Config.APP_ID/g' \
/root/Arab/Arab/core/session.py || true

RUN sed -i \
's/Config.API_HASH/Config.APP_HASH/g' \
/root/Arab/Arab/core/session.py || true


# ملف التشغيل
RUN cat > /root/Arab/run.py <<'EOF'
import os
import sys

sys.path.insert(0, "/root/Arab")

print("🚀 تشغيل Arab...")

if not os.environ.get("BOT_TOKEN"):
    print("❌ BOT_TOKEN غير موجود")
    sys.exit(1)

try:
    from Arab import bot
    print("✅ تم تشغيل البوت")
except Exception:
    import traceback
    traceback.print_exc()
    sys.exit(1)
EOF


ENV PATH="/home/Arab/bin:$PATH"

CMD ["python3", "/root/Arab/run.py"]
