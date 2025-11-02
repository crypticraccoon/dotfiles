# Optical Roundness Implementation

## Overview
This document explains the optical roundness implementation following Material Design 3 guidelines for nested rounded objects.

## Principle
When nesting rounded objects, using the same corner radius for both outer and inner elements creates visual imbalance. The corners appear too thick or heavy.

**Formula**: `Inner radius = Outer radius - Padding`

## Implementation

### 1. WidgetStyle.qml
Added calculated inner corner radius:
```qml
readonly property int cornerRadius: 4
readonly property int innerCornerRadius: Math.max(0, cornerRadius - contentMargin)
// Result: 4 - 4 = 0 (sharp corners for inner elements)
```

### 2. Widgets Updated

#### PowerProfileWidget.qml
- **Outer background**: `radius: 4px`
- **Inner slider indicator**: `radius: 0px` (sharp corners)
- **Padding**: `contentMargin: 4px`
- **Result**: Optically balanced nested rectangles

#### BrightnessWidget.qml
- **Outer slider track**: `radius: 30px`
- **Inner fill indicator**: `radius: 26px`
- **Implicit padding**: `4px`
- **Result**: Proportional corner radii (30 - 4 = 26)

#### FloatingOSD.qml
- **Outer background**: `radius: 4px`
- **Inner growing bar**: `radius: 0px` (sharp corners)
- **Padding**: `contentMargin: 4px`
- **Result**: Clean, balanced OSD appearance

#### BatteryWidget.qml
- Single-level widget (no nested rounded elements)
- Uses standard `cornerRadius: 4px`
- No optical roundness needed

#### ClockWidget.qml
- Single-level widget (no nested rounded elements)
- Uses asymmetric corners (left: 4px, right: pill-shaped)
- No optical roundness needed

## Visual Benefits

### Before (Same Radius)
- ❌ Corners appear thick and heavy
- ❌ Visual imbalance in nested elements
- ❌ Less refined appearance

### After (Optical Roundness)
- ✅ Corners appear optically balanced
- ✅ Professional, polished look
- ✅ Follows Material Design 3 guidelines
- ✅ Better visual hierarchy

## Usage Guidelines

1. **Always calculate inner radius** when nesting rounded rectangles
2. **Use the formula**: `outer_radius - padding = inner_radius`
3. **Minimum value**: Use `Math.max(0, calculation)` to prevent negative radii
4. **Single-level widgets**: Use standard `cornerRadius` directly
5. **Document the calculation**: Add comments explaining the optical roundness

## References
- Material Design 3: Rounded Corners
- Optical Roundness Principle: Proportional corner radii for nested objects