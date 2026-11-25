//
//  CampoTexto.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import SwiftUI

struct CampoTexto: View {
    let icono: String
    let placeholder: String
    @Binding var texto: String
    var esSeguro = false
    @State private var mostrarPassword: Bool = false

    var body: some View {
        HStack{
            Image(systemName: icono)
                .frame(width: 20)
            if esSeguro && !mostrarPassword{
                SecureField("",text: $texto,prompt:
                    Text(placeholder).foregroundStyle(.white.opacity(0.7)))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
            }else{
                TextField("",text: $texto,prompt:
                    Text(placeholder).foregroundStyle(.white.opacity(0.7)))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
            }
            if esSeguro{
                Button{
                    mostrarPassword.toggle()
                }label: {
                    Image(systemName: mostrarPassword ? "eye.slash" : "eye")
                        .foregroundStyle(.white)
                }
            }
        }.estiloCampo()
    }
}

#Preview {
    @Previewable @State var usuario: String = ""
    CampoTexto(icono: "at", placeholder: "Usuario", texto: $usuario,
    esSeguro: false)
}
