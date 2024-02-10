abstract class StringValues {
  static const appName = 'Kiom';
  static const welcome = '¡Bienvenid@!';
  static const welcomeRegister = '¡Bienvenid@, registrate!';
  static const welcomeBack = '¡Hola, bienvenid@ de vuelta!';
  static const hello = 'Hola';
  static const register = 'Registrarse';
  static const login = 'Iniciar sesión';
  static const logout = 'Salir';
  static const logout1 = 'Cerrar sesion';
  static const forgotPassword = 'Olvide mi contraseña';
  static const resetPassword = 'Reset Password';
  static const name = 'Nombre';
  static const firstName = 'Primer nombre';
  static const lastName = 'Segundo nombre';
  static const email = 'Email';
  static const username = 'Nombre de Usuario';
  static const password = 'Contraseña';
  static const doNotHaveAccount = "No tenes cuenta?";
  static const alreadyHaveAccount = "Ya estas registrad@?";
  static const alreadyRegistered = "Ya existe este usuario!!";
  static const String themeMode = 'themeMode';
  static const String system = 'System';
  static const String light = 'Light';
  static const lightMode = 'Light Mode';
  static const lightModeDesc = 'Use light theme';
  static const String dark = 'Dark';
  static const darkModeDesc = 'Use dark theme';
  static const darkMode = 'Dark Mode';
  static const okay = 'Ok';
  static const errorOccurred = 'Ocurrió un errror intente nuevamente.';
  static const unknownErrorOccurred = 'Ocurrió un error inesperado';
  static const loginSuccessful = 'Bienvenid@ de vuelta';
  static const registrationSuccessful =
      'Te enviamos un correo para confirmar tu cuenta';
  static const logoutSuccessful = 'Logged out successfully.';
  static const token = 'token';
  static const refreshToken = 'refreshToken';
  static const expiresAt = 'expiresAt';
  static const user = 'user';
  static const loginData = 'loginData';
  static const authDetailsSaved = 'Auth details saved.';
  static const authDetailsNotSaved = "Auth details couldn't saved.";
  static const authDetailsFound = 'Auth details found.';
  static const authDetailsNotFound = 'Auth details not found.';
  static const userData = 'userData';
  static const authDetailsRemoved = 'Auth details removed.';
  static const noExpensesData = 'No hay gastos aun !!';
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

