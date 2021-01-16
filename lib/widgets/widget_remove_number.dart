import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:random_flutter/widgets/widget_input_maximum.dart';

import '../extensions/extensions.dart';
import 'widget_button_gradient.dart';

class WidgetRemoveNumber extends StatefulWidget {
  final InputMaximum maximum;

  const WidgetRemoveNumber({this.maximum});

  @override
  _WidgetRemoveNumberState createState() => _WidgetRemoveNumberState();
}

class _WidgetRemoveNumberState extends State<WidgetRemoveNumber> {
  InputMaximum maximum;

  @override
  void initState() {
    super.initState();
    maximum = widget.maximum;
    print("Maximummm: ${maximum.removed} - ${maximum.min} - ${maximum.max}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, widget.maximum);
          },
          icon: Icon(FlutterIcons.arrow_left_bold_box_mco),
        ),
        title: Text("Số không xuất hiện",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: Get.width / 26,
                      mainAxisSpacing: Get.width / 26,
                    ),
                    itemCount: maximum.max - maximum.min + 1,
                    itemBuilder: (context, index) =>
                        _buildNumber(index + maximum.min))),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: Get.width / 2,
              child: WidgetButtonGradient(
                title: "Đồng ý",
                action: () => Navigator.pop(context, maximum),
                colorStart: HexColor.fromHex("#532AF5"),
                colorEnd: HexColor.fromHex("#B463F5"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _buildNumber(int number) {
    bool status = maximum.removed.contains(number);
    return CircleAvatar(
      radius: Get.width / 12,
      backgroundColor: status ? HexColor.fromHex("#B463F5") : Colors.white,
      child: InkWell(
        onTap: () {
          setState(() {
            if (status)
              maximum.removed.remove(number);
            else
              maximum.removed.add(number);
          });
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: FittedBox(
            child: Text(
              '$number',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: status ? Colors.white : HexColor.fromHex("#B463F5")),
            ),
          ),
        ),
      ),
    );
  }
}
