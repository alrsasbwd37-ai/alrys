# run.py
import os
import asyncio
import sys

# ==========================================
# 🤖 بيانات البوت
# ==========================================
os.environ["BOT_TOKEN"] = "your_bot_token_here"  # ضع التوكن الحقيقي
os.environ["API_ID"] = "32419741"
os.environ["API_HASH"] = "3b646239045f6be4d40498726b00b414"
os.environ["SESSION_NAME"] = "arab_session"

# إضافة مسار المشروع إلى sys.path
sys.path.insert(0, '/root/Arab')
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

print("[INFO] 🚀 جاري تشغيل Arab...")

try:
    # محاولة استيراد Config مباشرة
    from Arab.Config.iqthon_config import Config
    print("[INFO] ✅ تم استيراد Config بنجاح")
except ImportError as e:
    print(f"[WARNING] ❌ فشل استيراد Config: {e}")
    # محاولة بديلة
    try:
        from Arab.Config import Config
        print("[INFO] ✅ تم استيراد Config من المسار البديل")
    except ImportError:
        print("[ERROR] ❌ لا يمكن العثور على Config")
        sys.exit(1)

# تشغيل المشروع
try:
    import runpy
    runpy.run_module('Arab', run_name='__main__')
except Exception as e:
    print(f"[ERROR] ❌ فشل التشغيل: {e}")
    sys.exit(1)
