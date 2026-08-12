from telethon import TelegramClient
from ..Config.iqthon_config import Config

# إنشاء جلسة اليوزربوت
iqthon = TelegramClient(
    Config.SESSION_NAME,
    Config.API_ID,
    Config.API_HASH
)

# إنشاء بوت تيليجرام إذا كان التوكن موجود
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
