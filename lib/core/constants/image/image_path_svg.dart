class SVGImagePaths {
  static SVGImagePaths? _instance;
  static SVGImagePaths get instance {
    _instance ??= SVGImagePaths._init();
    return _instance!;
  }

  SVGImagePaths._init();

  String get languageSVG => toSVG('language');
  String get themeSVG => toSVG('theme');
  String get starSVG => toSVG('star');

  String toSVG(String name) => 'assets/svg/$name.svg';
}