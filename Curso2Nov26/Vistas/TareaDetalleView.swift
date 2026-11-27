//
//  TareaDetalleView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 26/11/26.
//

import SwiftUI

struct TareaDetalleView: View {
    @Binding var tarea: Tarea

    var body: some View {
        Form{
            TextField("Titulo", text: $tarea.titulo)
            TextField("Notas", text: $tarea.notas, axis:.vertical)
                .lineLimit(3...8)
            Toggle("Terminada",isOn: $tarea.terminada)
        }
        .navigationTitle(tarea.titulo)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var tarea = Tarea.ejemplos[2]
    TareaDetalleView(tarea: $tarea)
}
