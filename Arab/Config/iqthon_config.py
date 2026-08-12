import os

class Config:
    # بوت تيليجرام
    TG_BOT_TOKEN = os.environ.get(
        "TG_BOT_TOKEN",
        "8777289982:AAGQh3ORPHSP9lnpHytZfrU_XyOdAMxSTR0"
    )

    # بيانات تليثون
    APP_ID = int(os.environ.get(
        "APP_ID",
        "32419741"
    ))

    APP_HASH = os.environ.get(
        "APP_HASH",
        "3b646239045f6be4d40498726b00b414"
    )

    STRING_SESSION = os.environ.get(
        "STRING_SESSION",
        "1BJWap1sBuyK94yERw2-ttcwYSxLar1wXB4QLwxBBsgDcbP2tjAyoGpNt2VrglFjyey9PMT2PQvOVgigzBhBiFAcbD9zNsx6gdSjGzYVGqnwFCdk3oGVBy3VBn8ocF2CccGz4h2Kl14tV0mJkv-csxYmVGq8WLvuaQfoM92eio9gJDLwLljHmp8-M23EYsolNzCURnp8rtA2_Q3GiXL9sFeLwNZp-5Z0864OUbdMw9OZ88U7vr38I8uJp7_SJK7H-Gidahl4yWXz9EehhNZhGDPsyq3vp2VQhVd7oN7hs3zSUEfuZJ9NeER9DgN7gtUe1M185I5LjxAApPn53dhXnAlesk3jksB4="
    )

    OWNER_ID = int(os.environ.get(
        "OWNER_ID",
        "8218549576"
    ))

    DATABASE_URL = os.environ.get("DATABASE_URL", None)
    DB_URI = DATABASE_URL
    REDIS_URI = os.environ.get("REDIS_URI", None)

    COMMAND_HANDLER = os.environ.get(
        "COMMAND_HANDLER",
        "."
    )

    SUDO_USERS = list(map(
        int,
        os.environ.get("SUDO_USERS", "").split()
    ))

print("[INFO] ✅ Config loaded successfully")
print("APP_ID:", Config.APP_ID)
print("HASH:", bool(Config.APP_HASH))
