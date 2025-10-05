//
//  MeshGradientColorTheme.swift
//  AnimatedMesh
//
//  Created by Armin on 10/5/25.
//

import SwiftUI

// MARK: - Multiplatform Color Handling
#if canImport(UIKit)
import UIKit
private typealias PlatformColor = UIColor
#elseif canImport(AppKit)
import AppKit
private typealias PlatformColor = NSColor
#endif

public struct MeshGradientColorTheme: Sendable {
    /// The number of columns in the mesh grid.
    public let width: Int
    
    /// The number of rows in the mesh grid.
    public let height: Int
    
    /// The base colors used for the mesh gradient.
    let meshColors: [Color]
    
    /// Creates a new mesh gradient theme.
    ///
    /// - Parameters:
    ///   - width: The number of columns in the mesh grid. Defaults to 3.
    ///   - height: The number of rows in the mesh grid. Defaults to 3.
    ///   - meshColors: An array of `Color`s to use in the gradient. The number of colors
    ///     should equal `width * height`.
    public init(width: Int = 3, height: Int = 3, meshColors: [Color]) {
        assert(meshColors.count == width * height, "The number of colors must match width * height.")
        self.width = width
        self.height = height
        self.meshColors = meshColors
    }
    
    /// Dynamically generates the mesh control points based on the grid dimensions.
    public var meshPoints: [SIMD2<Float>] {
        var points: [SIMD2<Float>] = []
        for row in 0..<height {
            for col in 0..<width {
                let x = Float(col) / Float(width - 1)
                let y = Float(row) / Float(height - 1)
                points.append(.init(x, y))
            }
        }
        return points
    }

    /// Calculates the animated colors for a given timestamp.
    public func animatedColors(for date: Date) -> [Color] {
        let phase = CGFloat(date.timeIntervalSince1970)
        
        return meshColors.enumerated().map { index, color in
            // These "magic numbers" can be exposed as theme properties for more control
            let hueShift = cos(phase + Double(index) * 0.3) * 0.15
            return shiftHue(of: color, by: hueShift)
        }
    }
    
    /// Shifts the hue of a color using native, efficient platform APIs.
    private func shiftHue(of color: Color, by amount: Double) -> Color {
        #if canImport(UIKit) || canImport(AppKit)
        let platformColor = PlatformColor(color)
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        platformColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        hue += CGFloat(amount)
        hue = hue.truncatingRemainder(dividingBy: 1.0)
        if hue < 0 { hue += 1.0 }
        
        return Color(hue: hue, saturation: saturation, brightness: brightness, opacity: alpha)
        #else
        // Fallback for platforms without UIKit or AppKit
        return color
        #endif
    }
}

// MARK: - Predefined Themes
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
            Color(red: 0.4, green: 0.2, blue: 0.6),    // Deep lavender
            Color(red: 0.6, green: 0.4, blue: 0.8),    // Light lavender
            Color(red: 0.2, green: 0.1, blue: 0.4),    // Night purple
            Color(red: 0.6, green: 0.4, blue: 0.8),    // Light lavender (repeat)
            Color(red: 0.4, green: 0.2, blue: 0.6),    // Deep lavender (repeat)
            Color(red: 0.2, green: 0.1, blue: 0.4),    // Night purple (repeat)
            Color(red: 0.2, green: 0.1, blue: 0.4),    // Night purple (repeat)
            Color(red: 0.4, green: 0.2, blue: 0.6),    // Deep lavender (repeat)
            Color(red: 0.6, green: 0.4, blue: 0.8)     // Light lavender (repeat)
        ]
    )

    static let moonlitViolet = MeshGradientColorTheme(
        meshColors: [
            // 4 moonlight colors: purple + blue
            Color(red: 0.3, green: 0.2, blue: 0.5),    // Moonlit purple
            Color(red: 0.2, green: 0.3, blue: 0.6),    // Night blue
            Color(red: 0.5, green: 0.4, blue: 0.8),    // Gentle purple
            Color(red: 0.2, green: 0.3, blue: 0.6),    // Night blue (repeat)
            Color(red: 0.1, green: 0.2, blue: 0.4),    // Deep night
            Color(red: 0.3, green: 0.2, blue: 0.5),    // Moonlit purple (repeat)
            Color(red: 0.5, green: 0.4, blue: 0.8),    // Gentle purple (repeat)
            Color(red: 0.3, green: 0.2, blue: 0.5),    // Moonlit purple (repeat)
            Color(red: 0.1, green: 0.2, blue: 0.4)     // Deep night (repeat)
        ]
    )

    static let twilightFlow = MeshGradientColorTheme(
        meshColors: [
            // 3 twilight colors for simplicity
            Color(red: 0.25, green: 0.1, blue: 0.4),   // Twilight purple
            Color(red: 0.35, green: 0.2, blue: 0.5),   // Evening purple
            Color(red: 0.15, green: 0.05, blue: 0.3),  // Deep twilight
            Color(red: 0.35, green: 0.2, blue: 0.5),   // Evening purple (repeat)
            Color(red: 0.25, green: 0.1, blue: 0.4),   // Twilight purple (repeat)
            Color(red: 0.15, green: 0.05, blue: 0.3),  // Deep twilight (repeat)
            Color(red: 0.15, green: 0.05, blue: 0.3),  // Deep twilight (repeat)
            Color(red: 0.35, green: 0.2, blue: 0.5),   // Evening purple (repeat)
            Color(red: 0.25, green: 0.1, blue: 0.4)    // Twilight purple (repeat)
        ]
    )

    static let auroraSleep = MeshGradientColorTheme(
        meshColors: [
            // 4 aurora colors: purple + teal
            Color(red: 0.2, green: 0.15, blue: 0.4),   // Aurora purple
            Color(red: 0.1, green: 0.3, blue: 0.35),   // Teal night
            Color(red: 0.4, green: 0.25, blue: 0.6),   // Soft aurora
            Color(red: 0.1, green: 0.3, blue: 0.35),   // Teal night (repeat)
            Color(red: 0.05, green: 0.25, blue: 0.3),  // Deep teal
            Color(red: 0.2, green: 0.15, blue: 0.4),   // Aurora purple (repeat)
            Color(red: 0.4, green: 0.25, blue: 0.6),   // Soft aurora (repeat)
            Color(red: 0.2, green: 0.15, blue: 0.4),   // Aurora purple (repeat)
            Color(red: 0.05, green: 0.25, blue: 0.3)   // Deep teal (repeat)
        ]
    )

    static let deepRest = MeshGradientColorTheme(
        meshColors: [
            // 3 deep rest colors for ultimate calm
            Color(red: 0.15, green: 0.1, blue: 0.25),  // Deep rest
            Color(red: 0.25, green: 0.2, blue: 0.35),  // Gentle sleep
            Color(red: 0.1, green: 0.05, blue: 0.2),   // Pure rest
            Color(red: 0.25, green: 0.2, blue: 0.35),  // Gentle sleep (repeat)
            Color(red: 0.15, green: 0.1, blue: 0.25),  // Deep rest (repeat)
            Color(red: 0.1, green: 0.05, blue: 0.2),   // Pure rest (repeat)
            Color(red: 0.1, green: 0.05, blue: 0.2),   // Pure rest (repeat)
            Color(red: 0.25, green: 0.2, blue: 0.35),  // Gentle sleep (repeat)
            Color(red: 0.15, green: 0.1, blue: 0.25)   // Deep rest (repeat)
        ]
    )

    static let lavenderDream = MeshGradientColorTheme(
        meshColors: [
            // 4 lavender tones for spa-like feel
            Color(red: 0.5, green: 0.4, blue: 0.7),    // Soft lavender
            Color(red: 0.6, green: 0.5, blue: 0.8),    // Light lavender
            Color(red: 0.4, green: 0.3, blue: 0.6),    // Medium lavender
            Color(red: 0.6, green: 0.5, blue: 0.8),    // Light lavender (repeat)
            Color(red: 0.7, green: 0.6, blue: 0.9),    // Pale lavender
            Color(red: 0.5, green: 0.4, blue: 0.7),    // Soft lavender (repeat)
            Color(red: 0.4, green: 0.3, blue: 0.6),    // Medium lavender (repeat)
            Color(red: 0.5, green: 0.4, blue: 0.7),    // Soft lavender (repeat)
            Color(red: 0.7, green: 0.6, blue: 0.9)     // Pale lavender (repeat)
        ]
    )

    static let sunnyGold = MeshGradientColorTheme(
        meshColors: [
            // 4 golden yellow colors for sunny warmth
            Color(red: 1.0, green: 0.84, blue: 0.0),   // Pure gold
            Color(red: 1.0, green: 0.92, blue: 0.23),  // Bright yellow
            Color(red: 0.85, green: 0.65, blue: 0.13), // Deep gold
            Color(red: 1.0, green: 0.92, blue: 0.23),  // Bright yellow (repeat)
            Color(red: 1.0, green: 0.96, blue: 0.56),  // Light golden
            Color(red: 1.0, green: 0.84, blue: 0.0),   // Pure gold (repeat)
            Color(red: 0.85, green: 0.65, blue: 0.13), // Deep gold (repeat)
            Color(red: 1.0, green: 0.84, blue: 0.0),   // Pure gold (repeat)
            Color(red: 1.0, green: 0.96, blue: 0.56)   // Light golden (repeat)
        ]
    )
    
    static let sunsetGlow = MeshGradientColorTheme(
        meshColors: [
            Color(red: 0.937, green: 0.349, blue: 0.192),
            Color(red: 0.925, green: 0.235, blue: 0.102),
            Color(red: 0.808, green: 0.027, blue: 0.333),
            Color(red: 0.925, green: 0.235, blue: 0.102),
            Color(red: 0.941, green: 0.498, blue: 0.353),
            Color(red: 0.937, green: 0.349, blue: 0.192),
            Color(red: 0.808, green: 0.027, blue: 0.333),
            Color(red: 0.925, green: 0.235, blue: 0.102),
            Color(red: 0.937, green: 0.349, blue: 0.192)
        ]
    )

    static let auroraBlush = MeshGradientColorTheme(
        meshColors: [
            // Hex palette: #BC82F3, #F5B9EA, #8D9FFF, #FF6778, #FFBA71, #C686FF
            Color(red: 0.74, green: 0.51, blue: 0.95),  // #BC82F3 (purple)
            Color(red: 0.96, green: 0.73, blue: 0.92),  // #F5B9EA (blush pink)
            Color(red: 0.55, green: 0.62, blue: 1.00),  // #8D9FFF (periwinkle)
            Color(red: 1.00, green: 0.40, blue: 0.47),  // #FF6778 (rose)
            Color(red: 1.00, green: 0.73, blue: 0.44),  // #FFBA71 (peach)
            Color(red: 0.78, green: 0.53, blue: 1.00),  // #C686FF (lavender)
            Color(red: 0.55, green: 0.62, blue: 1.00),  // #8D9FFF (periwinkle repeat)
            Color(red: 0.74, green: 0.51, blue: 0.95),  // #BC82F3 (purple repeat)
            Color(red: 1.00, green: 0.73, blue: 0.44)   // #FFBA71 (peach repeat)
        ]
    )
}
