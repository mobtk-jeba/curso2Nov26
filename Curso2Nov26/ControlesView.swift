//
//  ControlesView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 24/11/26.
//

import SwiftUI

struct EstiloCampo: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.white.opacity(0.15))
            .cornerRadius(10)
            .foregroundStyle(.white)
    }
}

extension View{
    func estiloCampo() -> some View {
        modifier(EstiloCampo())
    }
}

struct ControlesView: View {
    @State private var usuario = ""
    @State private var password = ""
    @State private var recuerdame = false
    @State private var cargando = false
    @State private var mostrarPassword = false

    var body: some View {
        VStack(spacing:20){
            Text("Bienvenido")
                .font(.largeTitle)
                .bold()
            Text("Inicia sesión con tu **usuario** de Cognitus")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Label("Datos de acceso", systemImage: "person.badge.key")
            TextField("Usuario", text: $usuario)
                .textFieldStyle(.roundedBorder)
                .textContentType(.username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
            
            TextField("Confirmar contraseña", text: $password).estiloCampo()


            if mostrarPassword {
                TextField("Contraseña", text: $password)
                .textFieldStyle(.roundedBorder)
            } else {
                SecureField("Contraseña", text: $password)
                .textFieldStyle(.roundedBorder)
            }
            Toggle("Mostrar contraseña", isOn: $mostrarPassword)
            Toggle("Recuerdame", isOn: $recuerdame)
            Divider()
            Button{
                cargando = true
            } label: {
                Label("Entrar", systemImage: "arrow.right.circle.fill")
            }
            .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .disabled(usuario.isEmpty || password.isEmpty)

            Button("Borrar todo", role: .destructive){
                usuario = ""
                password = ""
                recuerdame = false
                cargando = false
            }
            if cargando {
                ProgressView("Entrando...")
            }

            VStack{
                Text("Uno")
                Text("Dos")
                Text("Tres").foregroundStyle(.red)
            }.font(.title).foregroundStyle(.blue)

            Text("Padding primero")
                .padding(20)
                .background(.yellow)
            Text("Fondo primero")
                .background(.yellow)
                .padding(20)

            Text("Capas")
                .padding(8)
                .background(.yellow)
                .padding(8)
                .background(.orange)
                .padding(8)
                .background(.red)


            Text("Tarjeta de noticia")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 4)
                .padding(20)

        Text("Escribiste: \(usuario)")
                .font(.caption)
        }
        .padding(20)
    }

}

#Preview {
    ControlesView()
}
