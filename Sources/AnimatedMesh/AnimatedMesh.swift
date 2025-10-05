//
//  AnimatedMesh.swift
//  AnimatedMesh
//
//  Created by Armin on 10/5/25.
//

import SwiftUI

/// A SwiftUI view that renders an animated mesh gradient whose colors evolve over time,
/// driven by a provided `MeshGradientColorTheme`.
///
/// `AnimatedMesh` uses `TimelineView(.animation)` to refresh frames at the system's animation
/// cadence and feeds the current timestamp into the theme so it can produce smoothly changing
/// colors. The underlying gradient is drawn with `MeshGradient`, using the control points and
/// dimensions provided by the theme.
///
/// Use this view as a background or a full-screen decorative element to add dynamic,
/// themeable color motion to your interface.
///
/// Example:
/// ```swift
/// struct ContentView: View {
///     var body: some View {
///         ZStack {
///             // You can now create custom themes with different grid sizes
///             let customTheme = MeshGradientColorTheme(
///                 width: 4,
///                 height: 4,
///                 meshColors: [
///                     .blue, .purple, .cyan, .blue,
///                     .purple, .cyan, .blue, .purple,
///                     .cyan, .blue, .purple, .cyan,
///                     .blue, .purple, .cyan, .blue
///                 ]
///             )
///
///             AnimatedMesh(theme: .auroraBlush) // Or use your customTheme
///                 .ignoresSafeArea()
///
///             VStack {
///                 Text("Hello, Mesh!")
///                     .font(.largeTitle)
///                     .bold()
///                     .foregroundStyle(.white)
///             }
///         }
///     }
/// }
/// ```
///
/// - Important: Requires platforms that support `MeshGradient` in SwiftUI.
/// - SeeAlso: `MeshGradient`, `TimelineView`, `MeshGradientColorTheme`
///
/// - Parameters:
///   - theme: A `MeshGradientColorTheme` that supplies the mesh control points and a time-based
///            color palette via `animatedColors(for:)`.
///
/// - Accessibility: This view is purely decorative; consider marking it as hidden from
///   accessibility (`.accessibilityHidden(true)`) when used as a background.
public struct AnimatedMesh: View {
    public let theme: MeshGradientColorTheme
    
    public init(theme: MeshGradientColorTheme) {
        self.theme = theme
    }

    public var body: some View {
        TimelineView(.animation) { timeline in
            Rectangle()
                .fill(
                    MeshGradient(
                        width: theme.width,
                        height: theme.height,
                        points: theme.meshPoints,
                        colors: theme.animatedColors(for: timeline.date),
                        smoothsColors: true
                    )
                )
        }
    }
}

#Preview {
    AnimatedMesh(theme: .auroraBlush)
        .ignoresSafeArea()
}
