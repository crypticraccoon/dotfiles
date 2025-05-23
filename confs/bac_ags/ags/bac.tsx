import { Variable } from "astal";
import { App, Astal, Gdk, Gtk, hook } from "astal/gtk4";
import { WindowProps } from "astal/gtk4/widget";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import options from "../options";

const { TOP, BOTTOM } = Astal.WindowAnchor;
const APPPOSITION = TOP
const { barr } = options;
const hyprland = AstalHyprland.get_default();
const updateVisibility = () => {
	console.log("clinets: " + hyprland.get_workspace(hyprland.get_focused_workspace().id)?.get_clients()
		.length)
	return (
		hyprland.get_workspace(hyprland.get_focused_workspace().id)?.get_clients()
			.length <= 0
	);
};

export const barVisible = Variable(updateVisibility());


const exclusivity = Astal.Exclusivity.EXCLUSIVE
const widthVar = Variable(0);
const heightVar = Variable(0);
const getSize = (win: Gtk.Window) => win.get_child()!.get_preferred_size()[0];
const getHoverHeight = () => {
	const pos = barr.position.get() == "top" ? 0 : 2;
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
	const barWindow = App.get_window("bar");
	const size = getSize(barWindow!);

	widthVar.set(size!.width);
	heightVar.set(
		getHoverHeight() > size!.height ? size!.height : getHoverHeight(),
	);
}

function BarHover(gdkmonitor: Gdk.Monitor) {
	return (
		<window
			cssName={"bar-hover"}
			name={"bar-hover"}
			namespace={"bar-hover"}
			anchor={TOP}
			exclusivity={exclusivity}
			setup={
				(self) => {
					hook(self, App, "window-toggled", (_, win) => {
						if (win.name == "bar" && win.visible) {
							self.visible = false;
						}
					});
				}
			}
			onDestroy={() => barVisible.drop()}
			gdkmonitor={gdkmonitor}
			application={App}
			visible={barVisible((v: boolean) => !v)}
			onHoverEnter={() => {
				App.get_window("bar")!.set_visible(true);
			}}

			child={
				<box
					className={"bar-padding"}
					widthRequest={widthVar()}
					heightRequest={heightVar()}
					child={
						<label>
						</label>
					}
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
	)
}


type BarProps = WindowProps & {
	gdkmonitor: Gdk.Monitor;
	animation?: string;
};
function Bar({ ...props }: BarProps) {
	//const anchor = bar.position.get() == "top" ? TOP : BOTTOM;
	const anchor = TOP;

	return (
		<window
			visible={barVisible()}
			name={"bar"}
			namespace={"bar"}
			layer={Astal.Layer.TOP}
			anchor={anchor}

			onDestroy={() => barVisible.drop()}
			setup={(self) => {
				hook(self, App, "window-toggled", (_, win) => {
					if (win.name == "hover-hover" && win.visible) {
						self.visible = false;
					}
					if (win.name == "bar") {
						const size = getSize(win);
						heightVar.set(
							getHoverHeight() > size!.height ? size!.height : getHoverHeight(),
						);
						widthVar.set(size!.width);
					}
				});
			}}
			application={App}
			onHoverLeave={() => {
				console.log(!updateVisibility())
				if (!updateVisibility()) {
					App.get_window("bar-hover")!.set_visible(true);
				}
			}}
			child={
				< box >
					<box hexpand />


					<label>
						asdasalsdnlasnd lakndlkan cvlzxcnvjkzdbgahdfi
					</label>

					<box hexpand />
				</ box>

			}

			{...props}
		>
		</window>
	);
}
//const sendBatch = (batch: string[]) => {
//const cmd = batch
//.filter((x) => !!x)
//.map((x) => `keyword ${x}`)
//.join("; ");

//hyprland.message(`[[BATCH]]/${cmd}`);
//};
export default function(gdkmonitor: Gdk.Monitor) {
	<Bar gdkmonitor={gdkmonitor} animation={`slide topp`} />;
	barVisible
		.observe(hyprland, "notify::clients", () => {
			return updateVisibility();
		})
		.observe(hyprland, "notify::focused-workspace", () => {
			return updateVisibility();
		});
	BarHover(gdkmonitor);
	setHoverSize();

	barr.position.subscribe(() => {
		barVisible.drop();
		const barW = App.get_window("bar")!;
		barW.set_focus_child(null); //barW.set_child(null);
		barW.destroy();
		<Bar gdkmonitor={gdkmonitor} animation={`slide $bar.position.get()`} />;
		const barHover = App.get_window("bar-hover")!;
		barHover.set_focus_child(null); //barHover.set_child(null);
		barHover.destroy();
		setHoverSize();
		barVisible
			.observe(hyprland, "notify::clients", () => {
				return updateVisibility();
			})
			.observe(hyprland, "notify::focused-workspace", () => {
				return updateVisibility();
			});
	});
	BarHover(gdkmonitor);
	windowAnimation();
}

const sendBatch = (batch: string[]) => {
	const cmd = batch
		.filter((x) => !!x)
		.map((x) => `keyword ${x}`)
		.join("; ");

	hyprland.message(`[[BATCH]]/${cmd}`);
};


function windowAnimation() {
	sendBatch(
		App.get_windows()
			.filter(({ animation }: any) => !!animation)
			.map(
				({ animation, namespace }: any) =>
					`layerrule animation ${namespace == "dock" ? `slide ${APPPOSITION}` : animation == "slide top" ? `slide ${APPPOSITION}` : animation}, ${namespace}`,
			),
	);
}
