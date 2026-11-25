//
//  BotonPrincipal.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import SwiftUI

struct BotonPrincipal: View {
    let titulo: String
    let cargando = false
    let accion: (() -> Void)

    var body: some View {
        Button(action:accion){
            Group{
                if cargando {
                    ProgressView().tint(.white)
                }else{
                    Text(titulo).font(.headline)
                }
            }
            .frame(maxWidth:.infinity)
            .padding(.vertical,6)

        }
        .buttonStyle(.borderedProminent)
        .tint(.primaryBlue)
        .disabled(cargando)
    }
}

#Preview {
    BotonPrincipal(titulo: "Boton"){
        print("presionado")
    }
}
