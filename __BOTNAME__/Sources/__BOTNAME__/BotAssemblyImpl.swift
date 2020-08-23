import Foundation
import ChatBotSDK

public final class BotAssemblyImpl: BotAssembly {

    public var commandsHandlers: [CommandHandler] = [

        CommandHandler(
            command: Command(value: "/cancel"),
            description: "Cancel current operation",
            flowAssembly: CancelOperationFlowAssembly()
        ),

        CommandHandler(
            command: Command(value: "/revert"),
            description: "Revert string",
            flowAssembly: RevertOperationFlowAssembly()
        ),

        CommandHandler(
            command: Command(value: "/pick"),
            description: "Pick item",
            flowAssembly: PickerOperationFlowAssembly()
        ),

    ]

    public init() {
    }

}
