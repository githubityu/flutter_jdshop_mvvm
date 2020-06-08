import 'package:fluro/fluro.dart';
import 'package:flutterjdshop/page/demo/ai_progress/ai_progress_demo.dart';
import 'package:flutterjdshop/page/demo/animation_page.dart';
import 'package:flutterjdshop/page/demo/animation_three.dart';
import 'package:flutterjdshop/page/demo/animation_two.dart';
import 'package:flutterjdshop/page/demo/canvas_paint.dart';
import 'package:flutterjdshop/page/demo/demo_list.dart';
import 'package:flutterjdshop/page/demo/divider_study.dart';
import 'package:flutterjdshop/page/demo/flutter_Inheritedwidget.dart';
import 'package:flutterjdshop/page/demo/flutter_barcode.dart';
import 'package:flutterjdshop/page/demo/flutter_locatal_global.dart';
import 'package:flutterjdshop/page/demo/flutter_simple.dart';
import 'package:flutterjdshop/page/demo/keyboard_demo_page.dart';
import 'package:flutterjdshop/page/demo/path_study.dart';
import 'package:flutterjdshop/page/demo/flutter_overlay.dart';
import 'package:flutterjdshop/page/demo/flutter_selector.dart';
import 'package:flutterjdshop/routes/router_init.dart';

class DemoRouter implements IRouterProvider {
  // details
  static const BARCODE = '/barcode';
  static const DEMOLIST = '/demo_list';
  static const DEMOSIMPLE = '/demo_simple';
  static const DEMOKEYWORD = '/demo_keyword';
  static const DEMODIVIDER = '/demo_divider';
  static const DEMOPAINTERSTUDY = '/demo_painter_study';
  static const DEMOPATHSTUDY = '/demo_path_study';
  static const DEMO_ANIMATION = '/demo_animation';
  static const DEMO_ANIMATION_TWO = '/demo_animation_two';
  static const DEMO_ANIMATION_THREE = '/demo_animation_three';
  static const DEMO_AI_PROGRESS = '/demo_ai_progress';
  static const DEMO_OVERLAY = '/demo_overlay';
  static const DEMO_SELECTOR = '/demo_selector';
  static const DEMO_LOCALTOGLOBAL = '/demo_localToGlobal';
  static const DEMO_INHERITEDWIDGET = '/demo_InheritedWidget';

  @override
  void initRouter(Router router) {
    router.define(BARCODE,
        handler: Handler(handlerFunc: (context, params) => BracodePage()));
    router.define(DEMOLIST,
        handler: Handler(handlerFunc: (context, params) => DemoListPage()));
    router.define(DEMOSIMPLE,
        handler: Handler(handlerFunc: (context, params) => SimpleDemoPage()));
    router.define(DEMOKEYWORD,
        handler: Handler(handlerFunc: (context, params) => KeyBoardDemoPage()));
    router.define(DEMODIVIDER,
        handler: Handler(handlerFunc: (context, params) => StudyDivider()));
    router.define(DEMOPAINTERSTUDY,
        handler: Handler(handlerFunc: (context, params) => CanvasPaintStudy()));
    router.define(DEMOPATHSTUDY,
        handler: Handler(handlerFunc: (context, params) => PathStudy()));
    router.define(DEMO_ANIMATION,
        handler: Handler(handlerFunc: (context, params) => AnimationPage()));
    router.define(DEMO_ANIMATION_TWO,
        handler: Handler(handlerFunc: (context, params) => AnimationTwo()));
    router.define(DEMO_ANIMATION_THREE,
        handler: Handler(handlerFunc: (context, params) => AnimationThree()));
    router.define(DEMO_AI_PROGRESS,
        handler: Handler(handlerFunc: (context, params) => AiProgressDemo()));
    router.define(DEMO_OVERLAY,
        handler: Handler(handlerFunc: (context, params) => OverlayPage()));
    router.define(DEMO_SELECTOR,
        handler: Handler(handlerFunc: (context, params) => SelectorPage()));
    router.define(DEMO_LOCALTOGLOBAL,
        handler: Handler(handlerFunc: (context, params) => LocalToGlobalPage()));
    router.define(DEMO_INHERITEDWIDGET,
        handler: Handler(handlerFunc: (context, params) => InheritedWidgetPage()));
  }
}
