import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import { GLib, Variable, bind } from "astal"
import Hyprland from "gi://AstalHyprland"

const time = Variable("").poll(1000, "date")

const hyprland = Hyprland.get_default()
const isVertical: boolean = false
const { LEFT, TOP, BOTTOM, RIGHT } = Astal.WindowAnchor
const horizontalBarAnchor = TOP | LEFT | RIGHT
const verticalBarAnchor = LEFT | TOP | BOTTOM


export default function Bar(gdkmonitor: Gdk.Monitor) {

	return <window

		className="Bar"
		gdkmonitor={gdkmonitor}
		exclusivity={Astal.Exclusivity.IGNORE}
		anchor={isVertical ? verticalBarAnchor : horizontalBarAnchor}
		application={App}
		margin={25}

		child={
			<centerbox
				vertical={isVertical}
				child={
					<MyButton/>
				}
			>
			</centerbox >

		}
	>


	</window >
}

function MyButton(): JSX.Element {
	return <button onClicked="echo hello"
		child={
			<label label="Click me!" />
		}
	>
	</button>
}
function Foo() {
	return <box
		child={

			<label>
				asd
			</label>

		}>
	</box>
}
function Workspace() {

	return <box className="workspaces" vertical={isVertical}>
		{bind(hyprland, "workspaces").as((wss: any) => wss
			.sort((a: any, b: any) => a.id - b.id)
			.map((ws: any) => (
				<button
					className={bind(hyprland, "focusedWorkspace").as((fw: any) =>
						ws === fw ? "focused" : "")}
					onClicked={() => ws.focus()}

					child={

						<label>
							{ws.id}
						</label>
					}
				>
				</button>
			))
		)}
	</box>
}
function WindowTitle() {
	const focused = bind(hyprland, "focusedClient")

	return <box
		className="windowTitle"
		vertical={isVertical}
		visible={focused.as(Boolean)}

		child=
		{
			focused.as(client => (
				client && <label label={bind(client, "title").as(String)} />
			))
		}
	>
	</box >
}


function Status() {
	return <box
		expand
		className="status"
		vertical={isVertical}>
		<BatteryWidget />
		<NetworkWidget />
		<Time />
		<Date />

	</box>
}


function Time({ format = "%I:%M %p" }) {
	const time = Variable<string>("").poll(1000, () =>
		GLib.DateTime.new_now_local().format(format)!)
	return <label
		className="time"
		onDestroy={() => time.drop()}
		label={time()}
	/>
}

function Date({ format = " %a  %d %b %y " }) {
	const date = Variable<string>("").poll(36000, () =>
		GLib.DateTime.new_now_local().format(format)!)

	return <label
		className="date"
		onDestroy={() => date.drop()}
		label={date()}
	/>

}
import Battery from "gi://AstalBattery"

function BatteryWidget() {
	let battery = Battery.get_default()
	return <box>
		<icon icon={battery.battery_icon_name} />
		<label label={`${String(battery.percentage).split(".")[1]}%`} /></box>
}
function Tempreture() { }
function Memory() { }
function CpuUsage() { }
function Brightness() { }
function Volume() { }

import Network from "gi://AstalNetwork"

const network = Network.get_default()

function NetworkWidget() {
	let x = network.wifi
	console.log(x)
	//<icon icon={network.wifi.get_icon_name()} />
	//<label label={`${String(network.wifi.bandwidth).split(".")[1]}%`} />
	return <box vertical={isVertical}>
	</box>
}







