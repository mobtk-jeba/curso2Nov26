//
//  ContentView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 24/11/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Probando login...")
                .task {
                    let vm = LoginViewModel()
                    await vm.entrar(usuario: "usuarioprueba@gmail.com", password: "123456")
                    print(vm.usuario.map{"\($0.name ?? "")"} ?? (vm.mensajeError ?? ""))
                }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
