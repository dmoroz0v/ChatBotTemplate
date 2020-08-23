import Foundation
import ChatBotSDK

final class PickerOperationFlowAssembly: FlowAssembly {

    let initialHandlerId: String
    let inputHandlers: [String: FlowInputHandler]
    let action: FlowAction
    let context: Storable?

    init() {
        let pickerContext = PickerContext()

        let handler = PickerFlowInputHandler()
        handler.context = pickerContext

        let pickerAction = PickerOperationAction()
        pickerAction.context = pickerContext

        initialHandlerId = "pick"
        inputHandlers = ["pick" : handler]
        action = pickerAction
        context = pickerContext
    }

}

final class PickerContext: Storable {

    var page: Int = 1
    var text: String?

    func store() -> StorableContainer {
        let container =  StorableContainer()
        container.setString(value: text, key: "text")
        container.setInt(value: page, key: "page")
        return container
    }

    func restore(container: StorableContainer) {
        text = container.stringValue(key: "text")
        page = container.intValue(key: "page") ?? 1
    }

}

final class PickerOperationAction: FlowAction {

    var context: PickerContext?

    func execute(userId: Int64) -> [String] {
        if let text = context?.text {
            return ["You picked '\(text)'"]
        } else {
            return ["error"]
        }
    }

}

final class PickerFlowInputHandler: FlowInputHandler {

    var context: PickerContext?

    let items = [
        "item1",
        "item2",
        "item3",
        "item4",
        "item5",
        "item6",
        "item7",
        "item8",
    ]

    func markup(userId: Int64) -> FlowInputHandlerMarkup {
        var keyboard: ReplyKeyboardMarkup?
        if let context = context {
            keyboard = ChatBotSDK.ReplyKeyboardMarkup(
                keyboard: [
                    [
                        ChatBotSDK.KeyboardButton(text: items[(context.page - 1) * 4 + 0]),
                        ChatBotSDK.KeyboardButton(text: items[(context.page - 1) * 4 + 1])
                    ],
                    [
                        ChatBotSDK.KeyboardButton(text: items[(context.page - 1) * 4 + 2]),
                        ChatBotSDK.KeyboardButton(text: items[(context.page - 1) * 4 + 3])
                    ],
                    [
                        ChatBotSDK.KeyboardButton(text: "next")
                    ],
                ],
                resizeKeyboard: true,
                oneTimeKeyboard: true
            )
        }
        return FlowInputHandlerMarkup(texts: ["Pick item"], keyboard: keyboard, interrupt: false)
    }

    func handle(userId: Int64, text: String) -> FlowInputHandlerResult {

        if let context = context {

            if text == "next" {
                context.page += 1
            } else if text == "prev" {
                context.page -= 1
            }

            if text == "next" || text == "prev" {
                let keyboard = ReplyKeyboardMarkup(
                    keyboard: [
                        [
                            KeyboardButton(text: items[(context.page - 1) * 4 + 0]),
                            KeyboardButton(text: items[(context.page - 1) * 4 + 1])
                        ],
                        [
                            KeyboardButton(text: items[(context.page - 1) * 4 + 2]),
                            KeyboardButton(text: items[(context.page - 1) * 4 + 3])
                        ],
                        [
                            KeyboardButton(text: context.page == 2 ? "prev" : "next")
                        ],
                    ],
                    resizeKeyboard: true,
                    oneTimeKeyboard: true
                )

                let inputMarkup = FlowInputHandlerMarkup(
                    texts: ["Pick item"],
                    keyboard: keyboard,
                    interrupt: false
                )

                return .stay(markup: inputMarkup)
            }

            if !text.isEmpty {
                context.text = text
            }

        }

        return .end
    }

}
