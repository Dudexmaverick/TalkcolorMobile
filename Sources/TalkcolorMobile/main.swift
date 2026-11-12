
import Gtk

let status = Application.run(startupHandler: nil) { app in

    // Janela principal
    let window = ApplicationWindowRef(application: app)
    window.title = "Talkcolor — Minha voz, minhas cores"
    window.setDefaultSize(width: 600, height: 500)

    // Organização vertical
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

    // Mensagem exibida ao selecionar um botão
    let result = LabelRef(
        str: "Escolha uma mensagem"
    )

    // Botões de comunicação
    let messages: [(String, String)] = [
        ("🍎 Estou com fome", "Estou com fome"),
        ("💧 Estou com sede", "Estou com sede"),
        ("🚻 Ir ao banheiro", "Preciso ir ao banheiro"),
        ("❤️ Preciso de ajuda", "Preciso de ajuda")
    ]

  for (buttonTitle, message) in messages {
    let button = ButtonRef(label: buttonTitle)

    button.onClicked { _ in
        message.withCString { text in
            result.setText(str: text)
        }

        print("Mensagem selecionada: \(message)")
    }

    layout.append(child: button)
}

layout.append(child: result)

window.set(child: layout)
window.set(visible: true)
}

print("Talkcolor encerrado com status: \(String(describing: status))")