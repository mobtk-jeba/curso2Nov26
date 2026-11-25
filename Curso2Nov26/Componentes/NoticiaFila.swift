//
//  NoticiaFila.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import SwiftUI

struct NoticiaFila: View {
    let noticia: Noticia

    var body: some View {
        HStack(spacing:12){
            AsyncImage(url: noticia.imagenURL){ fase in
                switch fase{
                case .empty:
                    ProgressView()
                case .failure:
                    Image(systemName: "photo")
                        .font(.title)
                        .foregroundStyle(.secondary)
                case .success(let imagen):
                    imagen.resizable().scaledToFill()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 90, height: 70)
            .clipShape(.rect(cornerRadius: 10))
            VStack(alignment: .leading){
                Text(noticia.titulo)
                    .font(.headline)
                Text(noticia.resumen)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(noticia.fecha, format: .dateTime.day().month().year())
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            .padding(.vertical,4)
        }
    }
}

#Preview {
    NoticiaFila(noticia: Noticia.ejemplos[0])
}
