import Foundation

enum CommunicationCategory: String, CaseIterable {
    case food = "Alimentação"
    case needs = "Necessidades"
    case emotions = "Emoções"
    case social = "Interação"
}

struct CommunicationMessage: Identifiable {
    let id: Int
    let symbol: String
    let text: String
    let category: CommunicationCategory
    let color: String
}

struct TalkcolorLibrary {

    static let messages: [CommunicationMessage] = [

        CommunicationMessage(
            id: 1,
            symbol: "🍎",
            text: "Estou com fome",
            category: .food,
            color: "#FFB347"
        ),

        CommunicationMessage(
            id: 2,
            symbol: "💧",
            text: "Estou com sede",
            category: .food,
            color: "#64B5F6"
        ),

        CommunicationMessage(
            id: 3,
            symbol: "🚻",
            text: "Preciso ir ao banheiro",
            category: .needs,
            color: "#BA68C8"
        ),

        CommunicationMessage(
            id: 4,
            symbol: "❤️",
            text: "Preciso de ajuda",
            category: .needs,
            color: "#EF5350"
        ),

        CommunicationMessage(
            id: 5,
            symbol: "😊",
            text: "Estou feliz",
            category: .emotions,
            color: "#FFD54F"
        ),

        CommunicationMessage(
            id: 6,
            symbol: "😢",
            text: "Estou triste",
            category: .emotions,
            color: "#90CAF9"
        ),

        CommunicationMessage(
            id: 7,
            symbol: "🤗",
            text: "Quero um abraço",
            category: .social,
            color: "#F48FB1"
        )
    ]
}
