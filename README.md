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
## Platforms tested
 
 - Android (Pixel 7)
 - iOS Simulator (Iphone 17)
 - Chrome during development

 ## Setup
 1. Clone the repo :
 ```bash
 git clone https://github.com/silkansraivis3-tech/chili-task-flutter.git
 cd chili-task-flutter
 ```
 2. Install dependencies :
 ```bash
 flutter pub get
 ```
 3. Get GIPHY API key :
 ```text
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

 ## Structure
 Project uses a simple structure :
 ```text
    lib/
        core/
            config/
                app_config.dart

        features/
            gifs/
                data/
                    giphy_api.dart
                    gif_repository.dart
                    models/
                        gif_item.dart
                
                presentation/
                    pages/
                        gif_search_page.dart
                        gif_detail_page.dart
```
## Architecture explanation

App keeps code separated in a way:
 - `GiphyApi` handles HTTP requests to the GIPHY API
 - `GifRepository` converts API responses into app data
 - `GifItem` represents one GIF in app
 - `GifSearchPage` handles searching, pagination, loading and errors
 - `GifDetailPage` displays selected GIF with details

## Notes
 - The GIPHY API key is not stored in the repo
 - The API key should be passed using `--dart-define`
