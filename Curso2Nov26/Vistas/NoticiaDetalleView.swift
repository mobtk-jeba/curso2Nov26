//
//  NoticiaDetalleView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 26/11/26.
//

import SwiftUI

struct NoticiaDetalleView: View {
    let noticia: Noticia
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 16){
                Color.clear
                    .frame(height: 220)
                    .overlay{
                        AsyncImage(url:noticia.imagenURL){imagen in
                            imagen.resizable().scaledToFill()
                        }placeholder: {
                            Color(.secondaryBlue)
                        }
                    }.clipped()
                VStack(alignment: .leading, spacing: 16){
                    Text(noticia.titulo)
                        .font(.title2.bold())
                    Text(noticia.fecha, format: .dateTime.day().month(.wide).year())
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(noticia.resumen)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                ShareLink(item: noticia.titulo){
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
}

#Preview {
    NoticiaDetalleView(noticia: Noticia.ejemplos[0])
}
