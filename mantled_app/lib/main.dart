
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:mantled_app/providers.dart';
import 'dart:io';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
//import 'package:advance_image_picker/advance_image_picker.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mantled_app/screens/DashboardScreens/MAHomeScreen.dart';
import 'package:mantled_app/screens/OnboardingScreens/MASignInScreen.dart';
import 'package:mantled_app/store/AppStore.dart';
import 'package:mantled_app/utils/NBColors.dart';
import 'package:mantled_app/screens/OnboardingScreens/MASplashScreen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//endregion

/// This variable is used to get dynamic colors when theme mode is changed
AppStore appStore = AppStore();
void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider<Data>(create: (_) => Data())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // final configs = ImagePickerConfigs();
    // AppBar text color
    // configs.appBarTextColor = Colors.white;
    // configs.appBarBackgroundColor = NBPrimaryColor;
    // // Disable select images from album
    // // configs.albumPickerModeEnabled = false;
    // // Only use front camera for capturing
    // // configs.cameraLensDirection = 0;
    // // Translate function
    // configs.translateFunc = (name, value) => Intl.message(value, name: name);
    // // Disable edit function, then add other edit control instead
    // configs.adjustFeatureEnabled = false;
    // configs.externalImageEditors['external_image_editor_1'] = EditorParams(
    //     title: 'external_image_editor_1',
    //     icon: Icons.edit_rounded,
    //     onEditorEvent: (
    //         {required BuildContext context,
    //           required File file,
    //           required String title,
    //           int maxWidth = 1080,
    //           int maxHeight = 1920,
    //           int compressQuality = 90,
    //           ImagePickerConfigs? configs}) async =>
    //         Navigator.of(context).push(MaterialPageRoute(
    //             fullscreenDialog: true,
    //             builder: (context) => ImageEdit(
    //                 file: file,
    //                 title: title,
    //                 maxWidth: maxWidth,
    //                 maxHeight: maxHeight,
    //                 configs: configs))));
    // configs.externalImageEditors['external_image_editor_2'] = EditorParams(
    //     title: 'external_image_editor_2',
    //     icon: Icons.edit_attributes,
    //     onEditorEvent: (
    //         {required BuildContext context,
    //           required File file,
    //           required String title,
    //           int maxWidth = 1080,
    //           int maxHeight = 1920,
    //           int compressQuality = 90,
    //           ImagePickerConfigs? configs}) async =>
    //         Navigator.of(context).push(MaterialPageRoute(
    //             fullscreenDialog: true,
    //             builder: (context) => ImageSticker(
    //                 file: file,
    //                 title: title,
    //                 maxWidth: maxWidth,
    //                 maxHeight: maxHeight,
    //                 configs: configs))));
    //
    // // Example about label detection & OCR extraction feature.
    // // You can use Google ML Kit or TensorflowLite for this purpose
    // configs.labelDetectFunc = (String path) async {
    //   return <DetectObject>[
    //     DetectObject(label: 'dummy1', confidence: 0.75),
    //     DetectObject(label: 'dummy2', confidence: 0.75),
    //     DetectObject(label: 'dummy3', confidence: 0.75)
    //   ];
    // };
    // configs.ocrExtractFunc =
    //     (String path, {bool? isCloudService = false}) async {
    //   if (isCloudService!) {
    //     return 'Cloud dummy ocr text';
    //   } else {
    //     return 'Dummy ocr text';
    //   }
    // };
    //
    // // Example about custom stickers
    // configs.customStickerOnly = true;
    // configs.customStickers = [
    //   'assets/icon/cus1.png',
    //   'assets/icon/cus2.png',
    //   'assets/icon/cus3.png',
    //   'assets/icon/cus4.png',
    //   'assets/icon/cus5.png'
    // ];

    return    AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,

      child: MaterialApp(
        routes: {
       '/page2': (context) => const MAHomeScreen(),
        },
        debugShowCheckedModeBanner: false,

        title: 'Campus',
        theme: ThemeData(
          fontFamily: "Poppins",
          colorScheme: const ColorScheme.light(
           // <-- SEE HERE
            onPrimary: Colors.white, // <-- SEE HERE
           // onSurface: NBPrimaryColor, // <-- SEE HERE
          ),

          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: NBPrimaryColor, // button text color
            ),
          ),

        ),
        home: const MASplashScreen(),
      ),
    );
  }
}
