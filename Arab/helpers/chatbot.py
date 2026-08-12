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
            version="4",
            suppress_warnings=True
        )

    return rs_client
