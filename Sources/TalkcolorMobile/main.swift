
import Gtk

let status = Application.run(startupHandler: nil) { app in

    // Janela principal
    let window = ApplicationWindowRef(application: app)
    window.title = "Talkcolor — Minha voz, minhas cores"
    window.setDefaultSize(width: 600, height: 500)

    // Organização principal
    let layout = BoxRef(
        orientation: .vertical,
        spacing: 12
    )

    // Cabeçalho
    let title = LabelRef(str: "💜 TALKCOLOR")
    layout.append(child: title)

    let subtitle = LabelRef(
        str: "Minha voz, minhas cores"
    )
    layout.append(child: subtitle)

    let instruction = LabelRef(
        str: "O que você precisa comunicar?"
    )
    layout.append(child: instruction)

    // Área da mensagem selecionada
    let result = LabelRef(
        str: "Escolha uma mensagem"
    )

    // Mensagens disponíveis
    let messages: [(String, String)] = [
        ("🍎 Estou com fome", "Estou com fome"),
        ("💧 Estou com sede", "Estou com sede"),
        ("🚻 Ir ao banheiro", "Preciso ir ao banheiro"),
        ("❤️ Preciso de ajuda", "Preciso de ajuda")
    ]

    // Contêiner dos botões
    let buttonGrid = BoxRef(
        orientation: .vertical,
        spacing: 12
    )

    // Criar duas colunas
    for rowStart in stride(
        from: 0,
        to: messages.count,
        by: 2
    ) {

        let row = BoxRef(
            orientation: .horizontal,
            spacing: 12
        )

        for index in rowStart..<min(rowStart + 2, messages.count) {

            let (buttonTitle, message) = messages[index]

            let button = ButtonRef(label: buttonTitle)

            button.onClicked { _ in
                message.withCString { text in
                    result.setText(str: text)
                }

                print("Mensagem selecionada: \(message)")
            }

            row.append(child: button)
        }

        buttonGrid.append(child: row)
    }

    // Adicionar os botões à janela
    layout.append(child: buttonGrid)

    // Exibir mensagem selecionada
    layout.append(child: result)

    // Mostrar janela
    window.set(child: layout)
    window.set(visible: true)
}

print("Talkcolor encerrado com status: \(String(describing: status))")
