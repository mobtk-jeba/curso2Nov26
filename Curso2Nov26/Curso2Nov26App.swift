//
//  Curso2Nov26App.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 24/11/26.
//

import SwiftUI

@main
struct Curso2Nov26App: App {

    @State private var sesion = SesionModel()
    @Environment(\.scenePhase) private var fase

    var body: some Scene {
        WindowGroup {
            RaizView()
                .environment(sesion)
        }.onChange(of: fase){_, nueva in
            if nueva == .background{
                print("La app pasó a segundo plano")
            }
        }
    }
}
