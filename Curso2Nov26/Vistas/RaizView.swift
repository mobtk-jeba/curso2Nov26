//
//  RaizView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 26/11/26.
//

import SwiftUI

struct RaizView: View {
    @Environment(SesionModel.self) private var sesion

    var body: some View {
        Group{
            if sesion.estaLogueado{
                PrincipalView()
                    .transition(.move(edge: .trailing))
            }else{
                LoginView()
                    .transition(.opacity)
            }
        }
        .animation(.default, value: sesion.estaLogueado)
    }
}

#Preview {
    RaizView()
        .environment(SesionModel.ejemplo)
}
