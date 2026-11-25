
//
//  Tarea.swift
//  Curso2
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 22/11/26.
//

import Foundation

nonisolated struct Tarea: Identifiable, Sendable {
    let id: Int
    let titulo: String
    let terminada: Bool
}

extension Tarea {
    static let ejemplos: [Tarea] = [
        Tarea(id: 1, titulo: "Instalar Xcode 27"
                , terminada:true),
        Tarea(id: 2, titulo: "Terminar el login"
                , terminada: false),
        Tarea(id: 3, titulo: "Revisar el día 3"
                , terminada: false),
        Tarea(id: 4, titulo: "Revisar respuestas de servicios"
                , terminada: false)
    ]
}
