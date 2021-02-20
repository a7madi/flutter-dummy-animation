import 'package:flutter/material.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  /// SingleTickerProviderStateMixin => important for animation controller
  AnimationController _animationController;
  Animation<Size> _boxSizeAnimation;
  bool _isOriginalSize = true;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );

    _boxSizeAnimation = Tween<Size>(
      begin: Size(200, 100),
      end: Size(400, 200),
    ).animate(
      CurvedAnimation(
        parent: _animationController,

        /// Curve argument:
        /// يساعدنا على تحديد سرعة الأنميشين خلال الفترة المحددة
        /// مثلا البداية سرعة الحركة أثناء بداية الأنميشين وعند النهاية
        curve: Curves.bounceIn,
      ),
    );
    _boxSizeAnimation.addListener(() {
      setState(() {
        // Just to render the method...
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Center(
          child: InkWell(
            onTap: () {
              if (_isOriginalSize)
                // Start animation
                _animationController.forward();
              else {
                // Reverse animation
                _animationController.reverse();
              }
              setState(() {
                _isOriginalSize = !_isOriginalSize;
              });
            },
            child: Container(
              margin: EdgeInsets.all(8),
              alignment: Alignment.center,
              height: _boxSizeAnimation.value.height,
              width: _boxSizeAnimation.value.width,
              constraints: BoxConstraints(
                  minHeight: _boxSizeAnimation.value.height,
                  minWidth: _boxSizeAnimation.value.width),
              decoration: BoxDecoration(color: Colors.white),
              child: Text(
                _isOriginalSize
                    ? 'Tap to change box size'
                    : 'Tap to reverse the size',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
