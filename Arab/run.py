import os
import sys
import asyncio

sys.path.insert(0, "/root/Arab")

print("🚀 تشغيل Arab...")

try:
    asyncio.get_running_loop()
except RuntimeError:
    asyncio.set_event_loop(asyncio.new_event_loop())

if not os.environ.get("BOT_TOKEN") and not os.environ.get("STRING_SESSION"):
    print("❌ لا يوجد BOT_TOKEN أو STRING_SESSION")
    sys.exit(1)

try:
    from Arab import bot
    print("✅ تم تحميل Arab")
except Exception:
    import traceback
    traceback.print_exc()
    sys.exit(1)

try:
    bot.run_until_disconnected()
except Exception:
    import traceback
    traceback.print_exc()
    sys.exit(1)
