
func searchMessages(query: String) -> [CommunicationMessage] {
    let search = query.trimmingCharacters(
        in: .whitespacesAndNewlines
    )

    guard !search.isEmpty else {
        return TalkcolorLibrary.messages
    }

    return TalkcolorLibrary.messages.filter {
        $0.text.localizedCaseInsensitiveContains(search)
        || $0.category.rawValue.localizedCaseInsensitiveContains(search)
    }
}
