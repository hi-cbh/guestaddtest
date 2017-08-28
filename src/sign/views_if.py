from django.http import JsonResponse
from sign.models import Event, Guest
from django.core.exceptions import ValidationError, ObjectDoesNotExist
from django.db.utils import IntegrityError
import time


# 添加发布会接口
def add_event(request):
    eid = request.POST.get('eid','')                 # 发布会id
    name = request.POST.get('name','')               # 发布会标题
    limit = request.POST.get('limit','')             # 限制人数
    status = request.POST.get('status','')           # 状态
    address = request.POST.get('address','')         # 地址
    start_time = request.POST.get('start_time','')   # 发布会时间

    #  如果获取的参数其中一个为空，返回10021错误，参数错误
    if eid =='' or name == '' or limit == '' or address == '' or start_time == '':
        return JsonResponse({'status':10021,'message':'parameter error'})
    
    # 搜索eid，如果结果不为空，返回id已经存在
    result = Event.objects.filter(id=eid)
    if result:
        return JsonResponse({'status':10022,'message':'event id already exists'})
    
    # 搜索name ，如果结果不为空，返回name已经存在
    result = Event.objects.filter(name=name)
    if result:
        return JsonResponse({'status':10023,'message':'event name already exists'})

    if status == '':
        status = 1

    try:
        # 创建数据
        Event.objects.create(id=eid,name=name,limit=limit,address=address,status=int(status),start_time=start_time)
    except ValidationError:
        # 如果创建失败，返回日期格式错误
        error = 'start_time format error. It must be in YYYY-MM-DD HH:MM:SS format.'
        return JsonResponse({'status':10024,'message':error})
    # 创建数据成功
    return JsonResponse({'status':200,'message':'add event success'})


# 添加嘉宾接口
def add_guest(request):
    eid =  request.POST.get('eid','')                # 关联发布会id
    realname = request.POST.get('realname','')       # 姓名
    phone = request.POST.get('phone','')             # 手机号
    email = request.POST.get('email','')             # 邮箱
    
    # 其中一个参数为空，返回参数错误
    if eid =='' or realname == '' or phone == '':
        return JsonResponse({'status':10021,'message':'parameter error'})

    # 过滤eid，如果返回空值，eventid 为null
    result = Event.objects.filter(id=eid)
    if not result:
        return JsonResponse({'status':10022,'message':'event id null'})
    
    # 过滤id的状态，如果event.status是否为空
    result = Event.objects.get(id=eid).status
    if not result:
        return JsonResponse({'status':10023,'message':'event status is not available'})
    
    # 获取对应id的人数限制
    event_limit = Event.objects.get(id=eid).limit        # 发布会限制人数
    # 返回筛选条数
    guest_limit = Guest.objects.filter(event_id=eid)     # 发布会已添加的嘉宾数
    
    # 人数已经达到最大值
    if len(guest_limit) >= event_limit:
        return JsonResponse({'status':10024,'message':'event number is full'})
    
    # 获取开始时间
    event_time = Event.objects.get(id=eid).start_time     # 发布会时间
    # 将时间格式化
    timeArray = time.strptime(str(event_time), "%Y-%m-%d %H:%M:%S")
    # 把时间转为int类型
    e_time = int(time.mktime(timeArray))
    
    # 获取当前时间，
    now_time = str(time.time())          # 当前时间
    # 获取小说点前面的值
    ntime = now_time.split(".")[0]
    # 转为
    n_time = int(ntime)
    
    # 对比时间
    if n_time >= e_time:
        return JsonResponse({'status':10025,'message':'event has started'})

    try:
        # 创建数据
        Guest.objects.create(realname=realname,phone=int(phone),email=email,sign=0,event_id=int(eid))
    except IntegrityError:
        # 如果phone重复了，返回number repeat
        return JsonResponse({'status':10026,'message':'the event guest phone number repeat'})
    
    # 返回添加数据成功
    return JsonResponse({'status':200,'message':'add guest success'})


# 发布会查询
def get_event_list(request):

    eid = request.GET.get("eid", "")      # 发布会id
    name = request.GET.get("name", "")    # 发布会名称

    # 如果参数为空，提示参数错误
    if eid == '' and name == '':
        return JsonResponse({'status':10021,'message':'parameter error'})

    if eid != '':
        event = {}
        try:
            # 获取结果是否错误，结果为空，报错
            result = Event.objects.get(id=eid)
        except ObjectDoesNotExist:
            return JsonResponse({'status':10022, 'message':'query result is empty'})
        else:
            # 运行正常，执行
            event['eid'] = result.id
            event['name'] = result.name
            event['limit'] = result.limit
            event['status'] = result.status
            event['address'] = result.address
            event['start_time'] = result.start_time
            return JsonResponse({'status':200, 'message':'success', 'data':event})

    if name != '':
        datas = []
        results = Event.objects.filter(name__contains=name)
        if results:
            for r in results:
                event = {}
                event['eid'] = r.id
                event['name'] = r.name
                event['limit'] = r.limit
                event['status'] = r.status
                event['address'] = r.address
                event['start_time'] = r.start_time
                # 添加到列表中，多个event
                datas.append(event)
            return JsonResponse({'status':200, 'message':'success', 'data':datas})
        else:
            return JsonResponse({'status':10022, 'message':'query result is empty'})


# 嘉宾查询接口
def get_guest_list(request):
    eid = request.GET.get("eid", "")       # 关联发布会id
    phone = request.GET.get("phone", "")   # 嘉宾手机号

    # 如果ID为空，返回错误吗
    if eid == '':
        return JsonResponse({'status':10021,'message':'eid cannot be empty'})
    
    # 如果号码为空
    if eid != '' and phone == '':
        datas = []
        results = Guest.objects.filter(event_id=eid)
        if results:
            for r in results:
                guest = {}
                guest['realname'] = r.realname
                guest['phone'] = r.phone
                guest['email'] = r.email
                guest['sign'] = r.sign
                datas.append(guest)
            return JsonResponse({'status':200, 'message':'success', 'data':datas})
        else:
            return JsonResponse({'status':10022, 'message':'query result is empty'})

    # 如果都不为空
    if eid != '' and phone != '':
        guest = {}
        try:
            result = Guest.objects.get(phone=phone,event_id=eid)
        except ObjectDoesNotExist:
            return JsonResponse({'status':10022, 'message':'query result is empty'})
        else:
            guest['realname'] = result.realname
            guest['phone'] = result.phone
            guest['email'] = result.email
            guest['sign'] = result.sign
            return JsonResponse({'status':200, 'message':'success', 'data':guest})


# 用户签到接口
def user_sign(request):
    eid =  request.POST.get('eid','')       # 发布会id
    phone =  request.POST.get('phone','')   # 嘉宾手机号

    if eid =='' or phone == '':
        return JsonResponse({'status':10021,'message':'parameter error'})

    result = Event.objects.filter(id=eid)
    if not result:
        return JsonResponse({'status':10022,'message':'event id null'})

    result = Event.objects.get(id=eid).status
    if not result:
        return JsonResponse({'status':10023,'message':'event status is not available'})

    event_time = Event.objects.get(id=eid).start_time     # 发布会时间
    timeArray = time.strptime(str(event_time), "%Y-%m-%d %H:%M:%S")
    e_time = int(time.mktime(timeArray))

    now_time = str(time.time())          # 当前时间
    ntime = now_time.split(".")[0]
    n_time = int(ntime)

    if n_time >= e_time:
        return JsonResponse({'status':10024,'message':'event has started'})

    result = Guest.objects.filter(phone=phone)
    if not result:
        return JsonResponse({'status':10025,'message':'user phone null'})

    result = Guest.objects.filter(phone=phone,event_id=eid)
    if not result:
        return JsonResponse({'status':10026,'message':'user did not participate in the conference'})

    result = Guest.objects.get(event_id=eid,phone=phone).sign
    if result:
        return JsonResponse({'status':10027,'message':'user has sign in'})
    else:
        Guest.objects.filter(phone=phone).update(sign='1')
        return JsonResponse({'status':200,'message':'sign success'})
