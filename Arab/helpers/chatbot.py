from .utils.extdl import install_pip

try:
    import randomstuff
except ModuleNotFoundError:
    install_pip("randomstuff.py")
    import randomstuff

from ..Config import Config

rs_client = None


async def get_rs_client():
    global rs_client

    if rs_client is None:
        rs_client = randomstuff.AsyncClient(
            api_key=Config.RANDOM_STUFF_API_KEY,
            version="4"
        )

    return rs_client


async def ask_randomstuff(message):
    client = await get_rs_client()

    try:
        response = await client.get_ai_response(message)
        return response
    except Exception:
        return None
