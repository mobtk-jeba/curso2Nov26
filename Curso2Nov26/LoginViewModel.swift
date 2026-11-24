//
//  LoginViewModel.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 24/11/26.
//
import Foundation

final class LoginViewModel {
    private(set) var cargando = false
    private(set) var mensajeError: String?
    private(set) var usuario: Usuario?

    private let api = APIClient()

    func entrar(usuario nombre: String, password: String) async{
        cargando = true
        mensajeError = nil
        defer { cargando = false}

        do{
            let (data,codigo) = try await api.enviar("100|\(nombre)|\(password)")
            //print(String(data: data, encoding: .utf8))
            guard let u = try procesar(Usuario.self, data: data, codigoHTTP: codigo).first else {
                throw ErrorAPI.rechazada("El servidor no regreso los datos del usuario")
            }
            usuario = u
        }catch{
            mensajeError = error.localizedDescription
        }
    }
}
