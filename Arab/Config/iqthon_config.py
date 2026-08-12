# iqthon_config.py
import os

class Config:
    # ==========================================
    # 🤖 بيانات البوت
    # ==========================================
    BOT_TOKEN = os.environ.get("BOT_TOKEN", "your_bot_token_here")
    
    # ==========================================
    # 📁 بيانات الجلسة (لليوزربوت)
    # ==========================================
    SESSION_NAME = os.environ.get("SESSION_NAME", "arab_session")
    API_ID = int(os.environ.get("API_ID", 32419741))
    API_HASH = os.environ.get("API_HASH", "3b646239045f6be4d40498726b00b414")
    
    # ==========================================
    # 🔧 إعدادات إضافية
    # ==========================================
    RANDOM_STUFF_API_KEY = os.environ.get("RANDOM_STUFF_API_KEY", "")
    LOG_GROUP = os.environ.get("LOG_GROUP", None)
    DATABASE_URL = os.environ.get("DATABASE_URL", None)
    
    # ==========================================
    # ⚙️ إعدادات البوت
    # ==========================================
    COMMAND_HANDLER = os.environ.get("COMMAND_HANDLER", ".")
    SUDO_USERS = list(map(int, os.environ.get("SUDO_USERS", "").split()))
    OWNER_ID = int(os.environ.get("OWNER_ID", 0))
    
    # ==========================================
    # 🌐 إعدادات API
    # ==========================================
    OPENWEATHERMAP_API_KEY = os.environ.get("OPENWEATHERMAP_API_KEY", "")
    GITHUB_ACCESS_TOKEN = os.environ.get("GITHUB_ACCESS_TOKEN", "")
    
    # ==========================================
    # 🗄️ قاعدة البيانات
    # ==========================================
    DB_URI = os.environ.get("DATABASE_URL", None)
    REDIS_URI = os.environ.get("REDIS_URI", None)
    
    print("[INFO] ✅ تم تحميل Config من iqthon_config.py")


# ==========================================
# 🔄 دعم الاستيراد من sample_config و config.py
# ==========================================
# هذا يسمح للكود القديم باستيراد Config من sample_config
# عن طريق إضافة Config إلى sys.modules

import sys
sys.modules['sample_config'] = sys.modules[__name__]
