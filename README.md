# 🌅 Coco - Magical Reminder App

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Riverpod-00A6ED?style=for-the-badge" alt="Riverpod" />
  <img src="https://img.shields.io/badge/Hive-F29E3C?style=for-the-badge" alt="Hive" />
</div>

<p align="center">
  <i>A warm and magical reminder & task scheduler app inspired by Pixar's "Coco"</i>
</p>

---

## ✨ Overview

**Coco** is a beautifully designed offline-first reminder application built with Flutter. It combines powerful task management features with a warm, magical user interface inspired by the sunset vibes and emotional depth of Pixar's "Coco" film.

### 🎯 Key Features

- 📱 **Offline-First Architecture** - Works seamlessly without internet connection
- 🎨 **Beautiful UI** - Warm sunset gradients and smooth animations
- 🔔 **Local Notifications** - Get reminded at the right time
- 📊 **Statistics & Insights** - Track your productivity
- 🏷️ **Smart Categories** - Work, Personal, Health, Study, and more
- ⚡ **Priority Levels** - High, Medium, Low priority management
- 🔄 **Recurring Reminders** - Daily, Weekly, Monthly, Yearly repeats
- 🌙 **Dark Mode Support** - Easy on the eyes (ready to implement)

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a **Feature-First** folder structure, ensuring maintainability, testability, and scalability.

### Architecture Layers

```
┌─────────────────────────────────────┐
│     Presentation Layer (UI)         │
│  • Pages, Widgets, Providers        │
├─────────────────────────────────────┤
│     Domain Layer (Business Logic)   │
│  • Entities, Repositories, UseCases │
├─────────────────────────────────────┤
│     Data Layer (Data Sources)       │
│  • Models, Repositories Impl        │
│  • Local DataSource (Hive)          │
└─────────────────────────────────────┘
```

### Tech Stack

| Technology | Purpose |
|------------|---------|
| **Flutter** | Cross-platform UI framework |
| **Riverpod** | State management (type-safe, modern) |
| **Hive** | NoSQL local database (offline-first) |
| **GoRouter** | Declarative routing |
| **Google Fonts** | Custom typography (Poppins, Nunito) |
| **Local Notifications** | Background reminders |
| **Intl** | Date/time formatting |
| **Equatable** | Value equality |
| **UUID** | Unique identifier generation |

---

## 📁 Project Structure

```
coco/
├── lib/
│   ├── core/                          # Core utilities & configurations
│   │   ├── constants/                 # App constants & colors
│   │   ├── theme/                     # App theme configuration
│   │   ├── router/                    # Navigation setup
│   │   ├── extensions/                # Dart extensions
│   │   └── services/                  # Core services
│   │
│   ├── features/                      # Feature modules
│   │   ├── splash/                    # Splash screen
│   │   │   └── presentation/
│   │   │       └── pages/
│   │   │
│   │   ├── dashboard/                 # Main dashboard
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       └── widgets/
│   │   │
│   │   ├── reminder/                  # Reminder feature (CRUD)
│   │   │   ├── data/
│   │   │   │   ├── models/           # Hive models
│   │   │   │   ├── datasources/      # Local data source
│   │   │   │   └── repositories/     # Repository implementation
│   │   │   ├── domain/
│   │   │   │   ├── entities/         # Business entities
│   │   │   │   └── repositories/     # Repository contracts
│   │   │   └── presentation/
│   │   │       ├── pages/            # UI pages
│   │   │       ├── widgets/          # Reusable widgets
│   │   │       └── providers/        # Riverpod providers
│   │   │
│   │   └── statistics/                # Statistics & insights
│   │       └── presentation/
│   │           └── pages/
│   │
│   └── main.dart                      # App entry point
│
├── assets/                            # Static assets
│   ├── images/
│   ├── icons/
│   └── animations/
│
├── test/                              # Unit & widget tests
└── pubspec.yaml                       # Dependencies
```

---

## 🎨 Design System

### Color Palette

```dart
Deep Purple:      #6C5CE7  // Primary
Warm Orange:      #FF9F43  // Secondary/FAB
Soft Pink:        #FDA7DC  // Accent
Pastel Turquoise: #81ECEC  // Info
Golden Glow:      #FDCB6E  // Warning
```

### Typography

- **Headings**: Poppins SemiBold
- **Body**: Nunito Regular
- **Labels**: Nunito SemiBold

### UI Elements

- ✅ Rounded glowing cards (20px border radius)
- ✅ Soft sunset gradients
- ✅ Floating Action Button with warm orange
- ✅ Smooth page transitions
- ✅ Subtle glow animations

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: `>=3.9.2`
- Dart SDK: `>=3.9.2`
- Android Studio / VS Code
- Android SDK / Xcode (for iOS)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/coco.git
   cd coco
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (Hive adapters, Riverpod)**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## 📱 Features Overview

### 1. Splash Screen
- 3-stage magical animation
- Sunset gradient background
- Smooth fade & scale transitions
- "Start Now" button with slide-in effect

### 2. Dashboard
- **Filter Tabs**: Today, This Week, All, Done
- **Quick Stats**: Active, Done, Completion Rate
- **Card List**: Beautiful reminder cards with:
  - Category icons & colors
  - Priority indicators
  - Time & location info
  - Status badges

### 3. Add/Edit Reminder
- Title & Description fields
- Date & Time picker
- Location (optional)
- Category selection (5 categories)
- Priority levels (Low, Medium, High)
- Repeat options (None, Daily, Weekly, Monthly, Yearly)
- Notification toggle

### 4. Reminder Detail
- Full reminder information
- Time remaining countdown
- Quick actions (Complete, Edit, Delete)
- Beautiful card design with gradient

### 5. Statistics
- Overall performance metrics
- Weekly progress tracking
- Category breakdown
- Priority breakdown
- Motivational achievements

---

## 🔧 Configuration

### Local Notifications Setup

#### Android
Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT" />
```

#### iOS
Add to `ios/Runner/Info.plist`:
```xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
</array>
```

### Permissions
Add to `pubspec.yaml` (already included):
```yaml
dependencies:
  permission_handler: ^11.2.0
```

---

## 🧪 Testing

Run tests:
```bash
flutter test
```

Run with coverage:
```bash
flutter test --coverage
```

---

## 🎯 Roadmap

- [ ] Implement local notifications
- [ ] Add search functionality
- [ ] Implement dark mode toggle
- [ ] Add reminder attachments (images)
- [ ] Voice input for reminders
- [ ] Cloud sync (Firebase/Supabase)
- [ ] Widget support
- [ ] Share reminders
- [ ] Export/Import reminders (JSON, CSV)
- [ ] Multi-language support

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable/function names
- Add comments for complex logic
- Keep functions small and focused

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Your Name**
- GitHub: [@yourusername](https://github.com/yourusername)
- Email: your.email@example.com

---

## 🙏 Acknowledgments

- Inspired by Pixar's "Coco" film
- Design inspiration from Material Design 3
- Flutter community for amazing packages
- Clean Architecture principles by Uncle Bob

---

## 📸 Screenshots

> Add your app screenshots here

| Splash | Dashboard | Add Reminder |
|--------|-----------|--------------|
| ![Splash](screenshots/splash.png) | ![Dashboard](screenshots/dashboard.png) | ![Add](screenshots/add.png) |

| Detail | Statistics | Filters |
|--------|------------|---------|
| ![Detail](screenshots/detail.png) | ![Stats](screenshots/stats.png) | ![Filters](screenshots/filters.png) |

---

<div align="center">
  <p>Made with ❤️ and Flutter</p>
  <p>⭐ Star this repo if you like it!</p>
</div>