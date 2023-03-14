import 'dart:async';

class DelayFunction{
  Timer? resetButtonTimer;
  void delayFunc(Function function,{int seconds=2,int milliseconds = 0}) {
    resetButtonTimer?.cancel();
    resetButtonTimer = Timer(
       Duration(seconds: seconds,milliseconds: milliseconds),
          () => function(),
    );
  }
  void cancel(){
    resetButtonTimer?.cancel();
  }
}

class StreamFunction{
  StreamSubscription? streamSubscription;
  void streamFunc(Function(int) function,{int count=60,Function? doneFunc}) {
    streamSubscription?.cancel();
    streamSubscription = Stream.periodic(const Duration(seconds: 1), (i) => i).take(count).listen((event) {
      function(event);
    });
    streamSubscription?.onDone(() {
      doneFunc?.call();
    });
  }
  void cancel(){
    streamSubscription?.cancel();
  }
}