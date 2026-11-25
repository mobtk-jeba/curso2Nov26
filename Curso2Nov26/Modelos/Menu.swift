//
//  Menu.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import Foundation
import SwiftUI

struct OpcionMenu: Identifiable {
    let id = UUID()
    let titulo: String
    let icono: String
    let color: Color
}

extension OpcionMenu {
    static let opciones = [
        OpcionMenu(titulo: "Noticias", icono: "newspaper.fill", color: .blue),
        OpcionMenu(titulo: "Tareas", icono: "checklist", color: .orange),
        OpcionMenu(titulo: "Check-in", icono: "mappin.and.ellipse", color: .green),
        OpcionMenu(titulo: "Notificaciones", icono: "bell.fill", color: .red),
        OpcionMenu(titulo: "Perfil", icono: "person.fill", color: .purple),
        OpcionMenu(titulo: "Encuestas", icono: "chart.bar.fill", color: .teal),
    ]
}
