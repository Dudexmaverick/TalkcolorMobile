
import Gtk
import Foundation

// MARK: - Estilos do Talkcolor

let cssProvider = CssProvider()
let cssPath = FileManager.default.currentDirectoryPath + "/talkcolor.css"

if let css = try? String(contentsOfFile: cssPath, encoding: .utf8) {
    css.withCString { data in
        cssProvider.load(from: data, length: -1)
    }
    print("CSS carregado com sucesso!")
} else {
    print("Não foi possível carregar o CSS: \(cssPath)")
}

// MARK: - Aplicativo

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

    let subtitle = LabelRef(str: "Minha voz, minhas cores")
    layout.append(child: subtitle)

    let instruction = LabelRef(
        str: "O que você precisa comunicar?"
    )
    layout.append(child: instruction)

    // Área da mensagem selecionada
    let result = LabelRef(str: "Escolha uma mensagem")

    // Mensagens disponíveis
    let messages: [(String, String)] = [
        ("🍎 Estou com fome", "Estou com fome"),
        ("💧 Estou com sede", "Estou com sede"),
        ("🚻 Ir ao banheiro", "Preciso ir ao banheiro"),
        ("❤️ Preciso de ajuda", "Preciso de ajuda")
    ]

    // Classes CSS correspondentes às mensagens
    let cssClasses = [
        "fome",
        "sede",
        "banheiro",
        "ajuda"
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

        row.set(homogeneous: true)
        row.setHexpand(expand: true)

        for index in rowStart..<min(rowStart + 2, messages.count) {

            let (buttonTitle, message) = messages[index]

            // Criar botão
            let button = ButtonRef(label: buttonTitle)

            // Dimensões e expansão
            button.setHexpand(expand: true)
            button.setSizeRequest(width: 200, height: 100)

            // Associar classe CSS
            let cssClass = cssClasses[index]

            cssClass.withCString { name in
                button.add(cssClass: name)
            }

            // Aplicar provedor CSS ao botão
            if let context = button.getStyleContext() {
                context.add(
                    provider: cssProvider,
                    priority: 800
                )
            }

            // Ação ao clicar
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
