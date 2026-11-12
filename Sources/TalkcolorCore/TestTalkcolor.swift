import Foundation

@main
struct TestTalkcolor {
    static func main() {
        let manager = CommunicationManager()

        print("💜 TALKCOLOR")
        print("Minha voz, minhas cores.\n")

        for message in TalkcolorLibrary.messages {
            print("\(message.id). \(message.symbol) \(message.text)")
        }

        print("\nSelecione uma mensagem:")

        if let input = readLine(),
           let id = Int(input),
           let message = manager.selectMessage(id: id) {
            print("\nMensagem selecionada:")
            print("\(message.symbol) \(message.text)")
            print("Categoria: \(message.category.rawValue)")
        } else {
            print("Opção inválida.")
        }
    }
}
