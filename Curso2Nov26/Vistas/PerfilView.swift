//
//  PerfilView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 26/11/26.
//

import SwiftUI

struct PerfilView: View {
    @Environment(SesionModel.self) private var sesion
    @AppStorage("notificacionesActivas") private var notificacionesActivas = true
    @State private var confirmarSalida = false

    var body: some View {
        @Bindable var sesion = sesion

        Form{
            Section{
                HStack(spacing: 16){
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(.primaryBlue)
                    VStack(alignment: .leading){
                        Text(sesion.nombreMostrado.isEmpty ? "Sin nombre" : sesion.nombreMostrado)
                        Text(sesion.perfil.rawValue)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical,8)
            }

            Section{
                TextField("Nombre",text: $sesion.nombreMostrado)
                Picker("Tipo de perfil", selection: $sesion.perfil){
                    ForEach(Perfil.allCases){opcion in
                        Text(opcion.rawValue).tag(opcion)
                    }
                }
            } header:{
                Text("Mis datos")
            } footer: {
                if sesion.nombreMostrado.trimmingCharacters(in: .whitespaces).isEmpty{
                    Text("El nombre no puede quedar vacío")
                        .foregroundStyle(.red)
                }
            }

            Section("Preferencias"){
                Toggle("Notificaciones", isOn: $notificacionesActivas)
                LabeledContent("Pendientes", value:"\(sesion.notificacionesPendientes)")
            }

            Section{
                Button("Cerrar sesión",role: .destructive){
                    //sesion.cerrarSesion()
                    confirmarSalida = true
                }
                .confirmationDialog("¿Cerrar sesión?", isPresented: $confirmarSalida, titleVisibility: .visible){
                    Button("Cerrar sesión", role: .destructive){
                        sesion.cerrarSesion()
                    }
                }
            }
        }
    }
}

#Preview {
    PerfilView()
        .environment(SesionModel.ejemplo)
}
