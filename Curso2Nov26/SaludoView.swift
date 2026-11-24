//
//  SaludoView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 24/11/26.
//

import SwiftUI

struct SaludoView: View {
    let conectado: Bool

    var body: some View {
        if conectado {
            Text("¡Hola, mundo!")
        } else {
            Image(systemName: "person.crop.circle.badge.xmark")
        }
    }

    @ViewBuilder
    func icono(conectado: Bool) -> some View {
        if conectado {
            Image(systemName: "checkmark.circle")
        }else {
            Text("Sin conexión")
        }
    }
}

struct ContadorRoto: View {
    @State private var cuenta = 0

    var body: some View {
        Button("Sumar \(cuenta)"){
            cuenta += 1
        }
    }
}

#Preview {
    //SaludoView(conectado: true)
    ContadorRoto()
}
