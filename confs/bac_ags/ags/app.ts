import { App, Astal } from "astal/gtk4"
import style from "./style.scss"
import Bar from "./src/index"
const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor
const { IGNORE } = Astal.Exclusivity
const { EXCLUSIVE } = Astal.Keymode
App.start({
	css: style,
	main() {
		App.get_monitors().map(Bar)

	},
})


//<WindowTitle />
//<Status />
