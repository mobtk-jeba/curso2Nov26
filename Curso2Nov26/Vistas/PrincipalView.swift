//
//  PrincipalView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 26/11/26.
//

import SwiftUI

enum Pestana: Hashable{
    case inicio, noticias, tareas, perfil
}

struct PrincipalView: View {
    @Environment(SesionModel.self) private var sesion
    @State private var pestana: Pestana = .inicio

    var body: some View {
        TabView(selection: $pestana){
            Tab("Inicio", systemImage: "house", value: Pestana.inicio){
                NavigationStack{
                    InicioView()
                        .navigationTitle("Inicio")
                }
            }

            Tab("Noticias", systemImage: "newspaper", value: Pestana.noticias){
                NoticiasView()
            }

            Tab("Tareas", systemImage: "checklist", value: Pestana.tareas){
                NavigationStack{
                    TareasView()
                        .navigationTitle("Tareas")
                }
            }

            Tab("Perfil", systemImage: "person", value: Pestana.perfil){
                NavigationStack{
                    PerfilView()
                        .navigationTitle("Perfil")
                }
            }
            .badge(sesion.notificacionesPendientes)

        }
    }
}

#Preview {
    PrincipalView()
        .environment(SesionModel.ejemplo)
}
