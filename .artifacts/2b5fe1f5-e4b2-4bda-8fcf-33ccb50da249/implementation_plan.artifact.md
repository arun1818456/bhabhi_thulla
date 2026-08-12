# Responsive Friends Screen Implementation Plan

The user wants to make the "Add Friend" card responsive as it currently has fixed dimensions that might cause issues on different screen sizes.

## Proposed Changes

### [Friends Screen](file:///Users/sequoia/node.a/dummy_p/lib/modules/friends/friends_screen.dart)
- **Use `LayoutBuilder`**: Wrap the right-side "Add Friend" card in a `LayoutBuilder` to make internal sizes (like the avatar and spacing) relative to the available space.
- **Dynamic Avatar Sizing**: Instead of a fixed `100x100` container, make the avatar size a percentage of the available height or width (whichever is smaller).
- **Flexible Spacing**: Use `Spacer` or `Flexible` instead of fixed `SizedBox` where possible to allow the UI to contract on smaller screens.
- **Scrollable Result Area**: Wrap the search result in a `SingleChildScrollView` to prevent overflow if the content exceeds the vertical space on small devices.
- **Responsive Text**: Adjust `fontSize` based on screen constraints if necessary.

## Verification Plan

### Manual Verification
- Test the Friends screen on different device sizes (simulated or real).
- Verify that the "Add Friend" card does not overflow vertically or horizontally.
- Ensure that the search result (avatar, name, button) remains visible and well-aligned even on smaller screens.
- Check that the search frame looks consistent in both landscape and portrait orientations (if applicable).
