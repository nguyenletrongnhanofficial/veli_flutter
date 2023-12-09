class HttpService {
  static final HttpService _instance = HttpService._internal();

  bool _isInitialized = false;

  factory HttpService() {
    return _instance;
  }

  HttpService._internal() {
    init();
  }

  Future<void> init() async {
    if (!_isInitialized) {
      _isInitialized = true;
    }
  }
}
