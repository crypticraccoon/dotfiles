import Battery from "gi://AstalBattery"
import { bind, Variable } from "astal"



export default function BatteryPercentage() {
	const bat = Battery.get_default()
	//const state = Battery.State.

	//const icon = 
	let x = batteryStatus(bat.state)


	const time = Variable(x).poll(1000, "date")

	return <label label={time.toString()} />
	//return <label label={bind(bat, "percentage").as((p) => p * 100 + " %")}  />
}


function batteryStatus(state: Battery.State) {
	switch (state) {
		case Battery.State.DISCHARGING: return "yes";
		default: return "no";
	}
}
