from .utils.extdl import install_pip

try:
    import randomstuff
except ModuleNotFoundError:
    install_pip("randomstuff")
    import randomstuff

from ..Config import Config

_rs_client = None


async def get_rs_client():
    global _rs_client

    if _rs_client is None:
        try:
            _rs_client = randomstuff.AsyncClient(
                api_key=Config.RANDOM_STUFF_API_KEY,
                version="4",
                suppress_warnings=True
            )
        except Exception as e:
            print(f"[ERROR] Failed to initialize randomstuff client: {e}")
            _rs_client = None

    return _rs_client


# دوال مساعدة إضافية (اختيارية)
async def chat_with_ai(message):
    """دالة للدردشة مع الذكاء الاصطناعي"""
    client = await get_rs_client()
    if client is None:
        return "عذراً، خدمة الذكاء الاصطناعي غير متوفرة حالياً."

    try:
        response = await client.get_ai_response(message)
        return response
    except Exception as e:
        return f"حدث خطأ: {e}"


async def get_random_stuff():
    """الحصول على محتوى عشوائي"""
    client = await get_rs_client()
    if client is None:
        return None

    try:
        return await client.get_random()
    except Exception as e:
        print(f"[ERROR] Random stuff error: {e}")
        return None
