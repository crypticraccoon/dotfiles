import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import { bind, timeout, Variable } from "astal"
import AstalHyprland from "gi://AstalHyprland?version=0.1";
import { FocusedClient, Workspaces } from "./hyprland";
import { SystemTray } from "./tray";




const hyprland = AstalHyprland.get_default();


const updateVisibility = () => {
	return (

		hyprland.get_workspace(hyprland.get_focused_workspace().id)?.get_clients()
			.length <= 0
	);
};

export const barVisible = Variable(updateVisibility());


export default function Bar(gdkmonitor: Gdk.Monitor) {
	const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

	let isShowed = Variable(false)
	isShowed.subscribe(() => {
		console.log("tr")
	})
	return <window
		visible
		marginTop={10}
		marginLeft={20}
		marginRight={20}

		cssClasses={["Bar"]}
		gdkmonitor={gdkmonitor}
		exclusivity={Astal.Exclusivity.EXCLUSIVE}
		anchor={TOP | LEFT | RIGHT}
		application={App}
		onHoverEnter={() => {
			console.log(barVisible.get())
			if (!barVisible.get()) {
				console.log("ohuiad")
				isShowed.set(true)
			}
			//else {
			//isShowed.set(false)

			//}
		}}
		onHoverLeave={() => {
			if (barVisible.get()) {
				isShowed.set(false)
			}
		}}
		child={
			< revealer
				setup={self => timeout(500, () => self.revealChild = true)}
				transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
				revealChild={isShowed(() => isShowed.get())}
				child={
					< Centerbox />
				}
			>
			</revealer >

		}
	/>
}

function Centerbox() {
	return <centerbox
		name={"main"}
		cssClasses={["main"]}

		startWidget={

			<box
				children={
					[
						<Workspaces />,
						<FocusedClient />
					]
				}
			/>
		}
		//centerWidget={null}
		endWidget={
			<SystemTray />
		}
	/>
}


