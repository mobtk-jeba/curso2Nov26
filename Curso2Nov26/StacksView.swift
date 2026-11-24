//
//  StacksView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 24/11/26.
//

import SwiftUI

struct StacksView: View {
    var body: some View {
        ZStack{
            Image("fondo")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack{
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180)
                    .padding(100)
                HStack(spacing: 12){
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.blue)
                    VStack(alignment: .leading, spacing: 8){
                        Text("Ana García").font(.headline)
                        Text("ana@mail.com").foregroundStyle(.secondary)
                        Text("Administrador").font(.caption)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.tertiary)
                }.padding()
                Image(systemName: "bell.fill")
                    .font(.largeTitle)
                    .overlay(alignment:.topTrailing){
                        Circle()
                            .fill(.red)
                            .frame(width: 12, height: 12)
                    }
                Text("Ancho natural")
                    .background(.yellow)
                Text("Todo el ancho")
                    .frame(maxWidth: .infinity)
                    .background(.yellow)
                Text("Todo el ancho, a la izquierda")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.yellow)
                Text("Tamaño fijo")
                    .frame(width: 200, height: 60)
                    .background(.yellow)
            }.padding()
        }
    }
}

#Preview {
    StacksView()
}
