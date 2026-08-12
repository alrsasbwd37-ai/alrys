from telethon import TelegramClient
from Arab.Config import Config

print("API_ID:", Config.API_ID)
print("API_HASH:", Config.API_HASH[:5] if Config.API_HASH else "EMPTY")

iqthon = TelegramClient(
    Config.SESSION_NAME,
    Config.API_ID,
    Config.API_HASH
)

if Config.BOT_TOKEN:
    iqthon.tgbot = TelegramClient(
        "bot",
        Config.API_ID,
        Config.API_HASH
    ).start(
        bot_token=Config.BOT_TOKEN
    )
else:
    iqthon.tgbot = None
