RUN mkdir -p /root/Arab/Arab/Config && \
cat > /root/Arab/Arab/Config/iqthon_config.py <<'EOF'
import os

class Config:

    TG_BOT_TOKEN = os.environ.get("TG_BOT_TOKEN", "")
    BOT_TOKEN = TG_BOT_TOKEN

    STRING_SESSION = os.environ.get("STRING_SESSION", "")
    SESSION_NAME = STRING_SESSION

    APP_ID = int(os.environ.get("APP_ID", "0"))
    APP_HASH = os.environ.get("APP_HASH", "")

    API_ID = APP_ID
    API_HASH = APP_HASH

    OWNER_ID = int(os.environ.get("OWNER_ID", "0"))

    DATABASE_URL = os.environ.get(
        "DATABASE_URL",
        "sqlite:///Arab.db"
    )
    DB_URI = DATABASE_URL

    REDIS_URI = os.environ.get("REDIS_URI", None)

    COMMAND_HANDLER = os.environ.get(
        "COMMAND_HANDLER",
        "."
    )

    SUDO_USERS = list(
        map(
            int,
            filter(
                None,
                os.environ.get("SUDO_USERS", "").split()
            )
        )
    )

    RANDOM_STUFF_API_KEY = os.environ.get(
        "RANDOM_STUFF_API_KEY",
        ""
    )

    LOG_GROUP = os.environ.get(
        "LOG_GROUP",
        None
    )

    PM_LOGGER_GROUP_ID = int(
        os.environ.get("PM_LOGGER_GROUP_ID", "0")
    )

    PRIVATE_GROUP_BOT_API_ID = int(
        os.environ.get("PRIVATE_GROUP_BOT_API_ID", "0")
    )

    HEROKU_API_KEY = os.environ.get(
        "HEROKU_API_KEY",
        None
    )

    HEROKU_APP_NAME = os.environ.get(
        "HEROKU_APP_NAME",
        None
    )

    UPSTREAM_REPO = os.environ.get(
        "UPSTREAM_REPO",
        "TelethonAr"
    )

    BOTLOG = False
    BOTLOG_CHATID = "me"

print("✅ iqthon Config Loaded")
EOF
