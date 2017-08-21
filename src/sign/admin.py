from django.contrib import admin
from sign.models import *

'''
后台管理用户/用户组
'''
# 在后台显示
class EventAdmin(admin.ModelAdmin):
    list_display = ['name', 'status', 'start_time','id']
    search_fields = ['name']    # 搜索功能
    list_filter = ['status']    # 过滤器

# 在后台显示
class GuestAdmin(admin.ModelAdmin):
    list_display = ['realname', 'phone','email','sign','create_time','event_id']
    list_display_links = ('realname', 'phone') # 显示链接
    search_fields = ['realname','phone']       # 搜索功能
    list_filter = ['event_id']                 # 过滤器

class VersionAdmin(admin.ModelAdmin):
    list_display = ['productName', 'versionID', 'versionName','tdesc']
    search_fields = ['versionID']    # 搜索功能
    list_filter = ['versionID']    # 过滤器 是什么？？？

class ResultAdmin(admin.ModelAdmin):
    list_display = ['productName', 'versionID', 'networkType']
    search_fields = ['versionID']    # 搜索功能
    list_filter = ['networkType']    # 过滤器 是什么？？？

admin.site.register(Event, EventAdmin)
admin.site.register(Guest, GuestAdmin)
admin.site.register(Version, VersionAdmin)
admin.site.register(Result, ResultAdmin)
