pragma Singleton
import QtQuick

QtObject {
    // Spacing constants for consistent widget inlay
    readonly property int outerMargin: 2      // Margin for background Rectangle
    readonly property int buttonPadding: 6    // Padding for Button (used in wrapped widgets)
    readonly property int innerMargin: 10     // Margin for contentItem (for non-wrapped widgets)
    readonly property int contentMargin: 4    // Margin for contentItem (for wrapped widgets)
    readonly property int widgetSpacing: 1    // Spacing between widgets in the panel
    
    // Corner radius with optical roundness support
    readonly property int cornerRadius: 4
    
    // Optical roundness: inner radius = outer radius - padding
    // For contentMargin (4px): 4 - 4 = 0 (sharp corners for inner elements)
    readonly property int innerCornerRadius: Math.max(0, cornerRadius - contentMargin)
    
    // Semantic color mapping from ColorScheme
    readonly property color normalColor: ColorScheme.surfaceVariant
    readonly property color hoverColor: ColorScheme.primary
    readonly property color pressedColor: ColorScheme.surfaceDim
    readonly property color sliderIndicatorColor: ColorScheme.primary
    
    // Text colors
    readonly property color activeTextColor: ColorScheme.textMediumEmphasis
    readonly property color inactiveTextColor: ColorScheme.textLowEmphasis
    readonly property color primaryTextColor: ColorScheme.textHighEmphasis

    // Icon colors
    readonly property color activeIconColor: ColorScheme.textMediumEmphasis
    readonly property color inactiveIconColor: ColorScheme.textLowEmphasis
    readonly property color disabledIconColor: ColorScheme.disabled
    
    // Animation
    readonly property int colorTransitionDuration: 200
    
    // Typography
    readonly property string fontFamily: "Roboto"
}