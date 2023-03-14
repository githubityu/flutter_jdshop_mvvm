import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



//https://service.xizhihk.com/api/post/recommend_list?cv=CAMP3.19.00_WXAPP&lc=CAMP_MINIAPP_1001
@immutable
class Constants {
  static const String rootUrl = 'https://wxs.hgphp.com/camp_api/';
  static const String rootUrl2 = 'https://h5.xizhihk.com/';
  static const String endpoint = '${rootUrl}api/';
  static const String newsUrl = '${endpoint}homepage/newsShow&id=';
  static const String sysResultUrl ='${endpoint}tracesource/code_tracepro&my_lot_number=';

  static String dummyProfilePic =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6TaCLCqU4K0ieF27ayjl51NmitWaJAh_X0r1rLX4gMvOe0MDaYw&s';
  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';
  static const String addPic = 'addPic';

  static const String FGF = '<####>';
  static const String KEY_ADDRESS = 'address';
  static const String KEY_LIST = 'account';
  static const String keyGuide = 'keyGuide';
  static const String phone = 'phone';

  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

  static const String theme = 'AppTheme';
  static const String noSign = 'TA还什么都没有留下~';
  static const String themeBg = 'https://t7.baidu.com/it/u=2621658848,3952322712&fm=193&f=GIF';

  static const String locale = 'locale';
  static const String appTheme = 'appTheme';
  static const int PAGE_START = 1;
  static const int PAGE_SIZE = 10;
  static const bool isCenterTitle = true;
  static const picUrl =
      'https://imagescale.xizhihk.com/imageproxy2/dimgm/scaleImage?url=http%3A%2F%2Fimg.xizhihk.com%2FMTY2MDg4NTA3NzA0NiMxMTgjanBn.jpg&w=364&h=486&c=1&o=0&t=0&m=1&auto-orient=1';
 static const picUrl2 ='https://imagescale.xizhihk.com/imageproxy2/dimgm/scaleImage?url=http%3A%2F%2Fimg.xizhihk.com%2FMTY2MDg4NTEyMjY0NyM0MDkjanBn.jpg&w=0&h=0&c=1&o=0&t=0&m=1&auto-orient=1';
  static const picUrl3 ='https://imagescale.xizhihk.com/imageproxy2/dimgm/scaleImage?url=http%3A%2F%2Fimg.xizhihk.com%2FMTY2MDg4NTQyOTU3MyM5MzkjanBn.jpg&w=0&h=0&c=1&o=0&t=0&m=1&auto-orient=1';
  static const picUrl4 ='https://imagescale.xizhihk.com/imageproxy2/dimgm/scaleImage?url=http%3A%2F%2Fimg.xizhihk.com%2FMTY2MDg4NTcwODM0MyM1NzkjanBn.jpg&w=0&h=0&c=1&o=0&t=0&m=1&auto-orient=1';


  static const userPic =
      'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic%2Feb%2F24%2Fd5%2Feb24d54a0c4e1f174a7a4922aaa28454.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1658048256&t=d76606c3ffb3a5cd84f5d07d44cb628f';


  static const String webUrl1 = 'https://imagescale.xizhihk.com/imageproxy2/dimgm/scaleImage?url=http%3A%2F%2Fimg.xizhihk.com%2FMTY2MDg4NTA3NzA0NiMxMTgjanBn.jpg&w=364&h=486&c=1&o=0&t=0&m=1&auto-orient=1';
  static const String webUrl2 = 'https://imagescale.xizhihk.com/imageproxy2/dimgm/scaleImage?url=http%3A%2F%2Fimg.xizhihk.com%2FMTYyMDg5OTcyMDI2NyM4MDYjanBn.jpg&w=120&h=120&c=1&o=0&t=0&m=1&auto-orient=1';
  static const String webUrl3 = 'http://106.38.204.135/file//d02305b0cb2946c4a545a4ceaecbdff2.obj';
  static const String webUrl4 = 'https://transient.ihggccampaign.com/ihgLTI/winter2022?utm_source=WeChatMP-Offe&utm_medium=Owned&utm_term=221122&utm_content=MP&utm_campaign=winter22&wechat_ui=RC_New&distinct_id=1672137832962-5643093-01ad432fffa8fa-14638870';


  static const  List<String> imgList = [
    picUrl,
    picUrl2,
    picUrl3,
    picUrl4,
    'http://yanxuan.nosdn.127.net/88dc5d80c6f84102f003ecd69c86e1cf.png',
    'http://yanxuan.nosdn.127.net/8b9328496990357033d4259fda250679.png',
    'http://yanxuan.nosdn.127.net/c39d54c06a71b4b61b6092a0d31f2335.png',
    'http://yanxuan.nosdn.127.net/ee92704f3b8323905b51fc647823e6e5.png',
    'http://yanxuan.nosdn.127.net/e564410546a11ddceb5a82bfce8da43d.png',
    'http://yanxuan.nosdn.127.net/56f4b4753392d27c0c2ccceeb579ed6f.png',
    'http://yanxuan.nosdn.127.net/6a54ccc389afb2459b163245bbb2c978.png',
    'https://picsum.photos/id/101/548/338'
  ];
  static const  List<String> videoList = [
    'http://media.xizhihk.com/MTY2NTM4NDQ3MTAxNCMxODQjbXA0.mp4',
    'http://media.xizhihk.com/MTY2NDg5MDcwNDg2OSM2MzMjbXA0.mp4',
    'http://media.xizhihk.com/MTY2MjI3MDA3MjU0MyMzODMjbXA0.mp4'
  ];

  static const  List<String> list = [
    '可自带帐篷',
    '可明火',
    '收费营地',
    '公共营地',
    '卫生局',
    '淋浴间',
    '可过夜',
    '可停营位旁',
    '可篝火',
    '拎包入住'
  ];


  static const  List<String> cityLeft = [
    '省份',
    '城市'
  ];

  static const  List<String> campConditionS = [
    '营地类型',
    '场地类型',
    '营地环境',
    '营地要求',
    '基础设置',
    '营地环境',
    '营地活动',
  ];


  static const  List<String> yxConditionS = [
    '距离优先',
    '人气优先',
    '好评优先'
  ];


}
