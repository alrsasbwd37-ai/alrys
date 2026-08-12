# iqthon_config.py
import os

class Config:
    # ==========================================
    # 🤖 بيانات البوت
    # ==========================================
    BOT_TOKEN = os.environ.get("BOT_TOKEN", "")
    
    # ==========================================
    # 📁 بيانات الجلسة (لليوزربوت)
    # ==========================================
    SESSION_NAME = os.environ.get("SESSION_NAME", "")
    API_ID = int(os.environ.get("API_ID", 0))
    API_HASH = os.environ.get("API_HASH", "")
    
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
