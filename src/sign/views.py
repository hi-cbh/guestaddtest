from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib import auth
from django.contrib.auth.decorators import login_required
from sign.models import Event, Guest, Version, Result
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.shortcuts import render, get_object_or_404
# Create your views here.

def index(request):
    return render(request, "index.html")

# 登录动作
def login_action(request):
    if request.method == 'POST':
        username=request.POST.get('username','')
        password=request.POST.get('password','')
        user = auth.authenticate(username=username, password=password)
        if user is not None:
            auth.login(request, user) # 登录
            request.session['user'] = username
            response =  HttpResponseRedirect('/event_manage/')
            #response.set_cookie('user', username, 3600) # 添加浏览器cookie
            return response
        else:
            return render(request, 'index.html', {'error':'username or pasword error!'})


# 发布会管理
@login_required
def event_manage(request):
    username = request.session.get('user','')  # 读取浏览器session
    event_list=Event.objects.all()
    #username = request.COOKIES.get('user','')  # 读取浏览器cookie
    return render(request, "event_manage.html",{"user":username,"events":event_list})

# 发布会名称搜索
@login_required
def search_name(request):
    username = request.session.get('user', '')
    search_name = request.GET.get("name", "")
    event_list = Event.objects.filter(name__contains=search_name)
    return render(request, "event_manage.html",{"user":username,"events":event_list})

# 嘉宾管理
@login_required
def guest_manage(request):
    username = request.session.get('user','')  # 读取浏览器session
    guest_list=Guest.objects.all()
    paginator = Paginator(guest_list, 5)
    page = request.GET.get('page')
    try:
        contacts = paginator.page(page)
    except PageNotAnInteger:
        contacts = paginator.page(1)
    except EmptyPage:
        contacts = paginator.page(paginator.num_pages)
    #username = request.COOKIES.get('user','')  # 读取浏览器cookie
    return render(request, "guest_manage.html",{"user":username,"guests":contacts})

# 签到页面
@login_required
def sign_index(request,eid):
    event = get_object_or_404(Event, id=eid)
    return render(request, "sign_index.html",{"event":event})

# 签到页面
@login_required
def sign_index_action(request, eid):
    event = get_object_or_404(Event, id=eid)
    phone = request.POST.get('phone','')
    print(phone)
    result = Guest.objects.filter(phone=phone)
    if not result:
        return render(request, 'sign_index.html', {'event': event, 'hint': 'phone error.'})

    result = Guest.objects.filter(phone=phone, event_id = eid)
    if not result:
        return render(request, 'sign_index.html', {'event': event, 'hint': 'event id or phone error.'})
    
    result = Guest.objects.get(phone=phone, event_id=eid)
    if result.sign:
        return render(request, 'sign_index.html', {'event': event, 'hint': 'user has sign in.'})
        
    else:
        Guest.objects.filter(phone=phone, event_id=eid).update(sign='1')
        return render(request, "sign_index.html",{"event":event, 'hint': 'sign in success!', 'guest':result})

# 退出
@login_required
def logout(request):
    auth.logout(request)
    response = HttpResponseRedirect('/index/')
    return response


# 嘉宾手机号的查询
@login_required
def search_phone(request):
    username = request.session.get('username', '')
    search_phone = request.GET.get("phone", "")
    search_name_bytes = search_phone.encode(encoding="utf-8")
    guest_list = Guest.objects.filter(phone__contains=search_name_bytes)
    username = request.session.get('username', '')

    paginator = Paginator(guest_list, 10)
    page = request.GET.get('page')
    try:
        contacts = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        contacts = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        contacts = paginator.page(paginator.num_pages)

    return render(request, "guest_manage.html", {"user": username, "guests": contacts})


def page_not_found(request):
    return render(request,'404.html')

# 版本信息
@login_required
def version_manage(request):
    username = request.session.get('user','')  # 读取浏览器session
    version_list=Version.objects.all()
    print(version_list)
    #username = request.COOKIES.get('user','')  # 读取浏览器cookie
    return render(request, "version_manage.html",{"user":username,"versions":version_list})

# 测试结果汇总
@login_required
def result_manage(request):
    username = request.session.get('user','')  # 读取浏览器session
    result_list=Result.objects.all()
    print(result_list)
    #username = request.COOKIES.get('user','')  # 读取浏览器cookie
    return render(request, "result_manage.html",{"user":username,"results":result_list})

@login_required
def search_version(request):
    username = request.session.get('user', '')
    search_version = request.GET.get("versionID", "")
    version_list = Version.objects.filter(versionID__contains=search_version)
    print(version_list)
    return render(request, "version_manage.html",{"user":username,"versions":version_list})

# 嘉宾手机号的查询
@login_required
def search_result(request):
    username = request.session.get('username', '')
    search_result = request.GET.get("versionID", "")
    search_name_bytes = search_result.encode(encoding="utf-8")
    result_list = Result.objects.filter(versionID__contains=search_name_bytes)
    username = request.session.get('username', '')

#     username = request.session.get('username', '')
#     keyword = request.GET.get("versionID", "")
#     print('keyword %s' %keyword)
#     all = Result.objects.all()
#     print(all)
#     result_list = []
#     for x in all:
#         if keyword in x:
#             result_list.append(x)
    
    paginator = Paginator(result_list, 10)
    page = request.GET.get('page')
    try:
        contacts = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        contacts = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        contacts = paginator.page(paginator.num_pages)

    return render(request, "result_manage.html", {"user": username, "results": contacts})
