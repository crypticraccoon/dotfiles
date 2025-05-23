import { Astal, Gdk } from "astal/gtk4";

export default function Bar(gdkmonitor: Gdk.Monitor) {
	return <window
		gdkmonitor={gdkmonitor}
		monitor={0}
		anchor={Astal.WindowAnchor.TOP}
		exclusivity={Astal.Exclusivity.EXCLUSIVE}
		child={
			<label label={"asd"} ></label>
		}
	/>
}
