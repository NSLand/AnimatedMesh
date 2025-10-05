# 🌀 AnimatedMesh

> **Dynamic, themeable, and fully SwiftUI-powered animated mesh gradients.**  
> Add motion and color depth to your app’s backgrounds with ease.

![Swift](https://img.shields.io/badge/Swift-6.2-orange.svg)
![Platforms](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20visionOS-blue)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-MeshGradient-purple.svg)

---

## ✨ Overview

**AnimatedMesh** brings **live, evolving color gradients** to SwiftUI using the new `MeshGradient` API.  
It’s lightweight, theme-based, and completely customizable — perfect for creating ambient motion backgrounds, onboarding screens, and modern Apple-style visuals.

> Think **App Store icons**, **Apple Music auroras**, or **macOS Sonoma wallpapers** — but made interactive and code-driven.

---

## 🧱 Installation

### Swift Package Manager

In **Xcode**:

1. Go to **File ▸ Add Packages...**
2. Enter the URL:
   ```
   https://github.com/nsland/AnimatedMesh
   ```
3. Choose **Add Package**

Or manually in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/nsland/AnimatedMesh", from: "1.0.0")
]
```

Then import it:

```swift
import AnimatedMesh
```

---

## 🧭 Usage

### Basic Example

```swift
import SwiftUI
import AnimatedMesh

struct ContentView: View {
    var body: some View {
        ZStack {
            AnimatedMesh(theme: .auroraBlush)
                .ignoresSafeArea()
            
            VStack {
                Text("Hello, Mesh!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
            }
        }
    }
}
```

---

### Custom Theme Example

```swift
let customTheme = MeshGradientColorTheme(
    width: 4,
    height: 4,
    meshColors: [
        .blue, .purple, .cyan, .blue,
        .purple, .cyan, .blue, .purple,
        .cyan, .blue, .purple, .cyan,
        .blue, .purple, .cyan, .blue
    ]
)
```

Use it like this:

```swift
AnimatedMesh(theme: customTheme)
```

---

## 🎨 Built-in Themes

| Theme | Description |
|-------|--------------|
| `.auroraBlush` | Soft pinks, purples, and peaches for glowing backgrounds |
| `.dreamyPurple` | Serene lavender tones for calm, sleep-inspired UIs |
| `.moonlitViolet` | Deep blue-violet hues of a moonlit sky |
| `.twilightFlow` | Subtle purple gradients for elegant dark designs |
| `.auroraSleep` | Soothing purple and teal blend for tranquil animations |
| `.deepRest` | Muted purples for meditative or sleep apps |
| `.lavenderDream` | Gentle spa-like lavender tones |
| `.sunnyGold` | Bright golden and yellow hues for cheerful UIs |
| `.sunsetGlow` | Warm sunset reds and pinks |
| `.vibrantFlow` | Bold and dynamic palette for playful designs |

---

## ⚙️ Customization

You can easily adjust:
- `width` and `height` → number of mesh grid columns/rows  
- `meshColors` → base colors of your theme

You can even create your own dynamic logic:
```swift
extension MeshGradientColorTheme {
    static let oceanBreeze = MeshGradientColorTheme(
        width: 3,
        height: 3,
        meshColors: [.blue, .teal, .mint, .cyan, .indigo, .blue, .mint, .cyan, .teal]
    )
}
```

---

## 🪄 Accessibility

`AnimatedMesh` is purely decorative.  
If used as a background, mark it as hidden from accessibility:

```swift
.accessibilityHidden(true)
```

---

## 💡 Requirements

| Platform | Minimum Version |
|-----------|----------------|
| iOS | 18.0 |
| macOS | 15.0 |
| tvOS | 18.0 |
| visionOS | 2.0 |
| watchOS | 11.0 |

- Requires **Swift 6.2** or later  
- Uses SwiftUI’s native `MeshGradient` API  


---

## 📄 License

Licensed under the **MIT License**.  
See [LICENSE](LICENSE) for details.
