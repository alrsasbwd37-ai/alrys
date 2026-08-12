import os

class Config:

    # البوت
    TG_BOT_TOKEN = os.environ.get("TG_BOT_TOKEN", "")
    BOT_TOKEN = TG_BOT_TOKEN

    # اليوزربوت
    STRING_SESSION = os.environ.get("STRING_SESSION", "")

    APP_ID = int(os.environ.get("APP_ID", "0"))
    APP_HASH = os.environ.get("APP_HASH", "")

    # توافق مع الملفات القديمة
    API_ID = APP_ID
    API_HASH = APP_HASH
    SESSION_NAME = STRING_SESSION

    # المالك
    OWNER_ID = int(os.environ.get("OWNER_ID", "0"))

    # قاعدة البيانات
    DATABASE_URL = os.environ.get("DATABASE_URL", None)
    DB_URI = DATABASE_URL
    REDIS_URI = os.environ.get("REDIS_URI", None)

    # الإعدادات
    COMMAND_HANDLER = os.environ.get("COMMAND_HANDLER", ".")

    SUDO_USERS = list(
        map(int, os.environ.get("SUDO_USERS", "").split())
    )

    RANDOM_STUFF_API_KEY = os.environ.get(
        "RANDOM_STUFF_API_KEY", ""
    )

print("✅ iqthon Config Loaded")
