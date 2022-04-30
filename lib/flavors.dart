enum Flavor {
  dev,
  uat,
  prod,
}

// ignore_for_file: avoid_classes_with_only_static_members
class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? 'Bullsheet';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Bullsheet DEV';
      case Flavor.uat:
        return 'Bullsheet UAT';
      case Flavor.prod:
        return 'Bullsheet';
      default:
        return 'Bullsheet';
    }
  }

}
