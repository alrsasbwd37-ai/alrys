FROM python:3.10-slim

RUN apt update && apt install -y git gcc libpq-dev ffmpeg && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/alrsasbwd37-ai/alrys.git /root/Arab

WORKDIR /root/Arab

RUN pip3 install --no-cache-dir -r requirements.txt

RUN mkdir -p /root/Arab/Arab/Config

RUN cat > /root/Arab/Arab/Config/iqthon_config.py <<'EOF'
import os

class Config:
    BOT_TOKEN = os.environ.get("BOT_TOKEN","")
    STRING_SESSION = os.environ.get("STRING_SESSION","")
    SESSION_NAME = os.environ.get("SESSION_NAME","")

    API_ID = int(os.environ.get("API_ID",0))
    APP_ID = API_ID

    API_HASH = os.environ.get("API_HASH","")
    APP_HASH = API_HASH

    DATABASE_URL = os.environ.get("DATABASE_URL")
    DB_URI = DATABASE_URL

    REDIS_URI = os.environ.get("REDIS_URI")

    COMMAND_HANDLER = os.environ.get("COMMAND_HANDLER",".")
    OWNER_ID = int(os.environ.get("OWNER_ID",0))

    SUDO_USERS = list(
        map(int,filter(None,
        os.environ.get("SUDO_USERS","").split()))
    )

    LOG_GROUP = os.environ.get("LOG_GROUP")

    PRIVATE_GROUP_BOT_API_ID = int(
        os.environ.get("PRIVATE_GROUP_BOT_API_ID",0)
    )

    PM_LOGGER_GROUP_ID = int(
        os.environ.get("PM_LOGGER_GROUP_ID",0)
    )

    RANDOM_STUFF_API_KEY = os.environ.get(
        "RANDOM_STUFF_API_KEY",""
    )

    BOTLOG = False
    BOTLOG_CHATID = "me"
EOF

RUN echo "from .iqthon_config import Config" > /root/Arab/Arab/Config/__init__.py


RUN sed -i 's/if Config.STRING_SESSION:/if Config.STRING_SESSION:/g' /root/Arab/Arab/core/session.py


RUN cat > /root/Arab/run.py <<'EOF'
import os
import sys

sys.path.insert(0,"/root/Arab")

print("[INFO] Starting Arab")

if not os.environ.get("BOT_TOKEN") and not os.environ.get("STRING_SESSION"):
    print("[ERROR] Missing BOT_TOKEN or STRING_SESSION")
    sys.exit(1)

try:
    from Arab import bot
    print("[OK] Bot loaded")
except Exception as e:
    import traceback
    traceback.print_exc()
    print(e)
    sys.exit(1)
EOF


ENV PYTHONUNBUFFERED=1

CMD ["python3","/root/Arab/run.py"]
