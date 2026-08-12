import os

class Config:
    # ==========================================
    # 🤖 بيانات البوت
    # ==========================================
    TG_BOT_TOKEN = os.environ.get(
        "TG_BOT_TOKEN",
        "8777289982:AAGQh3ORPHSP9lnpHytZfrU_XyOdAMxSTR0"
    )

    BOT_TOKEN = TG_BOT_TOKEN

    # ==========================================
    # 📁 بيانات جلسة اليوزر
    # ==========================================
    STRING_SESSION = os.environ.get(
        "STRING_SESSION",
        "1BJWap1sBuyK94yERw2-ttcwYSxLar1wXB4QLwxBBsgDcbP2tjAyoGpNt2VrglFjyey9PMT2PQvOVgigzBhBiFAcbD9zNsx6gdSjGzYVGqnwFCdk3oGVBy3VBn8ocF2CccGz4h2Kl14tV0mJkv-csxYmVGq8WLvuaQfoM92eio9gJDLwLljHmp8-M23EYsolNzCURnp8rtA2_Q3GiXL9sFeLwNZp-5Z0864OUbdMw9OZ88U7vr38I8uJp7_SJK7H-Gidahl4yWXz9EehhNZhGDPsyq3vp2VQhVd7oN7hs3zSUEfuZJ9NeER9DgN7gtUe1M185I5LjxAApPn53dhXnAlesk3jksB4="
    )

    SESSION_NAME = STRING_SESSION

    # ==========================================
    # 🔑 API TELEGRAM
    # ==========================================
    APP_ID = int(os.environ.get("APP_ID", "32419741"))

    API_ID = APP_ID

    APP_HASH = os.environ.get(
        "APP_HASH",
        "3b646239045f6be4d40498726b00b414"
    )

    API_HASH = APP_HASH

    # ==========================================
    # 👤 المالك
    # ==========================================
    OWNER_ID = int(os.environ.get("OWNER_ID", "8218549576"))

    SUDO_USERS = [OWNER_ID]

    # ==========================================
    # 🗄️ قاعدة البيانات
    # ==========================================
    DATABASE_URL = os.environ.get("DATABASE_URL", None)
    DB_URI = DATABASE_URL

    REDIS_URI = os.environ.get("REDIS_URI", None)

    # ==========================================
    # ⚙️ إعدادات عامة
    # ==========================================
    COMMAND_HANDLER = os.environ.get("COMMAND_HANDLER", ".")

    RANDOM_STUFF_API_KEY = os.environ.get(
        "RANDOM_STUFF_API_KEY",
        ""
    )

    LOG_GROUP = os.environ.get("LOG_GROUP", None)

    OPENWEATHERMAP_API_KEY = os.environ.get(
        "OPENWEATHERMAP_API_KEY",
        ""
    )

    GITHUB_ACCESS_TOKEN = os.environ.get(
        "GITHUB_ACCESS_TOKEN",
        ""
    )


print("[INFO] ✅ تم تحميل Config من iqthon_config.py")
