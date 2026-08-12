# استيرادات أساسية لا تسبب أخطاء
from . import fonts
from . import memeshelper as catmemes
from .aiohttp_helper import AioHttp
from .utils import *

# قاموس لتخزين الموديولات المحملة كسلاً
_lazy_modules = {}
_lazy_loaded = False


def _ensure_imports():
    """تحميل جميع الموديولات باستثناء chatbot بشكل آمن"""
    global _lazy_loaded

    if _lazy_loaded:
        return True

    modules_to_import = [
        ('functions', 'from .functions import *'),
        ('memeifyhelpers', 'from .memeifyhelpers import *'),
        ('progress', 'from .progress import *'),
        ('qhelper', 'from .qhelper import process'),
        ('tools', 'from .tools import *'),
        ('utils_ext', 'from .utils import _cattools, _catutils, _format')
    ]

    for module_name, import_statement in modules_to_import:
        try:
            exec(import_statement, globals())
            _lazy_modules[module_name] = True
        except ModuleNotFoundError as e:
            try:
                # محاولة التثبيت (قد تفشل في Render)
                install_pip(e.name)
                exec(import_statement, globals())
                _lazy_modules[module_name] = True
            except Exception as ex:
                print(f"[WARNING] Failed to import {module_name}: {ex}")
                _lazy_modules[module_name] = False

    _lazy_loaded = True
    return True


# تحميل الموديولات الأساسية فوراً
_ensure_imports()


# دالة لتحميل chatbot عند الحاجة فقط
def get_chatbot():
    """استيراد chatbot بشكل كسول (عند أول استخدام)"""
    if 'chatbot' not in _lazy_modules:
        try:
            from .chatbot import get_rs_client
            _lazy_modules['chatbot'] = {
                'get_rs_client': get_rs_client,
            }
        except ModuleNotFoundError as e:
            print(f"[WARNING] Chatbot not available: {e}")
            _lazy_modules['chatbot'] = None
        except Exception as ex:
            print(f"[ERROR] Failed to load chatbot: {ex}")
            _lazy_modules['chatbot'] = None

    return _lazy_modules.get('chatbot')


def __getattr__(name):
    """خاصية Python للتعامل مع الاستيرادات المفقودة ديناميكياً"""
    if name in ['get_rs_client', 'chat_with_ai', 'get_random_stuff']:
        chatbot = get_chatbot()
        if chatbot and name in chatbot:
            return chatbot[name]
    raise AttributeError(f"module '{__name__}' has no attribute '{name}'")


# تصدير الدوال الرئيسية
__all__ = [
    'fonts',
    'catmemes',
    'AioHttp',
    'get_rs_client',
    'get_chatbot'
]
