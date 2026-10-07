# Flutter Side Swipe Cards

A smooth and customizable Flutter card stack widget that allows users to swipe cards horizontally with natural left/right swipe animations, rotation, scaling, and stacked-card effects.

Perfect for swipe-based interfaces, onboarding screens, card browsing, product discovery, profile cards, and interactive Flutter applications.
# Demo
<p align="center">
  <img src="example/assets/side_swipe_cards.gif" width="200" alt="Flutter Side Swipe Cards Demo">
</p>

## ✨ Features

* 🔄 Smooth left and right swipe animations
* ↩️ Natural card rotation while dragging
* 🃏 Multiple cards displayed in a stacked layout
* 📐 Customizable stack offset and card scale
* 🎯 Configurable swipe threshold
* ⚡ Custom animation durations
* 👆 Card tap callback support
* ⬅️ Enable or disable left swipe
* ➡️ Enable or disable right swipe
* 🚫 Disable swiping when required
* 🎨 Custom card border radius
* 📦 Simple and lightweight API
* 🧩 Clean model, utility, and widget architecture
* 📱 Flutter null-safety support
* 🔧 Fully customizable through `SideSwipeCardConfig`

---

## 📦 Installation

Add `flutter_side_swipe_cards` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_side_swipe_cards: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Quick Start

Import the package:

```dart
import 'package:flutter_side_swipe_cards/flutter_side_swipe_cards.dart';
```

Create your cards:

```dart
final cards = [
  SideSwipeCardItem(
    id: '1',
    child: Container(
      height: 400,
      width: double.infinity,
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Card 1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ),
  SideSwipeCardItem(
    id: '2',
    child: Container(
      height: 400,
      width: double.infinity,
      color: Colors.green,
      child: const Center(
        child: Text(
          'Card 2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ),
];
```

Use `SideSwipeCards`:

```dart
SideSwipeCards(
  cards: cards,
  onSwipeLeft: (card) {
    debugPrint('Swiped left: ${card.id}');
  },
  onSwipeRight: (card) {
    debugPrint('Swiped right: ${card.id}');
  },
  onCardTap: (card) {
    debugPrint('Tapped: ${card.id}');
  },
  onEmpty: () {
    debugPrint('No more cards');
  },
)
```

---

## ⚙️ Configuration

Use `SideSwipeCardConfig` to customize the swipe behavior:

```dart
SideSwipeCards(
  cards: cards,
  config: const SideSwipeCardConfig(
    visibleCards: 3,
    swipeThreshold: 120,
    maxRotation: 0.08,
    stackOffset: 14,
    stackScale: 0.04,
    animationDuration: Duration(
      milliseconds: 350,
    ),
    dismissDuration: Duration(
      milliseconds: 300,
    ),
    enableSwipe: true,
    enableLeftSwipe: true,
    enableRightSwipe: true,
    enableTap: true,
    cardBorderRadius: 20,
  ),
)
```

---

## 🎛️ Configuration Options

| Property            | Type       | Default | Description                                    |
| ------------------- | ---------- | ------: | ---------------------------------------------- |
| `visibleCards`      | `int`      |     `3` | Number of cards visible in the stack           |
| `swipeThreshold`    | `double`   |   `120` | Horizontal distance required to dismiss a card |
| `maxRotation`       | `double`   |  `0.08` | Maximum rotation applied while dragging        |
| `stackOffset`       | `double`   |    `14` | Vertical offset between stacked cards          |
| `stackScale`        | `double`   |  `0.04` | Scale reduction for background cards           |
| `animationDuration` | `Duration` | `350ms` | Duration of the reset animation                |
| `dismissDuration`   | `Duration` | `300ms` | Duration of the card dismissal animation       |
| `enableSwipe`       | `bool`     |  `true` | Enables or disables swipe gestures             |
| `enableLeftSwipe`   | `bool`     |  `true` | Allows swiping cards to the left               |
| `enableRightSwipe`  | `bool`     |  `true` | Allows swiping cards to the right              |
| `enableTap`         | `bool`     |  `true` | Enables card tap callbacks                     |
| `cardBorderRadius`  | `double`   |    `20` | Border radius applied to cards                 |

---

## 👈 Disable Left Swipe

If your application should only allow right swipes:

```dart
SideSwipeCards(
  cards: cards,
  config: const SideSwipeCardConfig(
    enableLeftSwipe: false,
    enableRightSwipe: true,
  ),
)
```

---

## 👉 Disable Right Swipe

```dart
SideSwipeCards(
  cards: cards,
  config: const SideSwipeCardConfig(
    enableLeftSwipe: true,
    enableRightSwipe: false,
  ),
)
```

---

## 🚫 Disable Swipe

You can completely disable swipe gestures:

```dart
SideSwipeCards(
  cards: cards,
  config: const SideSwipeCardConfig(
    enableSwipe: false,
  ),
)
```

---

## 👆 Card Tap

Use `onCardTap` to detect when the active card is tapped:

```dart
SideSwipeCards(
  cards: cards,
  onCardTap: (card) {
    debugPrint(
      'Card tapped: ${card.id}',
    );
  },
)
```

---

## 🔄 Swipe Callbacks

### Left Swipe

```dart
onSwipeLeft: (card) {
  debugPrint(
    'Left swipe: ${card.id}',
  );
},
```

### Right Swipe

```dart
onSwipeRight: (card) {
  debugPrint(
    'Right swipe: ${card.id}',
  );
},
```

### Empty State

The `onEmpty` callback is triggered after all available cards have been swiped:

```dart
onEmpty: () {
  debugPrint(
    'No more cards available',
  );
},
```

---

## 🧱 Card Model

Each card is represented using `SideSwipeCardItem`:

```dart
SideSwipeCardItem(
  id: 'profile_1',
  child: YourCustomWidget(),
)
```

### Properties

| Property | Type      | Description                      |
| -------- | --------- | -------------------------------- |
| `id`     | `String?` | Optional identifier for the card |
| `child`  | `Widget`  | Widget displayed as the card     |

You can place any Flutter widget inside the card:

```dart
SideSwipeCardItem(
  id: 'product_1',
  child: Image.network(
    'https://example.com/image.jpg',
    fit: BoxFit.cover,
  ),
)
```

---

## 🎨 Custom Card UI

The package does not force a specific card design.

You can use:

* `Container`
* `Card`
* `Image`
* `Column`
* `Stack`
* Custom widgets
* Network images
* Profile cards
* Product cards
* Onboarding content

Example:

```dart
SideSwipeCardItem(
  id: 'profile_1',
  child: Card(
    elevation: 8,
    child: Column(
      children: [
        Expanded(
          child: Image.network(
            'https://example.com/profile.jpg',
            fit: BoxFit.cover,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Profile Name',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  ),
)
```

---

## 📱 Example

A complete working example is available in the `example/` directory.

Run the example:

```bash
cd example
flutter pub get
flutter run
```

The example demonstrates:

* Stacked cards
* Left swipe
* Right swipe
* Card rotation
* Card scaling
* Tap handling
* Swipe callbacks
* Empty state handling

---

## 🧪 Testing

Run package tests from the project root:

```bash
flutter test
```

Run static analysis:

```bash
flutter analyze
```

A healthy project should report:

```text
No issues found!
```

---

## 📁 Project Structure

```text
flutter_side_swipe_cards/
│
├── lib/
│   ├── flutter_side_swipe_cards.dart
│   │
│   └── src/
│       ├── models/
│       │   ├── side_swipe_card_item.dart
│       │   └── side_swipe_card_config.dart
│       │
│       ├── utils/
│       │   └── side_swipe_utils.dart
│       │
│       └── widgets/
│           └── side_swipe_cards.dart
│
├── example/
│   ├── assets/
│   │   └── side_swipe_cards.gif
│   │
│   ├── lib/
│   │   └── main.dart
│   │
│   ├── test/
│   └── pubspec.yaml
│
├── test/
│   └── side_swipe_cards_test.dart
│
├── README.md
├── CHANGELOG.md
├── LICENSE
└── pubspec.yaml
```

---

## 💡 Use Cases

`flutter_side_swipe_cards` can be used for:

* 👤 Profile browsing
* 💕 Dating-style card interfaces
* 🛍️ Product discovery
* 📰 Content browsing
* 📚 Learning cards
* 🎯 Onboarding flows
* 🖼️ Image galleries
* 📋 Task cards
* 🎮 Interactive card games
* 📱 Modern mobile interfaces

---

## ⚡ Performance

The widget only renders the configured number of visible cards using `visibleCards`.

For example:

```dart
SideSwipeCardConfig(
  visibleCards: 3,
)
```

This keeps the visible card stack lightweight while maintaining a smooth swipe experience.

---

## 🔐 Null Safety

This package supports Dart null safety and follows modern Flutter development practices.

---

## 📋 Requirements

Recommended environment:

* Flutter 3.x
* Dart 3.x
* Material Flutter applications

---

## 🤝 Contributing

Contributions are welcome.

To contribute:

1. Fork the repository.
2. Create a feature branch.
3. Make your changes.
4. Run tests.
5. Run `flutter analyze`.
6. Commit your changes.
7. Open a pull request.

Example:

```bash
git checkout -b feature/my-feature
git add .
git commit -m "Add my feature"
git push origin feature/my-feature
```

---

## 📄 License

This project is licensed under the MIT License.

Copyright © 2026 Excelsior Technologies.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files, to deal in the Software
without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the
Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

## 👨‍💻 Author

**Sufiyan Shaikh**

Flutter Developer Intern
**Excelsior Technologies**



Your support helps improve and maintain the package.
