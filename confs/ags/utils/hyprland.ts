import AstalHyprland from "gi://AstalHyprland?version=0.1";

const hyprland = AstalHyprland.get_default();
export const UpdateFocusedClient = () => {
	return (
		hyprland.get_focused_client().get_title()

	);
};


