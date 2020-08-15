import Foundation
import __BOTNAME__
import TgBotSDK

struct Config: Decodable {
    let telegram_bot_token: String
}

let urlConfig = Bundle.main.url(forResource: "config", withExtension: "json")!
let config = try! JSONDecoder().decode(Config.self, from: Data(contentsOf: urlConfig))

let b = TgBotSDK.Bot(
    flowStorage: try! FlowStorageImpl(),
    botAssembly: BotAssemblyImpl(),
    token: config.telegram_bot_token,
    apiEndpoint: "https://api.telegram.org/bot")

DispatchQueue.global().async {
    while true {
        b.handleUpdates()
    }
}

dispatchMain()
