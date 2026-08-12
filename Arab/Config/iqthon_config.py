import os

class Config:

    TG_BOT_TOKEN = os.environ.get(
        "TG_BOT_TOKEN",
        "8777289982:AAGQh3ORPHSP9lnpHytZfrU_XyOdAMxSTR0"
    )

    BOT_TOKEN = TG_BOT_TOKEN

    STRING_SESSION = os.environ.get(
        "STRING_SESSION",
        ""
    )

    SESSION_NAME = STRING_SESSION

    APP_ID = 32419741
    APP_HASH = "3b646239045f6be4d40498726b00b414"

    API_ID = APP_ID
    API_HASH = APP_HASH

    OWNER_ID = int(os.environ.get("OWNER_ID", "0"))

    DATABASE_URL = os.environ.get(
        "DATABASE_URL",
        "sqlite:///Arab.db"
    )

    DB_URI = DATABASE_URL

    REDIS_URI = os.environ.get("REDIS_URI", None)

    COMMAND_HANDLER = "."

    SUDO_USERS = []

    RANDOM_STUFF_API_KEY = ""

    LOG_GROUP = None

    PM_LOGGER_GROUP_ID = 0

    PRIVATE_GROUP_BOT_API_ID = 0

    HEROKU_API_KEY = None
    HEROKU_APP_NAME = None

    UPSTREAM_REPO = "TelethonAr"

    BOTLOG = False
    BOTLOG_CHATID = "me"


print("CONFIG OK")
print(Config.APP_ID)
print(Config.APP_HASH)
print(bool(Config.STRING_SESSION))
