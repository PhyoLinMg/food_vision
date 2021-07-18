import 'package:flutter/material.dart';
import 'package:food_vision/page/utils/constants.dart';
import 'package:food_vision/page/utils/screen_helper.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHelper(
            desktop: _buildUi(context, kDesktopMaxWidth),
            mobile: _buildUi(context, getMobileMaxWidth(context)),
            tablet: _buildUi(context, kTabletMaxWidth),
          )
        ],
      ),
    );
  }

  Widget _buildUi(BuildContext context, double width) {
    return ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: Column(
        children: [],
      ),
    );
  }
}
