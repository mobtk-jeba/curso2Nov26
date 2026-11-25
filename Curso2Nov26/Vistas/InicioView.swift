//
//  InicioView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import SwiftUI

struct InicioView: View {
    private let columnas = [GridItem(.adaptive(minimum: 100),spacing: 12)]

    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 24){
                encabezado
                titulo("Destacadas")
                ScrollView(.horizontal){
                    LazyHStack(spacing: 12){
                        ForEach(Noticia.ejemplos){noticia in
                            NoticiaDestacada(noticia: noticia)
                        }
                    }
                    .scrollTargetLayout()
                    .padding(.horizontal)
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                titulo("Accesos")
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
                titulo("Últimas noticias")
                LazyVStack( spacing:12){
                    ForEach(Noticia.ejemplos){noticia in
                        NoticiaFila(noticia: noticia)
                        Divider()
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
            }
        }
    }

    private var encabezado: some View {
        HStack{
            VStack{
                Text("Hola, Ana García").font(.title.bold())
                Text(Date.now, format: .dateTime.weekday(.wide).day().month(.wide))
                    .foregroundStyle(.secondaryBlue)
            }
            Spacer()
            Image(systemName: "person.crop.circle.fill")
        }
        .font(.system(size: 40))
        .foregroundStyle(.primaryBlue)
        .padding(.horizontal)
    }

    private func titulo(_ texto:String) -> some View {
        Text(texto)
            .font(.title3.bold())
            .padding(.horizontal)
    }
}

#Preview {
    InicioView()
}
