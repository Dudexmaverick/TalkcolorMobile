
import Gtk
import Foundation

// MARK: - Comunicação por voz

func falarMensagem(_ mensagem: String) {
    let processo = Process()

    processo.executableURL = URL(
        fileURLWithPath: "/usr/bin/spd-say"
    )

    processo.arguments = [
        "-l",
        "pt-BR",
        mensagem
    ]

    do {
        try processo.run()
        print("🔊 Reproduzindo: \(mensagem)")
    } catch {
        print("Erro ao reproduzir voz: \(error)")
    }
}

// MARK: - Estilos do Talkcolor

let cssProvider = CssProvider()
let cssPath = FileManager.default.currentDirectoryPath + "/talkcolor.css"

if let css = try? String(
    contentsOfFile: cssPath,
    encoding: .utf8
) {
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
    window.setDefaultSize(width: 600, height: 600)

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

    // MARK: - Cartão de comunicação

    let resultCard = BoxRef(
        orientation: .vertical,
        spacing: 10
    )

    let resultHeading = LabelRef(
        str: "MENSAGEM SELECIONADA"
    )

    let resultEmoji = LabelRef(str: "💬")

    let result = LabelRef(
        str: "Escolha uma mensagem"
    )

    // Classes CSS do cartão
    "talkcolor-result-card".withCString { name in
        resultCard.add(cssClass: name)
    }

    "talkcolor-result-heading".withCString { name in
        resultHeading.add(cssClass: name)
    }

    "talkcolor-result-emoji".withCString { name in
        resultEmoji.add(cssClass: name)
    }

    "talkcolor-result-text".withCString { name in
        result.add(cssClass: name)
    }

    resultCard.append(child: resultHeading)
    resultCard.append(child: resultEmoji)
    resultCard.append(child: result)

    // MARK: - Mensagens disponíveis

    let messages: [(String, String)] = [
        ("🍎 Estou com fome", "Estou com fome"),
        ("💧 Estou com sede", "Estou com sede"),
        ("🚻 Ir ao banheiro", "Preciso ir ao banheiro"),
        ("❤️ Preciso de ajuda", "Preciso de ajuda")
    ]

    let cssClasses = [
        "fome",
        "sede",
        "banheiro",
        "ajuda"
    ]

    let emojis = [
        "🍎",
        "💧",
        "🚻",
        "❤️"
    ]

    let buttonLabels = [
        "Estou com fome",
        "Estou com sede",
        "Ir ao banheiro",
        "Preciso de ajuda"
    ]

    // MARK: - Grade de botões

    let buttonGrid = BoxRef(
        orientation: .vertical,
        spacing: 12
    )

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

            let (_, message) = messages[index]

            // Criar botão
            let button = ButtonRef(label: "")

            // Conteúdo visual
            let buttonContent = BoxRef(
                orientation: .vertical,
                spacing: 8
            )

            let emoji = LabelRef(
                str: emojis[index]
            )

            let buttonText = LabelRef(
                str: buttonLabels[index]
            )

            "talkcolor-emoji".withCString { name in
                emoji.add(cssClass: name)
            }

            "talkcolor-button-text".withCString { name in
                buttonText.add(cssClass: name)
            }

            buttonContent.append(child: emoji)
            buttonContent.append(child: buttonText)

            button.set(child: buttonContent)

            // Dimensões
            button.setHexpand(expand: true)
            button.setSizeRequest(
                width: 200,
                height: 120
            )

            // Cor individual
            cssClasses[index].withCString { name in
                button.add(cssClass: name)
            }

            // Aplicar CSS
            if let context = button.getStyleContext() {
                context.add(
                    provider: cssProvider,
                    priority: 800
                )
            }

            // MARK: - Ação ao clicar

            button.onClicked { _ in

                // Atualizar texto
                message.withCString { text in
                    result.setText(str: text)
                }

                // Atualizar emoji
                emojis[index].withCString { symbol in
                    resultEmoji.setText(str: symbol)
                }

                // Reproduzir a mensagem em voz alta
                falarMensagem(message)

                print(
                    "Mensagem selecionada: \(message)"
                )
            }

            row.append(child: button)
        }

        buttonGrid.append(child: row)
    }

    // Adicionar botões
    layout.append(child: buttonGrid)

    // Adicionar cartão de comunicação
    layout.append(child: resultCard)

    // Aplicar CSS ao cartão
    if let context = resultCard.getStyleContext() {
        context.add(
            provider: cssProvider,
            priority: 800
        )
    }

    // Mostrar janela
    window.set(child: layout)
    window.set(visible: true)
}

print(
    "Talkcolor encerrado com status: \(String(describing: status))"
)
