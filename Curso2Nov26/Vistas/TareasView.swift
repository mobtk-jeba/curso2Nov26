//
//  TareasView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import SwiftUI

struct TareasView: View {
    @State private var tareas = Tarea.ejemplos
    @State private var mostrandoNueva = false
    @State private var tareaABorrar: Tarea?
    @State private var confirmarBorrado = false

    private var pendientes: Int { tareas.filter{ !$0.terminada }.count}

    var body: some View {
        List{
            Section{
                ForEach($tareas){ $tarea in
                    NavigationLink{
                        TareaDetalleView(tarea: $tarea)
                    } label: {
                        Label{
                            Text(tarea.titulo)
                                .strikethrough(tarea.terminada)
                        } icon:{
                            Image(systemName: tarea.terminada ?
                                  "checkmark.circle.fill" : "circle")
                            .foregroundStyle(tarea.terminada ? .green : .gray)
                        }
                    }
                    .swipeActions{
                        Button("Borrar", role: .destructive){
                            tareaABorrar = tarea
                            confirmarBorrado = true
                        }
                    }
                }
            } footer: {
                Text("\(pendientes) pendientes de \(tareas.count)")
            }
        }
        .overlay{
            if tareas.isEmpty{
                ContentUnavailableView("Sin tareas", systemImage: "checklist",
                description: Text("Toca + para agregar una"))
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button{
                    mostrandoNueva = true
                }label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $mostrandoNueva){
            NuevaTareaView{ nueva in
                tareas.append(nueva)
            }
            .presentationDetents([.medium,.large])
        }
        .alert("¿Borrar tarea?", isPresented: $confirmarBorrado, presenting: tareaABorrar){ tarea in
            Button("Borrar", role: .destructive){
                tareas.removeAll{ $0.id == tarea.id}
            }
            Button("Cancelar",role: .cancel){ }
        }message: { tarea in
            Text("Se borrará \"\(tarea.titulo)\".")
        }
    }
}

#Preview {
    TareasView()
}
