import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:random_flutter/extensions/hex_color.dart';

import 'widget_button_gradient.dart';

class InputMaximum {
  int max;
  int min;
  List<int> removed;

  InputMaximum({this.min, this.max, this.removed});
}

class WidgetInputMaximum extends StatelessWidget {
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  InputMaximum maximum;

  WidgetInputMaximum({this.maximum}) {
    minController.text = '${maximum.min}';
    maxController.text = '${maximum.max}';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 4,
          ),
          Text(
            "Chọn giới hạn",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 6,
              ),
              IconButton(
                onPressed: () {
                  int _minTemp = int.parse(maxController.text.length == 0
                      ? "0"
                      : maxController.text);
                  _minTemp--;
                  if (_minTemp >= 0) maxController.text = '$_minTemp';
                },
                icon: Icon(
                  FlutterIcons.minus_faw5s,
                  size: 22,
                  color: Colors.blueGrey,
                ),
              ),
              Expanded(
                child: Center(
                  child: TextField(
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    controller: maxController,
                    cursorColor: Colors.black,
                    maxLength: 2,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Số lớn nhất...",
                      counter: SizedBox(),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  int _maxTemp = int.parse(maxController.text.length == 0
                      ? "100"
                      : maxController.text);
                  int _minTemp = int.parse(minController.text.length == 0
                      ? "0"
                      : minController.text);
                  _minTemp++;
                  if (_maxTemp <= 100) maxController.text = '$_maxTemp';
                },
                icon: Icon(
                  FlutterIcons.plus_faw5s,
                  size: 22,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              const SizedBox(
                width: 6,
              ),
              IconButton(
                onPressed: () {
                  int _minTemp = int.parse(minController.text.length == 0
                      ? "0"
                      : minController.text);
                  _minTemp--;
                  if (_minTemp >= 0) minController.text = '$_minTemp';
                },
                icon: Icon(
                  FlutterIcons.minus_faw5s,
                  size: 22,
                  color: Colors.blueGrey,
                ),
              ),
              Expanded(
                child: Center(
                  child: TextField(
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    controller: minController,
                    cursorColor: Colors.black,
                    textAlign: TextAlign.center,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Số nhỏ nhất...",
                      counter: SizedBox(),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  int _maxTemp = int.parse(maxController.text.length == 0
                      ? "100"
                      : maxController.text);
                  int _minTemp = int.parse(minController.text.length == 0
                      ? "0"
                      : minController.text);
                  _minTemp++;
                  if (_minTemp < _maxTemp) minController.text = '$_minTemp';
                },
                icon: Icon(
                  FlutterIcons.plus_faw5s,
                  size: 22,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: Get.width / 3,
            child: WidgetButtonGradient(
              title: "Lưu",
              action: () {
                int _maxTemp = int.parse(maxController.text.length == 0
                    ? "100"
                    : maxController.text);
                int _minTemp = int.parse(
                    minController.text.length == 0 ? "0" : minController.text);
                InputMaximum _maximum;
                if (_maxTemp > _minTemp || _maxTemp == _minTemp) {
                  _maximum = InputMaximum(
                      max: _maxTemp, min: _minTemp, removed: maximum.removed);
                } else {
                  _maximum = InputMaximum(
                      max: _minTemp, min: _maxTemp, removed: maximum.removed);
                }
                Navigator.pop(context, _maximum);
              },
              colorStart: HexColor.fromHex("#532AF5"),
              colorEnd: HexColor.fromHex("#B463F5"),
            ),
          )
        ],
      ),
    ));
  }
}
