from telethon import TelegramClient
from telethon.sessions import StringSession
from Arab.Config import Config

print("DEBUG SESSION FILE")
print("APP_ID =", Config.APP_ID)
print("APP_HASH =", Config.APP_HASH)
print("SESSION =", bool(Config.STRING_SESSION))

if not Config.APP_ID or not Config.APP_HASH:
    raise Exception("API_ID OR API_HASH EMPTY")

iqthon = TelegramClient(
    StringSession(Config.STRING_SESSION),
    Config.APP_ID,
    Config.APP_HASH
)

if Config.BOT_TOKEN:
    iqthon.tgbot = TelegramClient(
        "bot",
        Config.APP_ID,
        Config.APP_HASH
    )
else:
    iqthon.tgbot = None
