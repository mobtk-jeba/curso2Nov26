//
//  RegistroView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 26/11/26.
//

import SwiftUI

struct RegistroView: View {

    enum Campo { case nombre, correo, password }

    @State private var nombre = ""
    @State private var correo = ""
    @State private var password = ""
    @State private var perfil: Perfil = .cliente
    @State private var nacimiento = Calendar.current.date(byAdding: .year, value: -25, to: .now)!
    @State private var anios = 1
    @State private var aceptaTerminos = false

    @AppStorage("recibirAvisos") private var recibirAvisos = true
    @FocusState private var campoActivo: Campo?

    private var correoValido: Bool {
        correo.contains("@") && correo.contains(".")
    }
    private var formularioValido: Bool{
        !nombre.isEmpty && correoValido && password.count >= 9 && aceptaTerminos
    }

    var body: some View {
        Form{
            Section{
                TextField("Nombre completo", text: $nombre)
                    .focused($campoActivo, equals: .nombre)
                    .submitLabel(.next)
                    .onSubmit {
                        campoActivo = .correo
                    }
                TextField("Correo",text: $correo)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .focused($campoActivo, equals: .correo)
                    .submitLabel(.next)
                    .onSubmit {
                        campoActivo = .password
                    }
                SecureField("Contraseña (mínimo 8)", text: $password)
                    .focused($campoActivo, equals: .password)
                    .submitLabel(.done)
                    .onSubmit {
                        campoActivo = nil
                    }
                DatePicker("Nacimiento", selection: $nacimiento, displayedComponents: .date)
            }header: {
                Text("Datos personales")
            }footer: {
                if !correo.isEmpty && !correoValido{
                    Text("Escribe un correo válido")
                        .foregroundStyle(.red)
                }
            }

            Section("Perfil"){
                Picker("Tipo de perfil", selection: $perfil){
                    ForEach(Perfil.allCases){opcion in
                        Text(opcion.rawValue).tag(opcion)
                    }
                }//.pickerStyle(.wheel)
                Stepper("Años de experiencia: \(anios)", value:$anios, in: 0...40)
            }

            Section{
                Toggle("Recibir avisos", isOn: $recibirAvisos)
                Toggle("Acepto los términos y condiciones", isOn: $aceptaTerminos)
            }

            Section{
                Button("Crear cuenta"){
                    print("Registro de \(nombre) como \(perfil.rawValue)")
                }.disabled(!formularioValido)
            }
            .scrollDismissesKeyboard(.interactively)
        }
    }
}

#Preview {
    RegistroView()
}
