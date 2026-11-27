
//
//  Tarea.swift
//  Curso2
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 22/11/26.
//

import Foundation

nonisolated struct Tarea: Identifiable, Sendable {
    let id = UUID()
    var titulo: String
    var terminada: Bool
    var notas: String
}

extension Tarea {
    static let ejemplos: [Tarea] = [
        Tarea(titulo: "Instalar Xcode 27"
              , terminada:true, notas:""),
        Tarea(titulo: "Terminar el login"
                , terminada: false, notas:""),
        Tarea(titulo: "Revisar el día 3"
                , terminada: false, notas:""),
        Tarea(titulo: "Revisar respuestas de servicios"
                , terminada: false, notas:"")
    ]
}
