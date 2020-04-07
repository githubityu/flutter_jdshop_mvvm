import 'package:flutter/material.dart';

typedef KeyboardShowCallback = void Function(bool isKeyboardShowing);

class KeyboardDetector extends StatefulWidget {
  KeyboardShowCallback keyboardShowCallback;

  Widget content;

  KeyboardDetector(this.content, {this.keyboardShowCallback});

  @override
  _KeyboardDetectorState createState() => _KeyboardDetectorState();
}

class _KeyboardDetectorState extends State<KeyboardDetector>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(MediaQuery.of(context).viewInsets.bottom);
      setState(() {
        widget.keyboardShowCallback
            ?.call(MediaQuery.of(context).viewInsets.bottom > 0);
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.content;
  }
}
