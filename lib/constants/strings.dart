abstract class StringValues {
  static const appName = 'OSit Inventory';
  static const OSITUrl = 'https://www.openservices.eus';

  static const String themeMode = 'themeMode';
  static const String system = 'System';
  static const String light = 'Light';
  static const lightMode = 'Light Mode';
  static const lightModeDesc = 'Use light theme';
  static const String dark = 'Dark';
  static const darkModeDesc = 'Use dark theme';
  static const darkMode = 'Dark Mode';
  static const okay = 'Ok';

  static final _initialDbParams = InitialDbParams();

  static InitialDbParams get initialDbParams => _initialDbParams;
  static const legalese = "Open Services IT";

}

class InitialDbParams {
  final _host = 'centreon.local.local';
  final _port = 3306;
  final _username = 'username';
  final _pass = 'password';
  final _db = 'centreon_storage';

  String get host => _host;
  int get port => _port;
  String get username => _username;
  String get pass => _pass;
  String get db => _db;
}

abstract class AssetValues {
  // TODO Rename ALL!!
  static const String appLogo = 'assets/logo_trans.png';
  static const String appLogoSplash = 'assets/splash_screen/logo.png';
  static const String avatar = 'assets/avatar.png';
  static const String error = 'assets/error.png';

}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

enum SnackType { ERROR, SUCCESS, WARNING }

