//
//  Noticia.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import Foundation

struct Noticia: Identifiable, Sendable, Hashable{
    let id: Int
    let titulo: String
    let resumen: String
    let fecha: Date
    let imagenURL: URL?
}

extension Noticia{
    static let ejemplos: [Noticia] = [
        Noticia(id: 1, titulo: "Bienvenidos al curso", resumen: "Empezamos nuestro curso de 5 días", fecha: .now, imagenURL: URL(string: "https://picsum.photos/id/1/400/300")),
        Noticia(id: 2, titulo: "Nueva version Xcode", resumen: "utilizando Xcode 27", fecha: .now.addingTimeInterval(-86_400), imagenURL: URL(string: "https://picsum.photos/id/180/400/300")),
        Noticia(id: 3, titulo: "Utilizando SwiftUI", resumen: "Mejoras en SwiftUI", fecha: .now.addingTimeInterval(-172_800), imagenURL: URL(string: "https://picsum.photos/id/60/400/300")),
        Noticia(id: 4, titulo: "Ejemplo de lista", resumen: "Esta es una lista de ejemplo", fecha: .now.addingTimeInterval(-259_200), imagenURL: URL(string:"https://picsum.photos")),
    ]
}
