import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:random_flutter/extensions/hex_color.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import 'widget_button_gradient.dart';
import 'widget_input_maximum.dart';
import 'widget_remove_number.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final Random random = Random();
  final numberOne = BehaviorSubject<int>();
  final numberTwo = BehaviorSubject<int>();
  final numberThree = BehaviorSubject<int>();

  AnimationController _controller;
  Animation<double> _animationZoom;
  AnimationController _controllerZoom;

  ConfettiController _controllerCenterRight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _controllerZoom = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animationZoom = Tween<double>(begin: 0.9, end: 1.15).animate(
        CurvedAnimation(parent: _controllerZoom, curve: Curves.easeInOutQuint));
    _controllerCenterRight = ConfettiController();
  }

  Animatable<Color> background = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.red,
        end: Colors.green,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.green,
        end: Colors.blue,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.blue,
        end: Colors.pink,
      ),
    ),
  ]);

  Timer timer;
  InputMaximum maximum = InputMaximum(min: 0, max: 99, removed: []);

  void runRandom({bool skip = false}) {
    if (timer != null) {
      timer.cancel();
    }
    _controllerZoom.reset();
    timer = Timer.periodic(Duration(milliseconds: 25), (timer) {
      numberOne.add(random.nextInt(maximum.max < 100 ? 1 : 10));
      numberTwo.add(random.nextInt(maximum.max < 10 ? 1 : 10));
      numberThree.add(random.nextInt(10));
    });
    Future.delayed(skip ? Duration(milliseconds: 100) : Duration(seconds: 3),
        () {
      int result = int.parse(
          '${numberOne.value ?? 0}${numberTwo.value ?? 0}${numberThree.value ?? 0}');
      if (result >= maximum.min &&
          result <= maximum.max &&
          !maximum.removed.contains(result)) {
        timer.cancel();
        _controllerZoom.repeat();
        _controllerCenterRight.play();
        setState(() => maximum.removed.add(result));
      } else
        return runRandom(skip: true);
    });
  }

  void setting() async {
    if (timer != null) {
      timer.cancel();
    }
    InputMaximum _maximumDialog = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => WidgetInputMaximum(maximum: maximum));
    if (_maximumDialog != null) {
      final _maximum = await Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (context, _, __) =>
                  WidgetRemoveNumber(maximum: _maximumDialog)));
      if (_maximum != null) maximum = _maximum;
    }
    print("Maximum: ${maximum.removed} - ${maximum.min} - ${maximum.max}");
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(
            width: 5,
            color:
                background.evaluate(AlwaysStoppedAnimation(_controller.value)),
          )),
          child: child,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 32,
          title: Text(
            "Random",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                icon: Icon(FlutterIcons.settings_fea), onPressed: setting)
          ],
        ),
        body: Stack(
          children: [
            _buildBody(),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _controllerCenterRight,
                blastDirectionality: BlastDirectionality.explosive,
                // radial value - LEFT
                particleDrag: 0.05,
                // apply drag to the confetti
                emissionFrequency: 0.05,
                // how often it should emit
                numberOfParticles: 20,
                // number of particles to emit
                gravity: 0.05,
                // gravity - or fall speed
                shouldLoop: false,
                colors: const [
                  Colors.amber,
                  Colors.lightGreen,
                  Colors.blue,
                  Colors.deepPurpleAccent,
                  Colors.redAccent
                ], // manually specify the colors to be used
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            "Min: ${maximum.min} - Max: ${maximum.max}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildRandom(),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: Get.width / 2,
                    child: WidgetButtonGradient(
                      title: "Bắt đầu",
                      action: runRandom,
                      colorStart: HexColor.fromHex("#532AF5"),
                      colorEnd: HexColor.fromHex("#B463F5"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: Get.width / 7,
          margin: EdgeInsets.all(10),
          child: Center(
            child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                      width: 4,
                    ),
                scrollDirection: Axis.horizontal,
                itemCount: maximum.removed?.length ?? 0,
                itemBuilder: (_, index) {
                  return CircleAvatar(
                    radius: Get.width / 14,
                    backgroundColor: Colors.white,
                    child: Stack(
                      clipBehavior: Clip.antiAlias,
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: FittedBox(
                              child: Text(
                                '${maximum.removed[index]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: HexColor.fromHex("#B463F5")),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Transform.rotate(
                            angle: pi / 3,
                            child: Container(
                              height: Get.width / 14,
                              width: 2,
                              color: HexColor.fromHex("#B463F5"),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget _buildRandom() {
    return SizedBox(
      height: Get.height / 3,
      child: Center(
        child: AnimatedBuilder(
          animation: _animationZoom,
          builder: (context, child) {
            return Transform.scale(
              scale: _animationZoom.value,
              child: child,
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                  stream: numberOne,
                  builder: (context, snapshot) =>
                      _buildNumber(snapshot.data ?? 0)),
              const SizedBox(
                width: 10,
              ),
              StreamBuilder(
                  stream: numberTwo,
                  builder: (context, snapshot) =>
                      _buildNumber(snapshot.data ?? 0)),
              const SizedBox(
                width: 10,
              ),
              StreamBuilder(
                  stream: numberThree,
                  builder: (context, snapshot) =>
                      _buildNumber(snapshot.data ?? 0)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumber(int number) {
    return Text(
      '$number',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 96),
    );
  }
}
