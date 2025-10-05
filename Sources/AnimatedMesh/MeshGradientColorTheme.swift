//
//  MeshGradientColorTheme.swift
//  AnimatedMesh
//
//  Created by Armin on 10/5/25.
//

import SwiftUI

public struct MeshGradientColorTheme: Sendable {
    let meshColors: [Color]

    public var meshPoints: [SIMD2<Float>] {
        [
            SIMD2<Float>(0.0, 0.0), SIMD2<Float>(0.5, 0.0), SIMD2<Float>(1.0, 0.0),
            SIMD2<Float>(0.0, 0.5), SIMD2<Float>(0.5, 0.5), SIMD2<Float>(1.0, 0.5),
            SIMD2<Float>(0.0, 1.0), SIMD2<Float>(0.5, 1.0), SIMD2<Float>(1.0, 1.0)
        ]
    }

    func shiftHue(of color: Color, by amount: Double) -> Color {
        // Extract RGB components and convert to HSB manually
        let cgColor = color.cgColor
        guard let components = cgColor?.components, components.count >= 3 else {
            return color
        }

        let r = components[0]
        let g = components[1]
        let b = components[2]
        let alpha = components.count > 3 ? components[3] : 1.0

        // Convert RGB to HSB
        let max = max(r, g, b)
        let min = min(r, g, b)
        let delta = max - min

        var hue: CGFloat = 0
        let saturation = max == 0 ? 0 : delta / max
        let brightness = max

        if delta != 0 {
            switch max {
            case r:
                hue = ((g - b) / delta).truncatingRemainder(dividingBy: 6)
            case g:
                hue = (b - r) / delta + 2
            case b:
                hue = (r - g) / delta + 4
            default:
                break
            }
            hue /= 6
        }

        // Shift hue
        hue += CGFloat(amount)
        hue = hue.truncatingRemainder(dividingBy: 1.0)
        if hue < 0 { hue += 1 }

        return Color(hue: Double(hue), saturation: Double(saturation), brightness: Double(brightness), opacity: Double(alpha))
    }

    public func animatedColors(for date: Date) -> [Color] {
        let phase = CGFloat(date.timeIntervalSince1970)

        return meshColors.enumerated().map { index, color in
            let hueShift = cos(phase + Double(index) * 0.3) * 0.15
            return shiftHue(of: color, by: hueShift)
        }
    }
}

// MARK: - Colors

public extension MeshGradientColorTheme {
    static let vibrantFlow = MeshGradientColorTheme(
        meshColors: [
            // 4 vibrant colors repeated strategically
            Color(red: 1.00, green: 0.42, blue: 0.42),  // Coral red
            Color(red: 1.00, green: 0.55, blue: 0.00),  // Orange
            Color(red: 0.54, green: 0.17, blue: 0.89),  // Purple

            Color(red: 1.00, green: 0.55, blue: 0.00),  // Orange (repeat)
            Color(red: 0.00, green: 0.00, blue: 0.55),  // Navy blue
            Color(red: 1.00, green: 0.42, blue: 0.42),  // Coral red (repeat)

            Color(red: 0.54, green: 0.17, blue: 0.89),  // Purple (repeat)
            Color(red: 0.00, green: 0.00, blue: 0.55),  // Navy blue (repeat)
            Color(red: 1.00, green: 0.55, blue: 0.00)   // Orange (repeat)
        ]
    )

    static let dreamyPurple = MeshGradientColorTheme(
        meshColors: [
            // 3 purple tones for clean sleep vibe
            Color(red: 0.4, green: 0.2, blue: 0.6),     // Deep lavender
            Color(red: 0.6, green: 0.4, blue: 0.8),     // Light lavender
            Color(red: 0.2, green: 0.1, blue: 0.4),     // Night purple

            Color(red: 0.6, green: 0.4, blue: 0.8),     // Light lavender (repeat)
            Color(red: 0.4, green: 0.2, blue: 0.6),     // Deep lavender (repeat)
            Color(red: 0.2, green: 0.1, blue: 0.4),     // Night purple (repeat)

            Color(red: 0.2, green: 0.1, blue: 0.4),     // Night purple (repeat)
            Color(red: 0.4, green: 0.2, blue: 0.6),     // Deep lavender (repeat)
            Color(red: 0.6, green: 0.4, blue: 0.8)      // Light lavender (repeat)
        ]
    )

    static let moonlitViolet = MeshGradientColorTheme(
        meshColors: [
            // 4 moonlight colors: purple + blue
            Color(red: 0.3, green: 0.2, blue: 0.5),     // Moonlit purple
            Color(red: 0.2, green: 0.3, blue: 0.6),     // Night blue
            Color(red: 0.5, green: 0.4, blue: 0.8),     // Gentle purple

            Color(red: 0.2, green: 0.3, blue: 0.6),     // Night blue (repeat)
            Color(red: 0.1, green: 0.2, blue: 0.4),     // Deep night
            Color(red: 0.3, green: 0.2, blue: 0.5),     // Moonlit purple (repeat)

            Color(red: 0.5, green: 0.4, blue: 0.8),     // Gentle purple (repeat)
            Color(red: 0.3, green: 0.2, blue: 0.5),     // Moonlit purple (repeat)
            Color(red: 0.1, green: 0.2, blue: 0.4)      // Deep night (repeat)
        ]
    )

    static let twilightFlow = MeshGradientColorTheme(
        meshColors: [
            // 3 twilight colors for simplicity
            Color(red: 0.25, green: 0.1, blue: 0.4),    // Twilight purple
            Color(red: 0.35, green: 0.2, blue: 0.5),    // Evening purple
            Color(red: 0.15, green: 0.05, blue: 0.3),   // Deep twilight

            Color(red: 0.35, green: 0.2, blue: 0.5),    // Evening purple (repeat)
            Color(red: 0.25, green: 0.1, blue: 0.4),    // Twilight purple (repeat)
            Color(red: 0.15, green: 0.05, blue: 0.3),   // Deep twilight (repeat)

            Color(red: 0.15, green: 0.05, blue: 0.3),   // Deep twilight (repeat)
            Color(red: 0.35, green: 0.2, blue: 0.5),    // Evening purple (repeat)
            Color(red: 0.25, green: 0.1, blue: 0.4)     // Twilight purple (repeat)
        ]
    )

    static let auroraSleep = MeshGradientColorTheme(
        meshColors: [
            // 4 aurora colors: purple + teal
            Color(red: 0.2, green: 0.15, blue: 0.4),    // Aurora purple
            Color(red: 0.1, green: 0.3, blue: 0.35),    // Teal night
            Color(red: 0.4, green: 0.25, blue: 0.6),    // Soft aurora

            Color(red: 0.1, green: 0.3, blue: 0.35),    // Teal night (repeat)
            Color(red: 0.05, green: 0.25, blue: 0.3),   // Deep teal
            Color(red: 0.2, green: 0.15, blue: 0.4),    // Aurora purple (repeat)

            Color(red: 0.4, green: 0.25, blue: 0.6),    // Soft aurora (repeat)
            Color(red: 0.2, green: 0.15, blue: 0.4),    // Aurora purple (repeat)
            Color(red: 0.05, green: 0.25, blue: 0.3)    // Deep teal (repeat)
        ]
    )

    static let deepRest = MeshGradientColorTheme(
        meshColors: [
            // 3 deep rest colors for ultimate calm
            Color(red: 0.15, green: 0.1, blue: 0.25),   // Deep rest
            Color(red: 0.25, green: 0.2, blue: 0.35),   // Gentle sleep
            Color(red: 0.1, green: 0.05, blue: 0.2),    // Pure rest

            Color(red: 0.25, green: 0.2, blue: 0.35),   // Gentle sleep (repeat)
            Color(red: 0.15, green: 0.1, blue: 0.25),   // Deep rest (repeat)
            Color(red: 0.1, green: 0.05, blue: 0.2),    // Pure rest (repeat)

            Color(red: 0.1, green: 0.05, blue: 0.2),    // Pure rest (repeat)
            Color(red: 0.25, green: 0.2, blue: 0.35),   // Gentle sleep (repeat)
            Color(red: 0.15, green: 0.1, blue: 0.25)    // Deep rest (repeat)
        ]
    )

    static let lavenderDream = MeshGradientColorTheme(
        meshColors: [
            // 4 lavender tones for spa-like feel
            Color(red: 0.5, green: 0.4, blue: 0.7),     // Soft lavender
            Color(red: 0.6, green: 0.5, blue: 0.8),     // Light lavender
            Color(red: 0.4, green: 0.3, blue: 0.6),     // Medium lavender

            Color(red: 0.6, green: 0.5, blue: 0.8),     // Light lavender (repeat)
            Color(red: 0.7, green: 0.6, blue: 0.9),     // Pale lavender
            Color(red: 0.5, green: 0.4, blue: 0.7),     // Soft lavender (repeat)

            Color(red: 0.4, green: 0.3, blue: 0.6),     // Medium lavender (repeat)
            Color(red: 0.5, green: 0.4, blue: 0.7),     // Soft lavender (repeat)
            Color(red: 0.7, green: 0.6, blue: 0.9)      // Pale lavender (repeat)
        ]
    )

    static let sunnyGold = MeshGradientColorTheme(
        meshColors: [
            // 4 golden yellow colors for sunny warmth
            Color(red: 1.0, green: 0.84, blue: 0.0),    // Pure gold
            Color(red: 1.0, green: 0.92, blue: 0.23),   // Bright yellow
            Color(red: 0.85, green: 0.65, blue: 0.13),  // Deep gold

            Color(red: 1.0, green: 0.92, blue: 0.23),   // Bright yellow (repeat)
            Color(red: 1.0, green: 0.96, blue: 0.56),   // Light golden
            Color(red: 1.0, green: 0.84, blue: 0.0),    // Pure gold (repeat)

            Color(red: 0.85, green: 0.65, blue: 0.13),  // Deep gold (repeat)
            Color(red: 1.0, green: 0.84, blue: 0.0),    // Pure gold (repeat)
            Color(red: 1.0, green: 0.96, blue: 0.56)    // Light golden (repeat)
        ]
    )

    static let sunsetGlow = MeshGradientColorTheme(
        meshColors: [
            Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)),
            Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)),
            Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)),
            
            Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)),
            Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)),
            Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)),
            
            Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)),
            Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)),
            Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
        ]
    )

    static let auroraBlush = MeshGradientColorTheme(
        meshColors: [
            // Hex palette: #BC82F3, #F5B9EA, #8D9FFF, #FF6778, #FFBA71, #C686FF
            // Row 1
            Color(red: 0.74, green: 0.51, blue: 0.95),   // #BC82F3 (purple)
            Color(red: 0.96, green: 0.73, blue: 0.92),   // #F5B9EA (blush pink)
            Color(red: 0.55, green: 0.62, blue: 1.00),   // #8D9FFF (periwinkle)
            // Row 2
            Color(red: 1.00, green: 0.40, blue: 0.47),   // #FF6778 (rose)
            Color(red: 1.00, green: 0.73, blue: 0.44),   // #FFBA71 (peach)
            Color(red: 0.78, green: 0.53, blue: 1.00),   // #C686FF (lavender)
            // Row 3 (repeats for balance)
            Color(red: 0.55, green: 0.62, blue: 1.00),   // #8D9FFF (periwinkle repeat)
            Color(red: 0.74, green: 0.51, blue: 0.95),   // #BC82F3 (purple repeat)
            Color(red: 1.00, green: 0.73, blue: 0.44)    // #FFBA71 (peach repeat)
        ]
    )
}
