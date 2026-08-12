# run.py
import os
import asyncio
import sys

# =====================================================
# ⚠️ IMPORTANT: استبدل هذه القيم بقيمك الحقيقية
# =====================================================

# الخيار 1: استخدام بوت تيليجرام (موصى به لـ Render)
os.environ["BOT_TOKEN"] = "your_bot_token_here"  # احصل عليه من @BotFather

# الخيار 2: استخدام حساب مستخدم (إذا لم يكن لديك بوت)
# os.environ["PHONE_NUMBER"] = "+201234567890"   # رقم هاتفك مع رمز الدولة
# os.environ["API_ID"] = "32419741"              # من my.telegram.org
# os.environ["API_HASH"] = "3b646239045f6be4d40498726b00b414"  # من my.telegram.org

# =====================================================

print("[INFO] جاري تهيئة البيئة...")

# إصلاح مشكلة event loop
try:
    asyncio.get_running_loop()
except RuntimeError:
    asyncio.set_event_loop(asyncio.new_event_loop())
    print("[INFO] تم إنشاء event loop جديد")

# التحقق من وجود المتغيرات المطلوبة
if os.environ.get("BOT_TOKEN"):
    print(f"[INFO] سيتم التشغيل باستخدام BOT_TOKEN")
elif os.environ.get("PHONE_NUMBER") and os.environ.get("API_ID") and os.environ.get("API_HASH"):
    print(f"[INFO] سيتم التشغيل باستخدام حساب المستخدم: {os.environ.get('PHONE_NUMBER')}")
else:
    print("[ERROR] لم يتم العثور على BOT_TOKEN أو بيانات المستخدم!")
    print("يرجى تعيين BOT_TOKEN أو (PHONE_NUMBER, API_ID, API_HASH)")
    sys.exit(1)

print("[INFO] جاري تشغيل Arab...")

# تشغيل المشروع
try:
    import runpy
    runpy.run_module('Arab', run_name='__main__')
except Exception as e:
    print(f"[ERROR] فشل التشغيل: {e}")
    sys.exit(1)
