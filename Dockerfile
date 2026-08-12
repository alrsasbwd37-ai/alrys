FROM python:3.10-slim

RUN apt update && apt install -y git gcc libpq-dev

RUN git clone https://github.com/alrsasbwd37-ai/alrys.git /root/Arab

WORKDIR /root/Arab

# ===== تثبيت المتطلبات =====
RUN pip3 install --no-cache-dir -r requirements.txt

# ===== إنشاء Config مباشرة =====
RUN mkdir -p /root/Arab/Arab/Config && \
    echo 'import os' > /root/Arab/Arab/Config/iqthon_config.py && \
    echo '' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo 'class Config:' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    BOT_TOKEN = os.environ.get("BOT_TOKEN", "")' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    STRING_SESSION = os.environ.get("STRING_SESSION", "")' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    SESSION_NAME = os.environ.get("SESSION_NAME", "")' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    API_ID = int(os.environ.get("API_ID", 0))' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    APP_ID = int(os.environ.get("API_ID", 0))' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    API_HASH = os.environ.get("API_HASH", "")' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    APP_HASH = os.environ.get("API_HASH", "")' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    RANDOM_STUFF_API_KEY = os.environ.get("RANDOM_STUFF_API_KEY", "")' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    LOG_GROUP = os.environ.get("LOG_GROUP", None)' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    DATABASE_URL = os.environ.get("DATABASE_URL", None)' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    COMMAND_HANDLER = os.environ.get("COMMAND_HANDLER", ".")' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    SUDO_USERS = list(map(int, os.environ.get("SUDO_USERS", "").split()))' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    OWNER_ID = int(os.environ.get("OWNER_ID", 0))' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    OPENWEATHERMAP_API_KEY = os.environ.get("OPENWEATHERMAP_API_KEY", "")' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    GITHUB_ACCESS_TOKEN = os.environ.get("GITHUB_ACCESS_TOKEN", "")' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    DB_URI = os.environ.get("DATABASE_URL", None)' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    REDIS_URI = os.environ.get("REDIS_URI", None)' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    PRIVATE_GROUP_BOT_API_ID = int(os.environ.get("PRIVATE_GROUP_BOT_API_ID", 0))' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    PM_LOGGER_GROUP_ID = int(os.environ.get("PM_LOGGER_GROUP_ID", 0))' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    HEROKU_API_KEY = os.environ.get("HEROKU_API_KEY", None)' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    HEROKU_APP_NAME = os.environ.get("HEROKU_APP_NAME", None)' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    UPSTREAM_REPO = os.environ.get("UPSTREAM_REPO", "TelethonAr")' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    BOTLOG = False' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '    BOTLOG_CHATID = "me"' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo '' >> /root/Arab/Arab/Config/iqthon_config.py && \
    echo 'print("[INFO] ✅ تم تحميل Config من iqthon_config.py")' >> /root/Arab/Arab/Config/iqthon_config.py

# ===== إنشاء __init__.py في Config =====
RUN echo 'from .iqthon_config import Config' > /root/Arab/Arab/Config/__init__.py

# ===== إصلاح chatbot.py =====
RUN echo 'from .utils.extdl import install_pip' > /root/Arab/Arab/helpers/chatbot.py && \
    echo '' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo 'try:' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '    import randomstuff' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo 'except ModuleNotFoundError:' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '    install_pip("randomstuff")' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '    import randomstuff' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo 'from Arab.Config.iqthon_config import Config' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '_rs_client = None' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo 'async def get_rs_client():' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '    global _rs_client' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '    if _rs_client is None:' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '        try:' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '            _rs_client = randomstuff.AsyncClient(' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '                api_key=Config.RANDOM_STUFF_API_KEY,' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '                version="4",' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '                suppress_warnings=True' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '            )' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '        except Exception as e:' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '            print(f"[ERROR] Failed to initialize randomstuff client: {e}")' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '            _rs_client = None' >> /root/Arab/Arab/helpers/chatbot.py && \
    echo '    return _rs_client' >> /root/Arab/Arab/helpers/chatbot.py

# ===== إصلاح sql_helper/__init__.py =====
RUN cat > /root/Arab/Arab/sql_helper/__init__.py << 'EOF'
import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, scoped_session

BASE = declarative_base()

DB_URI = os.environ.get("DATABASE_URL", None)

if DB_URI:
    engine = create_engine(DB_URI)
    SESSION = scoped_session(sessionmaker(bind=engine))
    BASE.metadata.bind = engine
else:
    engine = create_engine("sqlite:///Arab.db")
    SESSION = scoped_session(sessionmaker(bind=engine))
    BASE.metadata.bind = engine
    print("[WARNING] ⚠️ DATABASE_URL غير موجود، يتم استخدام SQLite مؤقتاً")

def create_tables():
    BASE.metadata.create_all(engine)

print("[INFO] ✅ تم إعداد قاعدة البيانات")
EOF

# ===== إصلاح sql_helper/globals.py =====
RUN cat > /root/Arab/Arab/sql_helper/globals.py << 'EOF'
from . import BASE, SESSION
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
        return SESSION.query(Globals).filter(Globals.key == key).first().value
    except:
        return None

def addgvar(key, value):
    if gvarstatus(key) is not None:
        return
    SESSION.add(Globals(key, value))
    SESSION.commit()

def delgvar(key):
    if gvarstatus(key) is None:
        return
    SESSION.delete(SESSION.query(Globals).filter(Globals.key == key).first())
    SESSION.commit()
EOF

# ===== إنشاء run.py =====
RUN echo 'import os' > /root/Arab/run.py && \
    echo 'import asyncio' >> /root/Arab/run.py && \
    echo 'import sys' >> /root/Arab/run.py && \
    echo '' >> /root/Arab/run.py && \
    echo 'sys.path.insert(0, "/root/Arab")' >> /root/Arab/run.py && \
    echo '' >> /root/Arab/run.py && \
    echo 'print("[INFO] 🚀 جاري تهيئة البيئة...")' >> /root/Arab/run.py && \
    echo '' >> /root/Arab/run.py && \
    echo 'try:' >> /root/Arab/run.py && \
    echo '    asyncio.get_running_loop()' >> /root/Arab/run.py && \
    echo 'except RuntimeError:' >> /root/Arab/run.py && \
    echo '    asyncio.set_event_loop(asyncio.new_event_loop())' >> /root/Arab/run.py && \
    echo '    print("[INFO] تم إنشاء event loop جديد")' >> /root/Arab/run.py && \
    echo '' >> /root/Arab/run.py && \
    echo 'BOT_TOKEN = os.environ.get("BOT_TOKEN")' >> /root/Arab/run.py && \
    echo 'if BOT_TOKEN:' >> /root/Arab/run.py && \
    echo '    print("[INFO] ✅ سيتم التشغيل باستخدام BOT_TOKEN")' >> /root/Arab/run.py && \
    echo 'else:' >> /root/Arab/run.py && \
    echo '    print("[ERROR] ❌ BOT_TOKEN غير موجود!")' >> /root/Arab/run.py && \
    echo '    sys.exit(1)' >> /root/Arab/run.py && \
    echo '' >> /root/Arab/run.py && \
    echo 'class Config:' >> /root/Arab/run.py && \
    echo '    BOT_TOKEN = os.environ.get("BOT_TOKEN", "")' >> /root/Arab/run.py && \
    echo '    STRING_SESSION = os.environ.get("STRING_SESSION", "")' >> /root/Arab/run.py && \
    echo '    SESSION_NAME = os.environ.get("SESSION_NAME", "")' >> /root/Arab/run.py && \
    echo '    API_ID = int(os.environ.get("API_ID", 0))' >> /root/Arab/run.py && \
    echo '    APP_ID = int(os.environ.get("API_ID", 0))' >> /root/Arab/run.py && \
    echo '    API_HASH = os.environ.get("API_HASH", "")' >> /root/Arab/run.py && \
    echo '    APP_HASH = os.environ.get("API_HASH", "")' >> /root/Arab/run.py && \
    echo '    RANDOM_STUFF_API_KEY = os.environ.get("RANDOM_STUFF_API_KEY", "")' >> /root/Arab/run.py && \
    echo '    LOG_GROUP = os.environ.get("LOG_GROUP", None)' >> /root/Arab/run.py && \
    echo '    DATABASE_URL = os.environ.get("DATABASE_URL", None)' >> /root/Arab/run.py && \
    echo '    COMMAND_HANDLER = os.environ.get("COMMAND_HANDLER", ".")' >> /root/Arab/run.py && \
    echo '    SUDO_USERS = list(map(int, os.environ.get("SUDO_USERS", "").split()))' >> /root/Arab/run.py && \
    echo '    OWNER_ID = int(os.environ.get("OWNER_ID", 0))' >> /root/Arab/run.py && \
    echo '    OPENWEATHERMAP_API_KEY = os.environ.get("OPENWEATHERMAP_API_KEY", "")' >> /root/Arab/run.py && \
    echo '    GITHUB_ACCESS_TOKEN = os.environ.get("GITHUB_ACCESS_TOKEN", "")' >> /root/Arab/run.py && \
    echo '    DB_URI = os.environ.get("DATABASE_URL", None)' >> /root/Arab/run.py && \
    echo '    REDIS_URI = os.environ.get("REDIS_URI", None)' >> /root/Arab/run.py && \
    echo '    PRIVATE_GROUP_BOT_API_ID = int(os.environ.get("PRIVATE_GROUP_BOT_API_ID", 0))' >> /root/Arab/run.py && \
    echo '    PM_LOGGER_GROUP_ID = int(os.environ.get("PM_LOGGER_GROUP_ID", 0))' >> /root/Arab/run.py && \
    echo '    HEROKU_API_KEY = os.environ.get("HEROKU_API_KEY", None)' >> /root/Arab/run.py && \
    echo '    HEROKU_APP_NAME = os.environ.get("HEROKU_APP_NAME", None)' >> /root/Arab/run.py && \
    echo '    UPSTREAM_REPO = os.environ.get("UPSTREAM_REPO", "TelethonAr")' >> /root/Arab/run.py && \
    echo '    BOTLOG = False' >> /root/Arab/run.py && \
    echo '    BOTLOG_CHATID = "me"' >> /root/Arab/run.py && \
    echo '' >> /root/Arab/run.py && \
    echo 'import types' >> /root/Arab/run.py && \
    echo 'config_module = types.ModuleType("Arab.Config")' >> /root/Arab/run.py && \
    echo 'config_module.Config = Config' >> /root/Arab/run.py && \
    echo 'sys.modules["Arab.Config"] = config_module' >> /root/Arab/run.py && \
    echo 'sys.modules["Arab.Config.iqthon_config"] = config_module' >> /root/Arab/run.py && \
    echo 'sys.modules["sample_config"] = config_module' >> /root/Arab/run.py && \
    echo 'sys.modules["Config"] = config_module' >> /root/Arab/run.py && \
    echo '' >> /root/Arab/run.py && \
    echo 'print("[INFO] ✅ تم إعداد Config بنجاح")' >> /root/Arab/run.py && \
    echo 'print("[INFO] 🚀 جاري تشغيل Arab...")' >> /root/Arab/run.py && \
    echo '' >> /root/Arab/run.py && \
    echo 'try:' >> /root/Arab/run.py && \
    echo '    import runpy' >> /root/Arab/run.py && \
    echo '    runpy.run_module("Arab", run_name="__main__")' >> /root/Arab/run.py && \
    echo 'except Exception as e:' >> /root/Arab/run.py && \
    echo '    print(f"[ERROR] ❌ فشل التشغيل: {e}")' >> /root/Arab/run.py && \
    echo '    import traceback' >> /root/Arab/run.py && \
    echo '    traceback.print_exc()' >> /root/Arab/run.py && \
    echo '    sys.exit(1)' >> /root/Arab/run.py

# ===== إصلاح Arab/__init__.py =====
RUN cat > /root/Arab/Arab/__init__.py << 'EOF'
import time
import heroku3
import sys

try:
    from Arab.Config.iqthon_config import Config
except ImportError:
    Config = sys.modules.get('Arab.Config', None)
    if Config is None:
        import os
        class Config:
            BOT_TOKEN = os.environ.get("BOT_TOKEN", "")
            STRING_SESSION = os.environ.get("STRING_SESSION", "")
            SESSION_NAME = os.environ.get("SESSION_NAME", "")
            API_ID = int(os.environ.get("API_ID", 0))
            APP_ID = int(os.environ.get("API_ID", 0))
            API_HASH = os.environ.get("API_HASH", "")
            APP_HASH = os.environ.get("API_HASH", "")
            RANDOM_STUFF_API_KEY = os.environ.get("RANDOM_STUFF_API_KEY", "")
            LOG_GROUP = os.environ.get("LOG_GROUP", None)
            DATABASE_URL = os.environ.get("DATABASE_URL", None)
            COMMAND_HANDLER = os.environ.get("COMMAND_HANDLER", ".")
            SUDO_USERS = list(map(int, os.environ.get("SUDO_USERS", "").split()))
            OWNER_ID = int(os.environ.get("OWNER_ID", 0))
            OPENWEATHERMAP_API_KEY = os.environ.get("OPENWEATHERMAP_API_KEY", "")
            GITHUB_ACCESS_TOKEN = os.environ.get("GITHUB_ACCESS_TOKEN", "")
            DB_URI = os.environ.get("DATABASE_URL", None)
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

# ===== إصلاح core/session.py =====
RUN sed -i 's/if Config.STRING_SESSION:/if hasattr(Config, "STRING_SESSION") and Config.STRING_SESSION:/g' /root/Arab/Arab/core/session.py && \
    sed -i 's/elif Config.BOT_TOKEN:/elif hasattr(Config, "BOT_TOKEN") and Config.BOT_TOKEN:/g' /root/Arab/Arab/core/session.py && \
    sed -i 's/Config.API_ID/Config.APP_ID/g' /root/Arab/Arab/core/session.py && \
    sed -i 's/Config.API_HASH/Config.APP_HASH/g' /root/Arab/Arab/core/session.py

# ===== إصلاح جميع ملفات core و helpers =====
RUN find /root/Arab/Arab/core -name "*.py" -exec sed -i 's/from ..Config import Config/from Arab.Config.iqthon_config import Config/g' {} \;
RUN find /root/Arab/Arab/helpers -name "*.py" -exec sed -i 's/from ..Config import Config/from Arab.Config.iqthon_config import Config/g' {} \;

ENV PATH="/home/Arab/bin:$PATH"

CMD ["python3", "/root/Arab/run.py"]
