import 'package:mantled_app/src/core/constants/assets_finder.dart';

/// This class holds file paths for all logistat assests
/// such as images, svgs, gif, lottie.
class AppAssets {
  AppAssets._();

  ///=============================== SVGs==========================///

  ///SVG Can be found on view that required face id for authentication.
  static String faceId = AssetsFinder.getSvgPath('face-id');

  /// Icon used in bottom navigation bar.
  static String bottomNavHomeButton =
      AssetsFinder.getSvgPath('bottom_nav_home_icon');

  /// Icon used in bottom navigation bar.
  static String bottomNavCollabButton =
      AssetsFinder.getSvgPath('bottom_nav_collab_icon');

  /// Icon used in bottom navigation bar.
  static String bottomNavVaultButton =
      AssetsFinder.getSvgPath('bottom_nav_shield');

  /// Icon used in bottom navigation bar.
  static String bottomNavSettingsButton =
      AssetsFinder.getSvgPath('bottom_nav_settings');

  /// Onboarding image.
  static String onBoardingImage1 = AssetsFinder.getSvgPath('onboarding_1');

  /// Onboarding image.
  static String onBoardingImage2 = AssetsFinder.getSvgPath('onboarding_2');

  /// Onboarding image.
  static String onBoardingImage3 = AssetsFinder.getSvgPath('onboarding_3');

  ///============================ PNGs===============================///

  ///PNG Can be found in the authentication views
  static String appLogo = AssetsFinder.getImagePath('mantled');

  ///PNG Can be found in the views where a user completes a certain process.
  static String confettiCone = AssetsFinder.getImagePath('confetti-cone');

  ///Material Arrow back button used frequently in app.
  static String arrowBackIcon =
      AssetsFinder.getImagePath('material-arrow-back');

  /// Dummy user profile picture.
  static String dummyUserProfilePicture =
      AssetsFinder.getImagePath('dummy_profile_picture');
}
