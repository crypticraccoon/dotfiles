import { App, Astal, Gdk, Gtk, hook } from "astal/gtk4";
import { WindowProps } from "astal/gtk4/widget";
import Hyprland from "gi://AstalHyprland"

const hyprland = Hyprland.get_default()
const dock = {
	position: "bottom",
	pinned: ["firefox", "Alacritty", "org.gnome.Nautilus", "localsend"],
};
const updateVisibility = () => {
	return (
		hyprland.get_workspace(hyprland.get_focused_workspace().id)?.get_clients()
			.length <= 0
	);
};

const widthVar: number = 0;
const heightVar: number = 0;
const dockVisible: boolean = updateVisibility();
const { LEFT, TOP, BOTTOM, RIGHT } = Astal.WindowAnchor


const getSize = (win: Gtk.Window) => win.get_child()!.get_preferred_size()[0];
const getHoverHeight = () => {
	const pos = dock.position.get() == "top" ? 0 : 2;
	const hyprlandGapsOut = hyprland
		.message("getoption general:gaps_out")
		.split("\n")[0]
		.split("custom type: ")[1]
		.split(" ")
		.map((e) => parseInt(e));
	return hyprlandGapsOut.length >= 3
		? hyprlandGapsOut[pos]
		: hyprlandGapsOut[0];
};

function setHoverSize() {
}

function DockHover(_gdkmonitor: Gdk.Monitor) {
	const anchor = TOP | LEFT | RIGHT;

	return (
		<window
			visible={!dockVisible}
			name={"dock-hover"}
			namespace={"dock-hover"}
			setup={(self) => {
				hook(self, App, "window-toggled", (_, win) => {
					if (win.name == "dock" && win.visible) {
						self.visible = false;
					}
				});
			}}
			//onDestroy={() => dockVisible.drop()}
			layer={Astal.Layer.TOP}
			anchor={anchor}
			application={App}
			onHoverEnter={() => {
				App.get_window("dock")!.set_visible(true);
			}}
			child={
				<box
					//cssClasses={["dock-padding"]}
					widthRequest={widthVar}
					heightRequest={heightVar}
				>
					{/* I dont know why window/box not visible when there's no child/background-color */}
					{/* So I give this child and set it to transparent so I can detect hover */}
					{/* might be gtk4-layer-shell bug, idk */}
					{
						//placeholder
					}
				</box>
			}
		>
		</window>
	);
}
type DockProps = WindowProps & {
	gdkmonitor: Gdk.Monitor;
	animation?: string;
};
function Dock({ gdkmonitor, ...props }: DockProps) {
	const anchor = dock.position.get() == "top" ? TOP : BOTTOM;

	return (
		<window
			visible={dockVisible()}
			name={"dock"}
			namespace={"dock"}
			layer={Astal.Layer.TOP}
			anchor={anchor}
			onDestroy={() => dockVisible.drop()}
			setup={(self) => {
				hook(self, App, "window-toggled", (_, win) => {
					if (win.name == "dock-hover" && win.visible) {
						self.visible = false;
					}
					if (win.name == "dock") {
						const size = getSize(win);
						heightVar.set(
							getHoverHeight() > size!.height ? size!.height : getHoverHeight(),
						);

						widthVar.set(size!.width);
					}
				});
			}}
			onHoverLeave={() => {
				if (!updateVisibility()) {
					App.get_window("dock-hover")!.set_visible(true);
				}
			}}
			application={App}
			child={
				<box>
					<box hexpand />
					<>
						{ //<DockApps />
						}
						<label>asdasd </label>
					</>
					<box hexpand />
				</box>

			}
			{...props}
		>
		</window>
	);
}
