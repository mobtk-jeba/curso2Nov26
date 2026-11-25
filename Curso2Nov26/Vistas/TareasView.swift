//
//  TareasView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import SwiftUI

struct TareasView: View {
    @State private var tareas = Tarea.ejemplos

    var body: some View {
        List($tareas){ $tarea in
            Toggle(tarea.titulo, isOn: $tarea.terminada)
            /*HStack{
                Text(tarea.titulo)
                Spacer()
                Image(systemName: tarea.terminada ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(tarea.terminada ? .green: .gray)
            }*/
        }
    }
}

#Preview {
    TareasView()
}
