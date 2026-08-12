import os
import sys
import asyncio

sys.path.insert(0, "/root/Arab")

print("🚀 تشغيل Arab...")

# إصلاح event loop
try:
    asyncio.get_running_loop()
except RuntimeError:
    asyncio.set_event_loop(asyncio.new_event_loop())

if not os.environ.get("BOT_TOKEN") and not os.environ.get("STRING_SESSION"):
    print("❌ لا يوجد BOT_TOKEN أو STRING_SESSION")
    sys.exit(1)

async def main():
    try:
        from Arab import bot
        from Arab.core.session import start_bot
        
        # بدء التشغيل
        client = await start_bot()
        print("✅ تم تشغيل البوت والاتصال بنجاح")
        
        # الانتظار حتى الانقطاع
        await client.run_until_disconnected()
    except Exception as e:
        print(f"❌ خطأ في التشغيل: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    asyncio.run(main())
