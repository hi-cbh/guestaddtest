from django.db import models


# Create your models here.
# 发布会
class Event(models.Model):
    name = models.CharField(max_length=100)            # 发布会标题
    limit = models.IntegerField()                      # 限制人数
    status = models.BooleanField()                     # 状态
    address = models.CharField(max_length=200)         # 地址
    start_time = models.DateTimeField('events time')   # 发布会时间
    create_time = models.DateTimeField(auto_now=True)  # 创建时间（自动获取当前时间）

    def __str__(self):
        return self.name


# 嘉宾
class Guest(models.Model):
    event = models.ForeignKey(Event)            # 关联发布会id
    realname = models.CharField(max_length=64)  # 姓名
    phone = models.CharField(max_length=16)     # 手机号
    email = models.EmailField()                 # 邮箱
    sign = models.BooleanField()                # 签到状态
    create_time = models.DateTimeField(auto_now=True)  # 创建时间（自动获取当前时间）

    class Meta:
        unique_together = ('phone', 'event') # 把两个字段设成primary key

    def __str__(self):
        return self.realname

# 版本情况
class Version(models.Model):
    productName = models.CharField(max_length=64)  # 姓名
    versionID =  models.IntegerField()             # 版本号
    versionName = models.CharField(max_length=64)  # 姓名
    tdesc  = models.CharField(max_length=64)       # 版本描述
    
    def __str__(self):
        return self.productName
    
# 版本测试结果
class Result(models.Model):     
    productName = models.CharField(max_length=64)  # 姓名
    versionID =  models.IntegerField()            # 版本号
    networkType =  models.CharField(max_length=10)           # 网络状态
#     times =  models.IntegerField()                                 # 测试轮次
    logintime =  models.DecimalField(max_digits=10,decimal_places = 2)             # 登录时延
    receivetime =  models.DecimalField(max_digits=10,decimal_places = 2)           # 接收本域邮件
    readtime =  models.DecimalField(max_digits=10,decimal_places = 2)              # 打开未读邮件
    downtime =  models.DecimalField(max_digits=10,decimal_places = 2)              # 下载附件
    sendtime =  models.DecimalField(max_digits=10,decimal_places = 2)              # 发送邮件
    loginflow =  models.DecimalField(max_digits=10,decimal_places = 2)             # 首次登录流量
    brushflow =  models.DecimalField(max_digits=10,decimal_places = 2)             # 空刷流量
    standynoelectric =  models.DecimalField(max_digits=10,decimal_places = 2)      # 待机无邮件电量
    standynoflow =  models.DecimalField(max_digits=10,decimal_places = 2)          # 待机无邮件流量
    standyelectric =  models.DecimalField(max_digits=10,decimal_places = 2)        # 待机有邮件电量
    standyflow =  models.DecimalField(max_digits=10,decimal_places = 2)            # 待机有邮件流量
    maxmem =  models.DecimalField(max_digits=10,decimal_places = 2)                # 内存峰值
    maxcpu =  models.DecimalField(max_digits=10,decimal_places = 2)                # CPU峰值
    avgmem =  models.DecimalField(max_digits=10,decimal_places = 2)                # 待机内存
    avgtime =  models.DecimalField(max_digits=10,decimal_places = 2)              # 杀进程启动

    def __str__(self):
        return str(self.versionID)
     
# 所有测试结果
class TestValue(models.Model):     
    productName = models.CharField(max_length=64)  # 姓名
    versionID =  models.IntegerField()             # 版本号
    networkType =  models.CharField(max_length=10)           # 网络状态
#     times =  models.IntegerField()                                   # 测试轮次
    logintime =  models.DecimalField(max_digits=10,decimal_places = 2)             # 登录时延
    receivetime =  models.DecimalField(max_digits=10,decimal_places = 2)           # 接收本域邮件
    readtime =  models.DecimalField(max_digits=10,decimal_places = 2)              # 打开未读邮件
    downtime =  models.DecimalField(max_digits=10,decimal_places = 2)              # 下载附件
    sendtime =  models.DecimalField(max_digits=10,decimal_places = 2)              # 发送邮件
    loginflow =  models.DecimalField(max_digits=10,decimal_places = 2)             # 首次登录流量
    brushflow =  models.DecimalField(max_digits=10,decimal_places = 2)             # 空刷流量
    standynoelectric =  models.DecimalField(max_digits=10,decimal_places = 2)      # 待机无邮件电量
    standynoflow =  models.DecimalField(max_digits=10,decimal_places = 2)          # 待机无邮件流量
    standyelectric =  models.DecimalField(max_digits=10,decimal_places = 2)        # 待机有邮件电量
    standyflow =  models.DecimalField(max_digits=10,decimal_places = 2)            # 待机有邮件流量
    maxmem =  models.DecimalField(max_digits=10,decimal_places = 2)                # 内存峰值
    maxcpu =  models.DecimalField(max_digits=10,decimal_places = 2)                # CPU峰值
    avgmem =  models.DecimalField(max_digits=10,decimal_places = 2)                # 待机内存
    avgtime =  models.DecimalField(max_digits=10,decimal_places = 2)              # 杀进程启动
#     mailcount = models.IntegerField()                                 # 接收邮件数量

    def __str__(self):
        return str(self.versionID)
    
# 修改创建时间类型
# ALTER TABLE  `sign_event` CHANGE  `create_time`  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
# ALTER TABLE  `sign_guest` CHANGE  `create_time`  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

  