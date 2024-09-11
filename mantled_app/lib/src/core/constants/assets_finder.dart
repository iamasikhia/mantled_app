/// This class holds file paths for all HeirLoom assests
/// such as images, svgs, gif, lottie.
abstract class AssetsFinder {
  static const String _svgLocation = 'assets/svg/';
  static const String _pngJpgLocation = 'assets/png/';
  static const String _pngFileExtension = '.png';
  static const String _svgFileExtension = '.svg';

  /// This method abstracts out the long file path when calling an image.
  /// All that is required is to provide the name of the file and it appends
  /// the path and the extension.
  static String getSvgPath(String assetName) {
    return _svgLocation + assetName + _svgFileExtension;
  }

  /// This method abstracts out the long file path when calling an image.
  /// All that is required is to provide the name of the file and it appends
  /// the path and the extension.
  ///
  ///
  /// Note if the image is not a [_pngFileExtension] then you can provice
  /// the [fileExtension] that satifies your use case.
  /// e.g. {.jpg, .jpeg}
  static String getImagePath(String assetName, {String? fileExtension}) {
    return _pngJpgLocation + assetName + (fileExtension ?? _pngFileExtension);
  }
}
