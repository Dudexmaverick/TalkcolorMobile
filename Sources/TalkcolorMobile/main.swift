import Gtk

let status = Application.run(startupHandler: nil) { app in
    let window = ApplicationWindowRef(application: app)

    window.title = "Talkcolor — Minha voz, minhas cores"
    window.setDefaultSize(width: 600, height: 450)

    let label = LabelRef(
        str: "💜 Bem-vinda ao Talkcolor!"
    )

    window.set(child: label)
    window.set(visible: true)
}

guard let status = status else {
    fatalError("Não foi possível iniciar o Talkcolor.")
}

guard status == 0 else {
    fatalError("O Talkcolor terminou com erro: \(status)")
}
