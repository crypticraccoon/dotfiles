import { Variable } from "astal";
import { App, Astal, Gtk } from "astal/gtk4";
import options from "../options";
import AstalHyprland from "gi://AstalHyprland?version=0.1";
const { barr } = options;

export const exclusivity = Astal.Exclusivity.IGNORE

export const widthVar = Variable(0);

export const heightVar = Variable(0);

export const getSize = (win: Gtk.Window) => win.get_child()!.get_preferred_size()[0];

export const getHoverHeight = (hyprland: AstalHyprland.Hyprland) => {
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

export function setHoverSize(hyprland: AstalHyprland.Hyprland) {
	const barWindow = App.get_window("bar");
	const size = getSize(barWindow!);

	widthVar.set(size!.width);
	heightVar.set(
		getHoverHeight(hyprland) > size!.height ? size!.height : getHoverHeight(hyprland),
	);
}



export const sendBatch = (batch: string[], hyprland: AstalHyprland.Hyprland) => {
	const cmd = batch
		.filter((x) => !!x)
		.map((x) => `keyword ${x}`)
		.join("; ");

	hyprland.message(`[[BATCH]]/${cmd}`);
};


export function windowAnimation(pos: Astal.WindowAnchor, hyprland: AstalHyprland.Hyprland) {
	sendBatch(
		App.get_windows()
			.filter(({ animation }: any) => !!animation)
			.map(
				({ animation, namespace }: any) =>
					`layerrule animation ${namespace == "dock" ? `slide ${pos}` : animation == "slide top" ? `slide ${pos}` : animation}, ${namespace}`,
			),
		hyprland
	);
}
