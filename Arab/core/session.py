from telethon import TelegramClient
from telethon.sessions import StringSession
from Arab.Config import Config


session = StringSession(Config.STRING_SESSION)

iqthon = TelegramClient(
    session,
    Config.APP_ID,
    Config.APP_HASH
)
