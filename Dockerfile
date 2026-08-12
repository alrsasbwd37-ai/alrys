FROM python:3.10-slim

RUN apt update && apt install -y git gcc libpq-dev

RUN git clone https://github.com/alrsasbwd37-ai/alrys.git /root/Arab

WORKDIR /root/Arab

# ===== التصحيح المباشر باستخدام printf =====
RUN echo "🔧 Applying critical fixes..." && \
    # 1. إصلاح chatbot.py
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
    # 2. إصلاح __init__.py
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
    '        # from .chatbot import *  # تم التعليق' \
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

# تثبيت المتطلبات
RUN pip3 install --no-cache-dir -r requirements.txt

ENV PATH="/home/Arab/bin:$PATH"

CMD ["python3","-m","Arab"]
