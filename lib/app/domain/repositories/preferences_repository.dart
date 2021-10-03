abstract class PreferencesRepository {
  bool get isDarckMode;
  Future<void> darkMode(bool enabled);
}
