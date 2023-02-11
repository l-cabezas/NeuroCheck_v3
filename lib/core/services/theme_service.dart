

/*class ThemeService {
  ThemeService._();

  static final instance = ThemeService._();

  factory ThemeService(Reader reader) {
    instance._reader = reader;
    this.reader = reader;
    return instance;
  }

  final Reader _reader;

  bool isDarkMode([ThemeMode? currentTheme, Brightness? platformBrightness]) {
    final _currentTheme = currentTheme ?? _reader(appThemeProvider);
    if (_currentTheme == ThemeMode.system) {
      return (platformBrightness ??
          SchedulerBinding.instance.window.platformBrightness) ==
          Brightness.dark;
    } else if (_currentTheme == ThemeMode.dark) {
      return true;
    } else {
      return false;
    }
  }
}*/
