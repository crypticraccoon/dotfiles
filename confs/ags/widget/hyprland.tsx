import { bind, Binding } from "astal";
import AstalHyprland from "gi://AstalHyprland?version=0.1";

const hyprland = AstalHyprland.get_default();

export function Workspaces() {
	return <box
		children={
			bind(hyprland, "workspaces").as((wss) =>
				wss
					.sort((a, b) => a.id - b.id)
					.map((ws) => (
						<button
							cssClasses={bind(hyprland, "focusedWorkspace").as((fw) =>
								ws === fw
									? ["workspace-buttons", "active"]
									: ["workspace-buttons"],
							)}
							onClicked={() => ws.focus()}
							label={ws.id.toString()} />
					)),
			)

		}
	/>
}


export function FocusedClient() {
	const focused = bind(hyprland, "focusedClient")
	return <box
		cssClasses={["Focused"]}
		visible={focused.as(Boolean)}

		child={
			focused.as(client => {
				let title: Binding<string> = bind(client, "title").as((e) => {
					return e.toString().length > 35 ? e.toString().slice(0, 50) + "..." : e
				})
				return client && <label
					label={(title)} />
			})
		}
	/>
}
