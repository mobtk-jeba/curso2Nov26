//
//  TareasRapidasView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import SwiftUI

struct TareasRapidasView: View {
    @State private var nueva = ""
    @State private var tareas: [String] = ["Instalar xcode"]

    var body: some View {
        VStack {
            HStack{
                TextField("Nueva tarea",text:$nueva)
                    .textFieldStyle(.roundedBorder)
                Button("Agregar"){
                    tareas.append(nueva)
                    nueva = ""
                }.disabled(nueva.isEmpty)
            }
            List(tareas,id:\.self){
                Text($0)
            }
        }
    }
}

struct ContadorHijo: View {
    @Binding var cuenta: Int

    var body: some View {
        Button("Hijo \(cuenta)"){
            cuenta += 1
        }.buttonStyle(.bordered)
    }
}

struct DemoIdentidad: View{
    @State private var mostrar = true
    @State private var cuenta = 0

    var body: some View {
        VStack(spacing:20){
            Toggle("Mostrar contador", isOn: $mostrar)
            if mostrar{
                ContadorHijo(cuenta: $cuenta)
            }
        }.padding()
    }
}

#Preview {
    DemoIdentidad()
}
