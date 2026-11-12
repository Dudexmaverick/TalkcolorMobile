import Foundation

final class CommunicationManager {

    private(set) var selectedMessage: CommunicationMessage?

    func selectMessage(id: Int) -> CommunicationMessage? {

        guard let message = TalkcolorLibrary.messages.first(
            where: { $0.id == id }
        ) else {
            return nil
        }

        selectedMessage = message
        return message
    }

    func messages(
        in category: CommunicationCategory
    ) -> [CommunicationMessage] {

        TalkcolorLibrary.messages.filter {
            $0.category == category
        }
    }

    func clearSelection() {
        selectedMessage = nil
    }
}
