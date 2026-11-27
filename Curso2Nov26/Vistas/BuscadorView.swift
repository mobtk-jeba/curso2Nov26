//
//  BuscadorView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 26/11/26.
//

import SwiftUI

struct BuscadorView: View {

    @State private var texto = ""
    @State private var resultados : [String] = []
    private let todos = ["Swift","SwiftUI","SwiftData","UIKit","Xcode","Concurrency"]

    var body: some View {
        VStack{
            TextField("Buscar",text: $texto)
                .textFieldStyle(.roundedBorder)
            List(resultados,id:\.self){
                Text($0)
            }
            .padding()
            .task(id: texto) {
                try? await Task.sleep(for: .milliseconds(300))
                guard !Task.isCancelled else {return}
                resultados = texto.isEmpty
                    ? todos
                    : todos.filter{$0.localizedCaseInsensitiveContains(texto)}
                print("Buscando '\(texto)'")
            }
        }.onChange(of: texto){anterior, nuevo in
            print("Cambió de '\(anterior)' a '\(nuevo)'")
        }
        .onAppear{ print("Apareción")}
        .onDisappear{print("Desapareció")}
    }
}

#Preview {
    BuscadorView()
}
