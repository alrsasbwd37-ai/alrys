import os
import sys
import asyncio
import threading
from http.server import HTTPServer, BaseHTTPRequestHandler

sys.path.insert(0, "/root/Arab")

print("🚀 تشغيل Arab...")

# ===== خادم ويب بسيط لإبقاء المنفذ مفتوحاً =====
class DummyHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Bot is running")
    
    def log_message(self, format, *args):
        pass  # منع الـ logs المزعجة

def start_web_server():
    port = int(os.environ.get("PORT", 10000))
    server = HTTPServer(('0.0.0.0', port), DummyHandler)
    print(f"[INFO] ✅ خادم الويب يعمل على المنفذ {port}")
    server.serve_forever()

# تشغيل الخادم في خلفية منفصلة
threading.Thread(target=start_web_server, daemon=True).start()
# =============================================

# إصلاح event loop
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
