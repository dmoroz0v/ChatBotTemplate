import Foundation
import ChatBotSDK

class SayOperationFlowAssembly: FlowAssembly {

    let inputHandlers: [FlowInputHandler]
    let action: FlowAction
    let context: Storable?

    init() {
        let sayContext = SayContext()

        let handler = SayFlowInputHandler()
        handler.context = sayContext


        let sayAction = SayOperationAction()
        sayAction.context = sayContext

        inputHandlers = [handler]
        action = sayAction
        context = sayContext
    }

}

class SayContext: Storable {

    var text: String?

    func store() -> StorableContainer {
        let container =  StorableContainer()
        container.setString(value: text, key: "text")
        return container
    }

    func restore(container: StorableContainer) {
        text = container.stringValue(key: "text")
    }

}

class SayOperationAction: FlowAction {

    var context: SayContext?

    func execute(userId: Int64) -> [String] {
        return [context?.text ?? "error"]
    }

}

class SayFlowInputHandler: FlowInputHandler {

    var context: SayContext?

    func markup(userId: Int64) -> FlowInputHandlerMarkup {
        return FlowInputHandlerMarkup(texts: ["Type text"])
    }

    func handle(userId: Int64, text: String) {
        context?.text = text
    }

}

public final class BotAssemblyImpl: BotAssembly {

    public var commandsHandlers: [CommandHandler] = [

        CommandHandler(
            command: Command(value: "/cancel"),
            description: "Cancel current operation",
            flowAssembly: CancelOperationFlowAssembly()
        ),

        CommandHandler(
            command: Command(value: "/say"),
            description: "Say",
            flowAssembly: SayOperationFlowAssembly()
        ),

    ]

    public init() {
    }

}
