# run.py - النسخة النهائية
import os
import asyncio
import sys

# إضافة مسار المشروع
sys.path.insert(0, "/root/Arab")

# ==========================================
# 🤖 بيانات البوت (ضع قيمك الحقيقية)
# ==========================================
os.environ["BOT_TOKEN"] = "your_bot_token_here"
os.environ["API_ID"] = "32419741"
os.environ["API_HASH"] = "3b646239045f6be4d40498726b00b414"
os.environ["SESSION_NAME"] = "arab_session"
# ==========================================

print("[INFO] 🚀 جاري تهيئة البيئة...")

# إصلاح event loop
try:
    asyncio.get_running_loop()
except RuntimeError:
    asyncio.set_event_loop(asyncio.new_event_loop())
    print("[INFO] تم إنشاء event loop جديد")

# التحقق من المتغيرات
BOT_TOKEN = os.environ.get("BOT_TOKEN")
SESSION_NAME = os.environ.get("SESSION_NAME")
API_ID = os.environ.get("API_ID")
API_HASH = os.environ.get("API_HASH")

if BOT_TOKEN:
    print(f"[INFO] ✅ سيتم التشغيل باستخدام BOT_TOKEN")
elif SESSION_NAME and API_ID and API_HASH:
    print(f"[INFO] ✅ سيتم التشغيل باستخدام الجلسة: {SESSION_NAME}")
else:
    print("[ERROR] ❌ لم يتم العثور على BOT_TOKEN أو بيانات الجلسة!")
    sys.exit(1)

# ==========================================
# 🔧 إنشاء Config مباشرة وتجاوز استيراد المشروع
# ==========================================
class Config:
    BOT_TOKEN = os.environ.get("BOT_TOKEN", "")
    SESSION_NAME = os.environ.get("SESSION_NAME", "")
    API_ID = int(os.environ.get("API_ID", 0))
    API_HASH = os.environ.get("API_HASH", "")
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

# ==========================================
# 📦 حقن Config في مسارات الاستيراد المختلفة
# ==========================================
import importlib
import types

# 1. تعيين Config في وحدة Arab
import Arab
Arab.Config = Config

# 2. تعيين في sys.modules لجميع المسارات الممكنة
sys.modules['Arab.Config'] = Config
sys.modules['Arab.Config.iqthon_config'] = Config
sys.modules['sample_config'] = Config
sys.modules['config'] = Config

# 3. إنشاء وحدة وهمية للـ Config
config_module = types.ModuleType('Arab.Config')
config_module.Config = Config
sys.modules['Arab.Config'] = config_module

print("[INFO] ✅ تم إنشاء Config وتجاوز الاستيراد بنجاح")
print("[INFO] 🚀 جاري تشغيل Arab...")

try:
    import runpy
    runpy.run_module("Arab", run_name="__main__")
except Exception as e:
    print(f"[ERROR] ❌ فشل التشغيل: {e}")
    import traceback
    traceback.print_exc()
    sys.exit(1)
