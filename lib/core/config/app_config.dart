class AppConfig {
  AppConfig._();
  static const String giphyApiKey = String.fromEnvironment('GIPHY_API_KEY');
  static const String giphyBaseUrl = 'https://api.giphy.com/v1/gifs';
}