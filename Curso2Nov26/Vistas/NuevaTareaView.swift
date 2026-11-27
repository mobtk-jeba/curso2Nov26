//
//  NuevaTareaView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 26/11/26.
//

import SwiftUI

struct NuevaTareaView: View {
    @Environment(\.dismiss) private var cerrar
    @State private var titulo = ""
    @State private var notas = ""

    
    let alGuardar: (Tarea) -> Void


    var body: some View {
        NavigationStack{
            Form{
                TextField("Título", text: $titulo)
                TextField("Notas", text:$notas, axis:.vertical)
                    .lineLimit(3...6)
            }
            .navigationTitle("Nueva tarea")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancelar"){cerrar()}
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Guardar"){
                        alGuardar(Tarea(titulo: titulo, terminada: false, notas:notas))
                        cerrar()
                    }
                    .disabled(titulo.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    //NuevaTareaView()
}
