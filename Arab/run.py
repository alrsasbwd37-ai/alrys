# run.py
import asyncio
import sys
import os

# إصلاح مشكلة event loop قبل أي استيراد
try:
    asyncio.get_running_loop()
except RuntimeError:
    asyncio.set_event_loop(asyncio.new_event_loop())

# الآن استورد المشروع
try:
    from Arab import Arab
except ImportError:
    # إذا فشل الاستيراد، حاول تشغيل الملف الرئيسي مباشرة
    import runpy
    runpy.run_module('Arab', run_name='__main__')
