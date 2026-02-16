# Habari Sasa - Flutter

A modern Flutter implementation of the Habari Sasa news and social media app, migrated from the original Android Java codebase.

## Features

- **News Feed** - Browse latest news articles with pull-to-refresh
- **Post Details** - Read full articles with HTML content rendering
- **Discover** - Explore trending content and categories
- **Messaging** - Chat functionality (requires login)
- **User Profiles** - Authentication and profile management
- **Search** - Search articles and users
- **Notifications** - View app notifications
- **Gallery** - Swipeable image gallery with zoom

## Tech Stack

- **Flutter** - Cross-platform UI framework
- **Riverpod** - State management
- **Go Router** - Navigation
- **Dio** - HTTP networking
- **Firebase** - Auth, Messaging, Analytics, Remote Config
- **Cached Network Image** - Image caching
- **Flutter HTML** - HTML content rendering

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── app/
│   ├── router.dart          # Navigation routes
│   └── theme.dart           # App theming
├── core/
│   ├── constants/           # API and app constants
│   ├── providers/           # Riverpod providers
│   ├── services/            # API service
│   └── utils/               # Utility functions
├── data/
│   └── models/              # Data models (Post, User, Message)
├── features/
│   ├── home/                # Home screen with bottom nav
│   ├── posts/               # Posts feed and detail
│   ├── discover/            # Discover/explore screen
│   ├── chat/                # Messaging
│   ├── profile/             # User profile
│   ├── search/              # Search functionality
│   ├── notifications/       # Notifications list
│   └── gallery/             # Image gallery
└── shared/
    └── widgets/             # Reusable widgets
```

## Getting Started

### Prerequisites

- Flutter SDK (3.10.1 or higher)
- Dart SDK
- Android Studio / Xcode for mobile development

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. **Firebase Setup** (Required for full functionality):
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Add Android/iOS apps to your Firebase project
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate directories:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`

4. Run the app:
   ```bash
   flutter run
   ```

### API Configuration

Update the API base URL in `lib/core/constants/api_constants.dart`:

```dart
class ApiConstants {
  static const String baseUrl = 'https://your-api-url.com';
  // ...
}
```

## Development

### Running Tests

```bash
flutter test
```

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## Migration Notes

This Flutter app was migrated from the original Android Java app. Key mappings:

| Android Component | Flutter Equivalent |
|-------------------|-------------------|
| MainActivity | HomeScreen |
| PagerItemAdapter | PostsFeed + PostCard |
| ListPostsAdapter | PostCard widget |
| GalleryActivity | GalleryScreen |
| Fragments | Feature screens |
| SharedPreferences | shared_preferences package |
| Glide | cached_network_image |
| RecyclerView | ListView.builder |
| ViewPager | PageView |

## TODO

- [ ] Implement actual API integration (currently using sample data)
- [ ] Add Firebase configuration files
- [ ] Implement authentication flow
- [ ] Add image/video upload for posts
- [ ] Implement real-time chat with Firebase
- [ ] Add push notification handling
- [ ] Implement deep linking with Firebase Dynamic Links
- [ ] Add offline support with local database

## License

This project is proprietary to Felijose.
