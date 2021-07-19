import 'package:flutter/material.dart';
import 'package:food_vision/page/utils/constants.dart';
import 'package:food_vision/page/utils/screen_helper.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      body: Container(
        child: ScreenHelper(
          desktop: _buildUi(kDesktopMaxWidth),
          mobile: _buildUi(getMobileMaxWidth(context)),
          tablet: _buildUi(kTabletMaxWidth),
        ),
      ),
    );
  }

  Widget _buildUi(double width) {
    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ResponsiveWrapper(
            maxWidth: width,
            minWidth: width,
            defaultScale: false,
            child: Flex(
              direction: ScreenHelper.isMobile(context)
                  ? Axis.vertical
                  : Axis.horizontal,
              children: [
                Expanded(
                  flex: ScreenHelper.isMobile(context) ? 0 : 2,
                  child: Image.asset("images/food_logo.jpg"),
                ),
                Expanded(
                  flex: ScreenHelper.isMobile(context) ? 0 : 4,
                  child: Column(
                    children: [
                      Text(
                        "Prediction:",
                        style: GoogleFonts.actor(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            border: Border.all(color: primaryColor),
                          ),
                          child: Text("Open Camera",
                              style: GoogleFonts.actor(fontSize: 15)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            border: Border.all(color: primaryColor),
                          ),
                          child: Text("Select Photo",
                              style: GoogleFonts.actor(fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  //Create a button widget which will be used to trigger the camera.

}
