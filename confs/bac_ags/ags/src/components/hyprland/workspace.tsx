import { bind } from "astal"
import { BaseProps } from "../../globals/baseProps"


export default function Workspace(props: BaseProps) {

	return <box className="workspaces" vertical={props.isVertical}>
		{bind(props.hyprland, "workspaces").as((wss: any) => wss
			.sort((a: any, b: any) => a.id - b.id)
			.map((ws: any) => (
				<button
					className={bind(props.hyprland, "focusedWorkspace").as((fw: any) =>
						ws === fw ? "focused" : "")}
					onClicked={() => ws.focus()}>
					{ws.id}
				</button>
			))
		)}
	</box>
}
