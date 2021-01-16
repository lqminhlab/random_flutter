import 'package:flutter/material.dart';

import 'widget_loading.dart';

class WidgetButtonGradient extends StatelessWidget {
  final bool loading;
  final String title;
  final Function action;
  final Color colorStart;
  final Color colorEnd;
  final Color colorLoading;
  final Alignment alignmentStart;
  final Alignment alignmentEnd;

  const WidgetButtonGradient(
      {this.alignmentStart,
      this.alignmentEnd,
      this.colorLoading,
      this.colorEnd,
      this.colorStart,
      this.loading = false,
      @required this.title,
      @required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: RaisedButton(
        onPressed: loading ? null : action ?? () {},
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorStart,
                  colorEnd
                ],
                begin: alignmentStart ?? Alignment.bottomCenter,
                end: alignmentEnd ?? Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            alignment: Alignment.center,
            child: !loading
                ? Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )
                : Center(
                    child: WidgetLoading(
                      dotOneColor: colorLoading ?? Colors.white,
                      dotTwoColor: colorLoading ?? Colors.white,
                      dotThreeColor: colorLoading ?? Colors.white,
                      dotType: DotType.circle,
                      duration: Duration(milliseconds: 1000),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
