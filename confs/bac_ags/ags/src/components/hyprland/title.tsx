import { bind } from "astal"
import { BaseProps } from "../../globals/baseProps"

export default function WindowTitle(props: BaseProps) {
	const focused = bind(props.hyprland, "focusedClient")

	return <box
		className="windowTitle"
		vertical={props.isVertical}
		visible={focused.as(Boolean)}>
		{focused.as(client => (
			client && <label label={bind(client, "title").as(String)} />
		))}
	</box>
}


