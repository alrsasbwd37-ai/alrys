cat > /root/Arab/run.py << 'EOF'
import os
import asyncio
import sys

# إضافة مسار المشروع
sys.path.insert(0, "/root/Arab")

# ==========================================
# 🤖 بيانات البوت
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
if os.environ.get("BOT_TOKEN"):
    print("[INFO] ✅ سيتم التشغيل باستخدام BOT_TOKEN")
else:
    print("[ERROR] ❌ BOT_TOKEN غير موجود!")
    sys.exit(1)

print("[INFO] 🚀 جاري تشغيل Arab...")

try:
    import runpy
    runpy.run_module("Arab", run_name="__main__")
except Exception as e:
    print(f"[ERROR] ❌ فشل التشغيل: {e}")
    sys.exit(1)
EOF
