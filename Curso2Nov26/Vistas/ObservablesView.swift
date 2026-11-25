//
//  ObservablesView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import SwiftUI

struct EncabezadoView: View {
    let sesion: SesionModel

    var body: some View {
        let _ = Self._printChanges()
        Text("Hola, \(sesion.nombreMostrado)")
            .font(.title.bold())
    }
}

struct EditarNombreView:View {
    @Binding var sesion: SesionModel

    var body: some View {
        TextField("Tu nombre",text: $sesion.nombreMostrado)
            .textFieldStyle(.roundedBorder)
    }
}

struct DemoSesion: View {
    @State private var sesion = SesionModel()

    var body: some View {
        VStack {
            EncabezadoView(sesion: sesion)
            EditarNombreView(sesion: $sesion)
            Text("Notificaciones:\(sesion.notificacionesPendientes)")
            Button("Leer una"){
                sesion.notificacionesPendientes -= 1
            }
        }
        .padding()
    }
}

#Preview {
    DemoSesion()
}
