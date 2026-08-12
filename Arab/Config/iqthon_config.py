import os

class Config:

    BOT_TOKEN = os.environ.get(
        "TG_BOT_TOKEN",
        os.environ.get("BOT_TOKEN", "")
    )

    SESSION_NAME = os.environ.get(
        "STRING_SESSION",
        os.environ.get("SESSION_NAME", "")
    )

    API_ID = int(
        os.environ.get(
            "APP_ID",
            os.environ.get("API_ID", "0")
        )
    )

    API_HASH = os.environ.get(
        "APP_HASH",
        os.environ.get("API_HASH", "")
    )

    OWNER_ID = int(os.environ.get("OWNER_ID", "0"))

    DATABASE_URL = os.environ.get("DATABASE_URL", None)
    DB_URI = DATABASE_URL

    REDIS_URI = os.environ.get("REDIS_URI", None)

    COMMAND_HANDLER = os.environ.get("COMMAND_HANDLER", ".")

    SUDO_USERS = list(
        map(int, os.environ.get("SUDO_USERS", "").split())
    )

    RANDOM_STUFF_API_KEY = os.environ.get(
        "RANDOM_STUFF_API_KEY", ""
    )

print("[INFO] ✅ Config Loaded")
