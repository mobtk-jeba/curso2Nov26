//
//  SesionModel.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import Foundation
import Observation

@Observable
final class SesionModel{
    var usuario: Usuario?
    var nombreMostrado = ""
    var notificacionesPendientes = 3
    var estaLogueado: Bool {usuario != nil}
    var perfil: Perfil = .cliente

    func iniciarSesion(nombre:String){
        usuario = Usuario(id: 1, name: nombre, age: 0, email: "", numemp: "")
    }

    func cerrarSesion(){
        usuario = nil
        nombreMostrado = ""
    }
}

extension SesionModel {
    static var ejemplo: SesionModel{
        let sesion = SesionModel()
        sesion.iniciarSesion(nombre: "Ana García")
        return sesion
    }
}
