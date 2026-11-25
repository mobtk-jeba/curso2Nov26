//
//  MenuView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import SwiftUI

struct MenuView: View {
    /*private let columnas = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]*/

    private let columnas = [
        GridItem(.adaptive(minimum: 140), spacing: 16)
    ]

    @State private var avisos = 0

    var body: some View {
        ScrollView{
            LazyVGrid(columns: columnas, spacing: 16) {
                ForEach(OpcionMenu.opciones) { opcion in
                    VStack(spacing:12){
                        Image(systemName: opcion.icono)
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                            .frame(width: 64, height: 64)
                            .background(opcion.color, in: .rect(cornerRadius: 16))
                        Text(opcion.titulo)
                            .font(.subheadline.weight(.medium))

                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,20)
                    .background(Color(.secondarySystemBackground), in:.rect(cornerRadius: 16))
                }
            }.padding()

            VStack(spacing:20){
                AsyncImage(url:URL(string:"https://picsum.photos/id/100/400/300"))
                { imagen in
                    imagen
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 120)
                .clipShape(.rect(cornerRadius:8))

                Button {
                    avisos += 1
                }label: {
                    Image(systemName: "bell.fill")
                        .font(.largeTitle)
                        .symbolEffect(.pulse, value: avisos)
                }
                HStack(spacing: 10){
                    Image(systemName: "bell")
                    Image(systemName: "bell.fill")
                    Image(systemName: "bell.badge.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.red, .gray)
                }
                .font(.largeTitle)

                Image(.logo)

                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140)

                Image(.noticia)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 90)
                    .clipShape(.rect(cornerRadius: 16))

                Image(.noticia)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay{
                        Circle().stroke(.white, lineWidth: 3)
                    }
                    .shadow(radius: 4)

                Image(.icoCampana)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
                    .foregroundStyle(Color.red)



            }
        }
    }
}

#Preview {
    MenuView()
}
