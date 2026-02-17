# 📝 Tyro Notes

A beautiful, feature-rich notes application built with Flutter, showcasing modern UI/UX design patterns and smooth animations.

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-07405E?style=for-the-badge&logo=sqlite&logoColor=white)

</div>

## ✨ Features

### Core Functionality
- ✅ **Create & Edit Notes** - Rich text editing with title and content
- ✅ **Color Coding** - 8 beautiful color themes for organizing notes
- ✅ **Smart Search** - Real-time search across titles and content
- ✅ **Flexible Sorting** - Sort by newest, oldest, A-Z, or Z-A
- ✅ **Quick Delete** - Long-press for instant deletion
- ✅ **Dark Mode** - Eye-friendly dark theme support
- ✅ **Pull to Refresh** - Swipe down to reload notes

### Animations & UX
- 🎬 **Shimmer Loading** - Beautiful skeleton screens while loading
- 🎬 **Staggered Animations** - Notes cascade into view smoothly
- 🎬 **Hero Transitions** - Seamless morphing between list and editor
- 🎬 **Animated Color Picker** - Scale, glow, and bounce effects
- 🎬 **Slide Animations** - Smooth bottom sheet transitions
- 🎬 **Interactive Feedback** - Visual responses to all user actions

## 🏗️ Architecture

This app follows **Clean Architecture** principles with a well-organized structure:

```
lib/
├── core/
│   ├── database/          # Floor database configuration
│   └── util/              # Type converters and utilities
├── cubit/
│   ├── sort_cubit.dart    # Sorting state management
│   └── theme_cubit.dart   # Theme state management
└── features/
    └── notes/
        ├── bloc/          # BLoC pattern for notes
        ├── database/      # DAO (Data Access Objects)
        ├── models/        # Note entity model
        ├── screens/       # UI screens
        └── widgets/       # Reusable widgets & animations
```

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| **Flutter** | Cross-platform UI framework |
| **Dart** | Programming language |
| **Floor** | SQLite database abstraction |
| **BLoC Pattern** | State management |
| **Cubit** | Lightweight state management |
| **Material 3** | Modern design system |

## 📦 Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.6      # State management
  floor: ^1.5.0             # Database ORM
  intl: ^0.18.1             # Date formatting
  
dev_dependencies:
  floor_generator: ^1.5.0   # Code generation
  build_runner: ^2.4.13     # Build tools
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/notes_app.git
   cd notes_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate database code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   # For Linux
   flutter run -d linux
   
   # For Android
   flutter run -d android
   
   # For iOS
   flutter run -d ios
   
   # For Web
   flutter run -d chrome
   ```

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Linux
- ✅ macOS
- ✅ Windows
- ✅ Web

## 🎨 Screenshots

> [List Screen](screenshots/list_screen_light.jpg)
> [List Screen](screenshots/list_screen_dark.jpg)
> [List Screen](screenshots/new_note_screen_dark.jpg)
> [List Screen](screenshots/setting_screen_dark.jpg)
> [List Screen](screenshots/setting_screen_light.jpg)
> [List Screen](screenshots/not_found_screen_light.jpg)
> [List Screen](screenshots/not_found_screen_dark.jpg)
> [List Screen](screenshots/about_screen_dark.jpg)
> [List Screen](screenshots/about_screen_light.jpg)
> [List Screen](screenshots/edit_screen_light.jpg)

### Light Mode
- Home screen with notes list
- Note editor
- Settings screen

### Dark Mode
- Theme-adaptive UI
- Beautiful color schemes

## 💡 Usage

### Creating a Note
1. Tap the **"New Note"** floating action button
2. Enter a title and content
3. Choose a color from the palette
4. Tap **"Save"**

### Editing a Note
1. Tap any note card from the list
2. Modify the content
3. Tap **"Save"** to update

### Deleting a Note
1. Long-press on any note card
2. Tap **"Delete"** in the bottom sheet
3. Confirm deletion

### Searching Notes
- Type in the search bar at the top
- Results update in real-time
- Clear search to view all notes

### Sorting Notes
- Tap sort buttons: **Newest**, **Oldest**, **A-Z**, or **Z-A**
- Active sort is highlighted
- Sorting persists during search

## 🔧 Recent Improvements

### Bug Fixes (v1.1.0)
- ✅ Fixed critical save validation bug preventing empty note checks
- ✅ Improved RefreshIndicator with timeout and error handling

### Animation Enhancements (v1.1.0)
- ✨ Added shimmer loading effect
- ✨ Implemented staggered list animations
- ✨ Added Hero transitions between screens
- ✨ Created animated color picker with glow effects
- ✨ Added slide-up animation for delete dialog
- ✨ Enhanced note cards with subtle shadows

## 🏛️ Design Patterns

### State Management
- **BLoC Pattern** for complex note operations
- **Cubit** for simple state (theme, sorting)
- **StreamSubscription** for reactive updates

### Database
- **Floor** (SQLite wrapper) for local persistence
- **DAO Pattern** for data access
- **Type Converters** for DateTime handling

### Animations
- **Staggered Animations** for list items
- **Hero Animations** for screen transitions
- **TweenAnimationBuilder** for custom effects
- **AnimatedContainer** for smooth transitions

## 🧪 Code Quality

```bash
# Run analyzer
flutter analyze

# Run tests (when available)
flutter test

# Check for outdated packages
flutter pub outdated
```

Current Status: **7 info warnings** (non-critical deprecations and style suggestions)

## 📖 Project Structure Details

### Core Components

**Database Layer**
- `app_database.dart` - Floor database configuration
- `note_dao.dart` - Data access operations with sorting queries

**State Management**
- `note_bloc.dart` - Handles all note CRUD operations
- `sort_cubit.dart` - Manages sorting preferences
- `theme_cubit.dart` - Toggles dark/light mode

**UI Components**
- `note_list_screens.dart` - Main screen with search and sort
- `note_editor_screen.dart` - Create/edit note interface
- `setting_screen.dart` - App settings and preferences

**Animations**
- `animated_item.dart` - Staggered list animation widget
- `shimmer_loading.dart` - Loading skeleton effect
- `delete_dialog.dart` - Animated bottom sheet

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

**Tyro**

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- BLoC library maintainers
- Material Design guidelines
- Floor database library

---

<div align="center">

**Made with ❤️ using Flutter**

⭐ Star this repo if you find it helpful!

</div>
