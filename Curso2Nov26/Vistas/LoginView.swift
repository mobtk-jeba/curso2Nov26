//
//  LoginView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 24/11/26.
//

import SwiftUI

struct LoginView: View {
    @State private var usuario = ""
    @State private var password = ""
    @State private var mostrarPassword = false
    @State private var recordar = false

    private var formularioValido: Bool {
        !usuario.isEmpty && password.count >= 6
    }

    var body: some View {
        ZStack {
            Image("fondo")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(spacing:20) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.top, 40)
                Spacer()

                CampoTexto(icono: "at", placeholder: "Usuario", texto: $usuario)
                CampoTexto(icono: "lock", placeholder: "Contraseña", texto: $password, esSeguro: true)
                /*
                HStack{
                    Image("icoArroba")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    TextField("",text: $usuario,prompt:
                        Text("Usuario").foregroundStyle(.white.opacity(0.7)))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                }.estiloCampo()
                HStack{

                    if mostrarPassword {
                        TextField("",text: $password,prompt:
                            Text("Password").foregroundStyle(.white.opacity(0.7)))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                    }else{
                        SecureField("",text: $password,prompt:
                            Text("Password").foregroundStyle(.white.opacity(0.7)))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                    }

                    Button{
                        mostrarPassword.toggle()
                    }label: {
                        Image("icoOjo")
                    }
                }.estiloCampo()*/
                if !password.isEmpty && password.count < 6 {
                    Text("Mínimo 6 caracteres")
                        .font(.caption)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Toggle("Recordarme", isOn: $recordar)
                    .foregroundStyle(.white)
                    .tint(Color("secondaryBlue"))

                /*Button{
                    print("Entrar con usuario \(usuario)")
                }label: {
                    Text("Entrar")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                }*/
                BotonPrincipal(titulo: "Entrar", accion: {
                    print("Entrar con usuario \(usuario)")
                })
                .buttonStyle(.borderedProminent)
                .tint(Color("primaryBlue"))
                .disabled(!formularioValido)

                Text("Cognitus").foregroundStyle(Color.primary)
                HStack{
                    Button("Crear cuenta"){}
                    Spacer()
                    Button("Olvide contraseña"){}
                }
                .font(.footnote)
                .tint(.white)
                Spacer()
            }.padding(40)
        }
    }
}

#Preview {
    LoginView()
}
