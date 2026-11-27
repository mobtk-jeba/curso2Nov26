//
//  DemoRutaView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 26/11/26.
//

import SwiftUI

struct DemoRutaView: View {
    @State private var ruta: [Int] = []

    var body: some View {
        NavigationStack(path: $ruta){
            VStack(spacing: 16){
                Text("Pantalla raíz").font(.title)
                Button("Ir a la pantalla 1"){ ruta.append(1) }
                Button("Saltar directo a pantalla 3"){ ruta = [1,2,3] }
            }
            .navigationTitle("Inicio")
            .navigationDestination(for: Int.self){numero in
                VStack(spacing: 16){
                    Text("Pantalla \(numero)").font(.title)
                    Text("Ruta: \(ruta.map(String.init).joined(separator: " → "))")
                        .foregroundStyle(.secondary)
                    NavigationLink("Siguiente",value: numero + 1)
                    Button("Volver a la raíz"){
                        ruta.removeAll()
                    }
                }
                .navigationTitle("Nivel \(numero)")
            }
        }
    }
}

#Preview {
    DemoRutaView()
}
