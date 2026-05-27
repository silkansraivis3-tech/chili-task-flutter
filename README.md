# Giphy Search App
A simple flutter app for searching gifs using GIPHY API.
This is technical task for a job.
## Features

- Search GIFs using GIPHY API
- Automatic search with short delay
- Paginated results when scroll
- GIF results displayed in responsive grid
- Detail screen for GIFs
- Loading indicatiors
- Basic error handeling
- Works on iOS and Android

## Flutter version
This project using :
```bash
Flutter 3.44.0
Dart 3.12.0
```
# Platforms tested
 
 - Android (Pixel 7)
 - iOS Simulator (Iphone 17)
 - Chrome during development

 ## Setup
 1. Clone the repo :
 ```bash
 git clone YOUR_REPO_URL
 cd chili-task-flutter
 ```
 2. Install dependencies :
 ```bash
 flutter pub get
 ```
 3. Get GIPHY API key :
 ```bash
 https://developers.giphy.com/
 ```
 4. Run the app with your API key :
 ```bash
 flutter run --dart-define=GIPHY_API_KEY=your_api_key_here
 ```
 5. Example :
 ```bash
 flutter run -d chrome --dart-define=GIPHY_API_KEY=your_api_key_here
 ```

 ## Running tests
 ```bash
 flutter test
 ```
 