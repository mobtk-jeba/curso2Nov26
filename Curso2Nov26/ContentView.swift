//
//  ContentView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 24/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var cuenta = 0

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            /*Text("Probando login...")
                .task {
                    let vm = LoginViewModel()
                    await vm.entrar(usuario: "usuarioprueba@gmail.com", password: "123456")
                    print(vm.usuario.map{"\($0.name ?? "")"} ?? (vm.mensajeError ?? ""))
                }*/
            Text("\(cuenta)")
                .font(.largeTitle)
            Button("Sumar") {
                cuenta += 1
            }
            Button("Reiniciar"){
                cuenta = 0
            }.disabled(cuenta == 0)
            Button("¿Que soy?"){
                print(type(of: self.body))
            }
        }
        .padding()
    }
}

#Preview("Normal") {
    ContentView()
}

#Preview("Modo oscuro"){
    ContentView()
        .preferredColorScheme(.dark)
}

#Preview("Texto muy grande"){
    ContentView()
        .environment(\.dynamicTypeSize, .accessibility3)
}

#Preview("Horizontal", traits: .landscapeLeft){
    ContentView()
}

#Preview("Elemento", traits: .sizeThatFitsLayout){
    Text("Solo el tamaño del componente")
        .padding()
        .background(.yellow)
}



/*
class ContadorVC: UIViewController {
    @IBOutlet weak var lblCuenta: UILabel!
    @IBOutlet weak var btnReiniciar: UIButton!
    var cuenta = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        actualizarPantalla() // estado inicial
    }
    @IBAction func sumar(
        _
        sender: Any) {
            cuenta += 1
            actualizarPantalla() // ¡no olvidar!
        }
    @IBAction func reiniciar(
    _
    cuenta = 0
    sender: Any) {
        actualizarPantalla() // ¡tampoco aquí!
    }
    func actualizarPantalla() {
        lblCuenta.text = "\(cuenta)"
        btnReiniciar.isEnabled = cuenta > 0
    }
}
*/
