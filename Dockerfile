FROM python:3.10-slim

RUN apt update && apt install -y git gcc libpq-dev && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/alrsasbwd37-ai/alrys.git /root/Arab

WORKDIR /root/Arab

RUN pip install --no-cache-dir -r requirements.txt

# ===== تثبيت المكتبات المفقودة =====
RUN pip install youtube-search-python

# ===== إنشاء Config =====
RUN mkdir -p /root/Arab/Arab/Config && \
cat > /root/Arab/Arab/Config/iqthon_config.py <<'EOF'
import os

class Config:
    BOT_TOKEN = os.environ.get("BOT_TOKEN", "")
    TG_BOT_TOKEN = os.environ.get("BOT_TOKEN", "")
    STRING_SESSION = os.environ.get("STRING_SESSION", "")
    SESSION_NAME = os.environ.get("SESSION_NAME", "")

    API_ID = int(os.environ.get("API_ID", 0))
    APP_ID = API_ID

    API_HASH = os.environ.get("API_HASH", "")
    APP_HASH = API_HASH

    DATABASE_URL = os.environ.get("DATABASE_URL", "sqlite:///Arab.db")
    DB_URI = DATABASE_URL

    REDIS_URI = os.environ.get("REDIS_URI", None)

    COMMAND_HANDLER = os.environ.get("COMMAND_HANDLER", ".")

    OWNER_ID = int(os.environ.get("OWNER_ID", 0))

    SUDO_USERS = list(
        map(int, filter(None, os.environ.get("SUDO_USERS", "").split()))
    )

    RANDOM_STUFF_API_KEY = os.environ.get(
        "RANDOM_STUFF_API_KEY", ""
    )

    LOG_GROUP = os.environ.get("LOG_GROUP", None)

    PM_LOGGER_GROUP_ID = int(
        os.environ.get("PM_LOGGER_GROUP_ID", 0)
    )

    PRIVATE_GROUP_BOT_API_ID = int(
        os.environ.get("PRIVATE_GROUP_BOT_API_ID", 0)
    )

    HEROKU_API_KEY = os.environ.get("HEROKU_API_KEY", None)
    HEROKU_APP_NAME = os.environ.get("HEROKU_APP_NAME", None)

    UPSTREAM_REPO = os.environ.get(
        "UPSTREAM_REPO",
        "TelethonAr"
    )

    BOTLOG = False
    BOTLOG_CHATID = "me"
EOF

RUN echo "from .iqthon_config import Config" > /root/Arab/Arab/Config/__init__.py

# ===== إصلاح الاستيرادات =====
RUN find /root/Arab/Arab -name "*.py" \
-exec sed -i 's/from \.\.Config import Config/from Arab.Config import Config/g' {} \;

# ===== إصلاح session.py =====
RUN sed -i 's/Config.API_ID/Config.APP_ID/g' /root/Arab/Arab/core/session.py || true
RUN sed -i 's/Config.API_HASH/Config.APP_HASH/g' /root/Arab/Arab/core/session.py || true

# ===== إصلاح sql_helper/__init__.py =====
RUN cat > /root/Arab/Arab/sql_helper/__init__.py <<'EOF'
import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, scoped_session

BASE = declarative_base()

DB_URI = os.environ.get("DATABASE_URL", None)

if DB_URI and DB_URI.startswith("postgres://"):
    DB_URI = DB_URI.replace("postgres://", "postgresql://", 1)
    print("[INFO] ✅ تم تحويل postgres:// إلى postgresql://")

if DB_URI:
    try:
        engine = create_engine(DB_URI)
        SESSION = scoped_session(sessionmaker(bind=engine))
        BASE.metadata.bind = engine
        print("[INFO] ✅ تم الاتصال بقاعدة البيانات")
    except Exception as e:
        print(f"[ERROR] ❌ فشل الاتصال بقاعدة البيانات: {e}")
        engine = create_engine("sqlite:///Arab.db")
        SESSION = scoped_session(sessionmaker(bind=engine))
        BASE.metadata.bind = engine
        print("[WARNING] ⚠️ يتم استخدام SQLite كبديل")
else:
    engine = create_engine("sqlite:///Arab.db")
    SESSION = scoped_session(sessionmaker(bind=engine))
    BASE.metadata.bind = engine
    print("[WARNING] ⚠️ DATABASE_URL غير موجود، يتم استخدام SQLite مؤقتاً")

def create_tables():
    try:
        BASE.metadata.create_all(engine)
        print("[INFO] ✅ تم إنشاء الجداول")
    except Exception as e:
        print(f"[ERROR] ❌ فشل إنشاء الجداول: {e}")

print("[INFO] ✅ تم إعداد قاعدة البيانات")

__all__ = ['BASE', 'SESSION', 'create_tables']
EOF

# ===== إصلاح sql_helper/globals.py =====
RUN cat > /root/Arab/Arab/sql_helper/globals.py <<'EOF'
import sys
try:
    from . import BASE, SESSION
except ImportError:
    from sqlalchemy import create_engine
    from sqlalchemy.ext.declarative import declarative_base
    from sqlalchemy.orm import sessionmaker, scoped_session
    
    BASE = declarative_base()
    engine = create_engine("sqlite:///Arab.db")
    SESSION = scoped_session(sessionmaker(bind=engine))
    BASE.metadata.bind = engine

from sqlalchemy import Column, String

class Globals(BASE):
    __tablename__ = "globals"
    key = Column(String, primary_key=True)
    value = Column(String)

    def __init__(self, key, value):
        self.key = key
        self.value = value

def gvarstatus(key):
    try:
        result = SESSION.query(Globals).filter(Globals.key == key).first()
        if result:
            return result.value
        return None
    except Exception as e:
        print(f"[ERROR] gvarstatus: {e}")
        return None

def addgvar(key, value):
    try:
        if gvarstatus(key) is not None:
            return
        SESSION.add(Globals(key, value))
        SESSION.commit()
    except Exception as e:
        print(f"[ERROR] addgvar: {e}")
        SESSION.rollback()

def delgvar(key):
    try:
        if gvarstatus(key) is None:
            return
        SESSION.delete(SESSION.query(Globals).filter(Globals.key == key).first())
        SESSION.commit()
    except Exception as e:
        print(f"[ERROR] delgvar: {e}")
        SESSION.rollback()
EOF

# ===== إصلاح chatbot.py =====
RUN cat > /root/Arab/Arab/helpers/chatbot.py <<'EOF'
import randomstuff
from Arab.Config import Config

_rs_client = None

async def get_rs_client():
    global _rs_client
    if _rs_client is None:
        try:
            _rs_client = randomstuff.AsyncClient(
                api_key=Config.RANDOM_STUFF_API_KEY,
                version="4",
                suppress_warnings=True
            )
        except Exception as e:
            print(f"[ERROR] Failed to initialize randomstuff client: {e}")
            _rs_client = None
    return _rs_client
EOF

# ===== إصلاح helpers/__init__.py =====
RUN cat > /root/Arab/Arab/helpers/__init__.py <<'EOF'
from . import fonts
from . import memeshelper as catmemes
from .aiohttp_helper import AioHttp
from .utils import *

try:
    from .functions import *
    from .memeifyhelpers import *
    from .progress import *
    from .qhelper import process
    from .tools import *
    from .utils import _cattools, _catutils, _format
except Exception as e:
    print(f"[WARNING] helpers load error: {e}")
EOF

# ===== إصلاح Arab/__init__.py =====
RUN cat > /root/Arab/Arab/__init__.py <<'EOF'
import time
import heroku3
import sys

try:
    from .Config import Config
except ImportError:
    Config = sys.modules.get('Arab.Config', None)
    if Config is None:
        import os
        class Config:
            BOT_TOKEN = os.environ.get("BOT_TOKEN", "")
            TG_BOT_TOKEN = os.environ.get("BOT_TOKEN", "")
            STRING_SESSION = os.environ.get("STRING_SESSION", "")
            SESSION_NAME = os.environ.get("SESSION_NAME", "")
            API_ID = int(os.environ.get("API_ID", 0))
            APP_ID = int(os.environ.get("API_ID", 0))
            API_HASH = os.environ.get("API_HASH", "")
            APP_HASH = os.environ.get("API_HASH", "")
            RANDOM_STUFF_API_KEY = os.environ.get("RANDOM_STUFF_API_KEY", "")
            LOG_GROUP = os.environ.get("LOG_GROUP", None)
            DATABASE_URL = os.environ.get("DATABASE_URL", "sqlite:///Arab.db")
            COMMAND_HANDLER = os.environ.get("COMMAND_HANDLER", ".")
            SUDO_USERS = list(map(int, filter(None, os.environ.get("SUDO_USERS", "").split())))
            OWNER_ID = int(os.environ.get("OWNER_ID", 0))
            OPENWEATHERMAP_API_KEY = os.environ.get("OPENWEATHERMAP_API_KEY", "")
            GITHUB_ACCESS_TOKEN = os.environ.get("GITHUB_ACCESS_TOKEN", "")
            DB_URI = os.environ.get("DATABASE_URL", "sqlite:///Arab.db")
            REDIS_URI = os.environ.get("REDIS_URI", None)
            PRIVATE_GROUP_BOT_API_ID = int(os.environ.get("PRIVATE_GROUP_BOT_API_ID", 0))
            PM_LOGGER_GROUP_ID = int(os.environ.get("PM_LOGGER_GROUP_ID", 0))
            HEROKU_API_KEY = os.environ.get("HEROKU_API_KEY", None)
            HEROKU_APP_NAME = os.environ.get("HEROKU_APP_NAME", None)
            UPSTREAM_REPO = os.environ.get("UPSTREAM_REPO", "TelethonAr")
            BOTLOG = False
            BOTLOG_CHATID = "me"

from .core.logger import logging
from .core.session import iqthon
from .sql_helper.globals import addgvar, delgvar, gvarstatus

__version__ = "7.7"
__license__ = "GNU Affero General Public License v3.0"
__author__ = "<t.me/iqthon>"
__copyright__ = "telethon AR (C) 2020 - 2021 " + __author__

iqthon.version = __version__
iqthon.tgbot.version = __version__

LOGS = logging.getLogger("IQTHON")

bot = iqthon
StartTime = time.time()

catversion = "7.6"

if Config.UPSTREAM_REPO == "TelethonAr":
    UPSTREAM_REPO_URL = "https://github.com/alrsasbwd37-ai/alrys"
else:
    UPSTREAM_REPO_URL = Config.UPSTREAM_REPO

if Config.PRIVATE_GROUP_BOT_API_ID == 0:
    if gvarstatus("PRIVATE_GROUP_BOT_API_ID") is None:
        Config.BOTLOG = False
        Config.BOTLOG_CHATID = "me"
    else:
        Config.BOTLOG_CHATID = int(gvarstatus("PRIVATE_GROUP_BOT_API_ID"))
        Config.PRIVATE_GROUP_BOT_API_ID = int(gvarstatus("PRIVATE_GROUP_BOT_API_ID"))
        Config.BOTLOG = True
else:
    if str(Config.PRIVATE_GROUP_BOT_API_ID)[0] != "-":
        Config.BOTLOG_CHATID = int("-" + str(Config.PRIVATE_GROUP_BOT_API_ID))
    else:
        Config.BOTLOG_CHATID = Config.PRIVATE_GROUP_BOT_API_ID
    Config.BOTLOG = True

if Config.PM_LOGGER_GROUP_ID == 0:
    if gvarstatus("PM_LOGGER_GROUP_ID") is None:
        Config.PM_LOGGER_GROUP_ID = -100
    else:
        Config.PM_LOGGER_GROUP_ID = int(gvarstatus("PM_LOGGER_GROUP_ID"))
elif str(Config.PM_LOGGER_GROUP_ID)[0] != "-":
    Config.PM_LOGGER_GROUP_ID = int("-" + str(Config.PM_LOGGER_GROUP_ID))

try:
    if Config.HEROKU_API_KEY is not None or Config.HEROKU_APP_NAME is not None:
        HEROKU_APP = heroku3.from_key(Config.HEROKU_API_KEY).apps()[Config.HEROKU_APP_NAME]
    else:
        HEROKU_APP = None
except Exception:
    HEROKU_APP = None

COUNT_MSG = 0
ISAFK = False
AFKREASON = None

USERS = {}
COUNT_PM = {}
LASTMSG = {}

CMD_HELP = {}
CMD_LIST = {}
SUDO_LIST = {}

LOAD_PLUG = {}
INT_PLUG = ""

BOTLOG = Config.BOTLOG
BOTLOG_CHATID = Config.BOTLOG_CHATID
PM_LOGGER_GROUP_ID = Config.PM_LOGGER_GROUP_ID
EOF

# ===== فحص Config =====
RUN python3 -c "from Arab.Config import Config; print('✅ Config OK')"

# ===== إنشاء run.py =====
RUN cat > /root/Arab/run.py <<'EOF'
import os
import sys
import asyncio
import logging

logging.basicConfig(level=logging.INFO)

sys.path.insert(0, "/root/Arab")

print("🚀 تشغيل Arab...")

if not os.environ.get("BOT_TOKEN"):
    print("❌ BOT_TOKEN غير موجود")
    sys.exit(1)

async def main():
    try:
        # إنشاء الجداول إذا لم تكن موجودة
        try:
            from Arab.sql_helper import create_tables
            create_tables()
            print("[INFO] ✅ تم التحقق من قاعدة البيانات")
        except Exception as e:
            print(f"[WARNING] ⚠️ مشكلة في قاعدة البيانات: {e}")

        from Arab import bot
        
        # بدء التشغيل
        await bot.start(bot_token=os.environ.get("BOT_TOKEN"))
        
        print("✅ تم تشغيل البوت والاتصال بنجاح")
        await bot.run_until_disconnected()
    except Exception as e:
        print(f"❌ خطأ في التشغيل: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    asyncio.run(main())
EOF

ENV PATH="/home/Arab/bin:$PATH"

CMD ["python3", "/root/Arab/run.py"]
