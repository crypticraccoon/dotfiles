pragma Singleton
import QtQuick

QtObject {
    // Material Design 3 Color Tokens
    // Based on primary color #5c6bc0 (Indigo 400)
    // Generated using Material Design color science
    
    // Primary colors (Indigo - main theme color)
    readonly property color primary: "#5c6bc0"              // Primary indigo
    readonly property color primaryText: "#ffffff"            // White text on primary
    readonly property color primaryContainer: "#dee1ff"     // Light indigo container
    readonly property color primaryTextContainer: "#001551"   // Dark text on container
    
    // Secondary colors (Teal/Cyan - complementary to indigo)
    readonly property color secondary: "#00bcd4"            // Cyan 500 (complementary)
    readonly property color textSecondary: "#ffffff"          // White text on secondary
    readonly property color secondaryContainer: "#b2ebf2"   // Light cyan container
    readonly property color textSecondaryContainer: "#00363a" // Dark text on container
    
    // Tertiary colors (Amber - analogous warm accent)
    readonly property color tertiary: "#ffc107"             // Amber 500
    readonly property color textTertiary: "#3e2d00"           // Dark text on tertiary
    readonly property color tertiaryContainer: "#ffecb3"    // Light amber container
    readonly property color textTertiaryContainer: "#5b4300"  // Dark text on container
    
    // Error colors (Red)
    readonly property color error: "#ef5350"                // Red 400
    readonly property color textError: "#ffffff"              // White text on error
    readonly property color errorContainer: "#ffcdd2"       // Light red container
    readonly property color textErrorContainer: "#410002"     // Dark text on container
    
    // Surface colors (Dark theme backgrounds)
    readonly property color surface: "#101010"              // Very dark background
    readonly property color textSurface: "#e3e3e3"           // Light text on surface
    readonly property color surfaceVariant: "#262626"       // Slightly lighter surface
    readonly property color textSurfaceVariant: "#9e9e9e"    // Medium text on variant
    readonly property color surfaceDim: "#19191a"          // Dimmed surface
    readonly property color surfaceBright: "#3f3f3f"       // Bright surface
    
    // Outline colors
    readonly property color outline: "#404040"              // Border color
    readonly property color outlineVariant: "#606060"       // Lighter border
    
    // Background colors
    readonly property color background: "#101010"           // Main background
    readonly property color textBackground: "#e3e3e3"        // Text on background
    
    // Success color (Green - Material success)
    readonly property color success: "#66bb6a"              // Green 400
    readonly property color successText: "#ffffff"          // White text on success
    
    // Warning color (Orange)
    readonly property color warning: "#ff9800"              // Orange 500
    readonly property color warningText: "#ffffff"          // White text on warning
    
    // Info color (Light Blue)
    readonly property color info: "#29b6f6"                 // Light Blue 400
    readonly property color infoText: "#ffffff"             // White text on info
    
    // Disabled/inactive states
    readonly property color disabled: "#606060"             // Disabled elements
    readonly property color inactive: "#9e9e9e"            // Inactive elements
    
    // Text emphasis levels (for easy reference)
    readonly property color textHighEmphasis: "#f0f0f0"    // Primary text (highest emphasis)
    readonly property color textMediumEmphasis: "#e3e3e3"  // Secondary text (medium emphasis)
    readonly property color textLowEmphasis: "#9e9e9e"     // Tertiary text (low emphasis)
    readonly property color textDisabled: "#606060"         // Disabled text
    
    // Accent colors for specific widgets (Material Design complementary palette)
    readonly property color accentVolume: "#00bcd4"         // Cyan for volume (cool, audio-related)
    readonly property color accentBrightness: "#ffc107"     // Amber for brightness (warm, light-related)
    readonly property color accentBattery: "#66bb6a"        // Green for battery (success/energy)
    readonly property color accentPower: "#7e57c2"          // Deep purple for power profiles
    
    // State-specific colors
    readonly property color stateHover: "#7986cb"           // Lighter indigo for hover (primary + 20% lighter)
    readonly property color statePressed: "#3f51b5"         // Darker indigo for pressed (primary + 20% darker)
    readonly property color stateActive: "#5c6bc0"          // Primary color for active state
    readonly property color stateInactive: '#d7cfcf'        // Dark gray for inactive
    
    // Overlay colors (with alpha for transparency)
    readonly property color overlayLight: "#ffffff1a"       // 10% white overlay
    readonly property color overlayDark: "#0000001a"        // 10% black overlay
    readonly property color scrim: "#00000080"              // 50% black scrim
}