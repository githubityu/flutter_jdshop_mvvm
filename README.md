# 大地京东商城 Flutter 版

##  screen shot for iOS

![IMG_0703](https://img-blog.csdnimg.cn/20200325230359296.gif)

![IMG_0704](https://github.com/githubityu/flutter_jdshop_mvvm/blob/master/1585319654(1).png)

![IMG_0705](https://github.com/qpc2015/flutter_shop/blob/master/screenshot/003.png)


## Setup

1. **Clone the repo**

```
$ git clone https://github.com/githubityu/flutter_jdshop_mvvm.git
$ cd flutter_jdshop_mvvm
```

2. **Running:**

```
$ flutter run
```




## 简介

这是一个用Flutter写的简易商城APP

###  武功太差，努力练习，减少代码的重复和便于维护
###  学好武功，迎娶白富美

* 该项目使用mvvm
* 自定义BasePageState 提取公共方法例如需要初始化的ScreenUtil,showToast,显示隐藏进度弹框，点击外部是否隐藏软键盘等
* 自定义BaseDialog 提醒弹框(例如确定要退出登陆吗)
* 自定义AppBar,CommonBackTopBar(可以设置左组件和点击事件默认返回图标返回事件，中间文字，右边组件右边点击默认为Container())
* 定义BaseResponse，统一处理返回结果，根据code做不同的处理。例如状态码是-1,，就跳转到登录页面
* 统一Button，方便后面使用
* 加载组件（加载中，加载成功，加载失败（点击重新加载））
* 自定义输入框(包含清除按钮，是否显示密码按钮，发送验证码按钮)，方便后面使用
* 封装LoadImage组件，可以加载本地资源或者网路图片
* 定义UserInfoData 存储用户信息,方便app使用获取用户相关信息
* 关闭指定页面或者关闭指定某些页面

### Demo文件夹下的功能
* Tab和滚动同步变化
* 扫描二维码功能测试
* Paint和Canvas学习
* Animation学习
* 软键盘监听
* Overlay悬浮层的使用 点击显示，点击外部隐藏
* Selector局部共享数据刷新使用
* localToGlobal的组件坐标和屏幕坐标的转换
* InheritedWidget组件的学习和使用（共享数据）
* 自定义checkbox的学习和使用




主要实现的功能有：
* 框架：App常用的Tab框架，UI根据screenutil按750*1334等比例适配；
* 首页：轮播图,滑动列表；
* 分类：两级列表；
* 购物车：购物车列表和结算订单；
* 我的：未登录/登录状态切换，用户注销,全部订单；
* 登录：获取验证码、用户登录、用户状态缓存；



## 第三方依赖

| 名称及版本                   |        作用        |
| ---------------------------- | :----------------: |
| flutter_swiper: ^1.1.6       |       轮播图       |
| flutter_screenutil: ^1.0.2   |      屏幕适配      |
| dio: ^3.0.9                  |      网络请求      |
| shared_preferences: ^0.5.6+3 |      本地储存      |
| webview_flutter: ^0.3.19+9   |  内置webview加载   |
| event_bus: ^1.1.1            |      事件传递      |
| provider: ^4.0.4             |      状态管理      |
| fluttertoast: ^3.1.3         |       提示框       |
| city_pickers: ^0.1.30        | 三级城市联动选择器 |
| crypto: ^2.1.3               |       加密库       |
| flutter_slidable: ^0.5.4     |       侧滑删除       |
| fluro: ^1.5.1                |       路由跳转       |
| flutter_statusbarcolor: ^0.2.3|设置状态栏文字图标颜色 |
| cached_network_image: ^2.0.0|      加载图片         |
| flutter_html: ^0.11.1       |      加载网页         |
| barcode_scan: any           |      识别二维码         |





## Contact

If you have any suggestions, leave a message here
[CSDN](https://blog.csdn.net/yujunlong3919)



## License

MIT

## 最后

如果你喜欢这个项目，欢迎给我一个star。里面可能还有许多需要修改的bug,欢迎大家提出来,我将持续更新这个项目)


## 感谢qpc2015 复制了README.md
[qpc2015](https://github.com/qpc2015/flutter_shop)


