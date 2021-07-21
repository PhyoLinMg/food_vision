import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_vision/page/utils/constants.dart';
import 'package:food_vision/page/utils/screen_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  File? _image = null;
  List? _output;
  final picker = ImagePicker();

  classifyImage(File? image) async {
    var output = await Tflite.runModelOnImage(
      path: image!.path,
      numResults: 101,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/tf_lite/model.tflite',
      labels: 'assets/tf_lite/labels.txt',
      isAsset: true,
    );
  }

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
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
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                    )
                  ]),
              child: Flex(
                direction: ScreenHelper.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  Expanded(
                    flex: ScreenHelper.isMobile(context) ? 0 : 2,
                    child: _image == null
                        ? Image.asset('assets/images/logo.jpg')
                        : Image.file(_image!),
                  ),
                  Expanded(
                    flex: ScreenHelper.isMobile(context) ? 0 : 4,
                    child: Column(
                      children: [
                        Text(
                          "Prediction: ramen",
                          style: GoogleFonts.actor(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () => pickImage(),
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
                          onTap: () => pickGalleryImage(),
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
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //Create a button widget which will be used to trigger the camera.

}
