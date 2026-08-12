FROM python:3.10-slim

RUN apt update && apt install -y git gcc libpq-dev

RUN git clone https://github.com/alrsasbwd37-ai/alrys.git /root/Arab

WORKDIR /root/Arab

# ===== التصحيح المباشر =====
RUN echo "🔧 Applying critical fixes..." && \
    printf '%s\n' \
    'from .utils.extdl import install_pip' \
    '' \
    'try:' \
    '    import randomstuff' \
    'except ModuleNotFoundError:' \
    '    install_pip("randomstuff")' \
    '    import randomstuff' \
    '' \
    'from ..Config import Config' \
    '' \
    '_rs_client = None' \
    '' \
    'async def get_rs_client():' \
    '    global _rs_client' \
    '    if _rs_client is None:' \
    '        try:' \
    '            _rs_client = randomstuff.AsyncClient(' \
    '                api_key=Config.RANDOM_STUFF_API_KEY,' \
    '                version="4",' \
    '                suppress_warnings=True' \
    '            )' \
    '        except Exception as e:' \
    '            print(f"[ERROR] Failed to initialize randomstuff client: {e}")' \
    '            _rs_client = None' \
    '    return _rs_client' \
    '' \
    'async def chat_with_ai(message):' \
    '    client = await get_rs_client()' \
    '    if client is None:' \
    '        return "عذراً، خدمة الذكاء الاصطناعي غير متوفرة حالياً."' \
    '    try:' \
    '        response = await client.get_ai_response(message)' \
    '        return response' \
    '    except Exception as e:' \
    '        return f"حدث خطأ: {e}"' \
    > /root/Arab/Arab/helpers/chatbot.py && \
    printf '%s\n' \
    'from . import fonts' \
    'from . import memeshelper as catmemes' \
    'from .aiohttp_helper import AioHttp' \
    'from .utils import *' \
    '' \
    'flag = True' \
    'check = 0' \
    'while flag:' \
    '    try:' \
    '        # from .chatbot import *' \
    '        from .functions import *' \
    '        from .memeifyhelpers import *' \
    '        from .progress import *' \
    '        from .qhelper import process' \
    '        from .tools import *' \
    '        from .utils import _cattools, _catutils, _format' \
    '        break' \
    '    except ModuleNotFoundError as e:' \
    '        install_pip(e.name)' \
    '        check += 1' \
    '        if check > 5:' \
    '            break' \
    '' \
    'def get_chatbot():' \
    '    from .chatbot import get_rs_client, chat_with_ai' \
    '    return {"get_rs_client": get_rs_client, "chat_with_ai": chat_with_ai}' \
    > /root/Arab/Arab/helpers/__init__.py && \
    echo "✅ Fixes applied successfully!"

RUN pip3 install --no-cache-dir -r requirements.txt

# ===== إنشاء run.py =====
RUN printf '%s\n' \
    'import os' \
    'import asyncio' \
    'import sys' \
    '' \
    'os.environ["SESSION_NAME"] = "arab_session"' \
    'os.environ["API_ID"] = "32419741"' \
    'os.environ["API_HASH"] = "3b646239045f6be4d40498726b00b414"' \
    'os.environ["BOT_TOKEN"] = "your_bot_token_here"' \
    '' \
    'print("[INFO] 🚀 جاري تهيئة البيئة...")' \
    '' \
    'try:' \
    '    asyncio.get_running_loop()' \
    'except RuntimeError:' \
    '    asyncio.set_event_loop(asyncio.new_event_loop())' \
    '    print("[INFO] تم إنشاء event loop جديد")' \
    '' \
    'BOT_TOKEN = os.environ.get("BOT_TOKEN")' \
    'SESSION_NAME = os.environ.get("SESSION_NAME")' \
    'API_ID = os.environ.get("API_ID")' \
    'API_HASH = os.environ.get("API_HASH")' \
    '' \
    'if BOT_TOKEN:' \
    '    print("[INFO] ✅ سيتم التشغيل باستخدام BOT_TOKEN")' \
    'elif SESSION_NAME and API_ID and API_HASH:' \
    '    print(f"[INFO] ✅ سيتم التشغيل باستخدام الجلسة: {SESSION_NAME}")' \
    'else:' \
    '    print("[ERROR] ❌ لم يتم العثور على BOT_TOKEN أو بيانات الجلسة!")' \
    '    sys.exit(1)' \
    '' \
    'print("[INFO] 🚀 جاري تشغيل Arab...")' \
    '' \
    'try:' \
    '    import runpy' \
    '    runpy.run_module("Arab", run_name="__main__")' \
    'except Exception as e:' \
    '    print(f"[ERROR] ❌ فشل التشغيل: {e}")' \
    '    sys.exit(1)' \
    > /root/Arab/run.py

ENV PATH="/home/Arab/bin:$PATH"

CMD ["python3", "/root/Arab/run.py"]
