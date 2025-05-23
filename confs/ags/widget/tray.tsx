import { bind, GLib, Variable } from "astal"
import AstalBattery from "gi://AstalBattery?version=0.1"
import AstalBluetooth from "gi://AstalBluetooth?version=0.1"

export function SystemTray() {
	return <box

		children={
			[
				<BatteryLevel />,
				<Time />
			]
		}
	/>
}

function x() {
	const bt = AstalBluetooth.get_default()
	bind(bt, "devices").as((e) => { console.log(e.toString()) })
}

function Time() {
	x()
	const time = Variable<string>("").poll(1000, () =>
		GLib.DateTime.new_now_local().format("%I:%M")!)

	const date = Variable<string>("").poll(1000, () =>
		GLib.DateTime.new_now_local().format("%A %e %Y")!)

	return <box
		cssClasses={["trayBox"]}
		child={
			<label
				tooltipText={date()}
				cssClasses={["Time"]}
				onDestroy={() => { time.drop(); date.drop() }}
				label={time()}
			/>} />
}

function BatteryLevel() {
	const bat = AstalBattery.get_default()



	return <box
		cssClasses={["Battery"]}
		visible={bind(bat, "isPresent")}
		children={
			[

				<label
					label={
						bind(bat, "iconName").as(p => {
							console.log(p)
							return p
						}
						)
					} />,
				<label
						
					label={
						bind(bat, "percentage").as(p =>
							`${Math.floor(p * 100)} %`
						)
					} />
			]

		}
	>
	</box >
}
//icon={bind(bat, "batteryIconName")} 

