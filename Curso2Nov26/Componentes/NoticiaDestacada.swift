//
//  NoticiaDestacada.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import SwiftUI

struct NoticiaDestacada: View {
    let noticia: Noticia

    var body: some View {
        AsyncImage(url: noticia.imagenURL){imagen in
            imagen.resizable().scaledToFill()
        } placeholder: {
            Color.primaryBlue
        }
        .frame(width: 280, height: 160)
        .overlay(alignment: .bottomLeading){
            Text(noticia.titulo)
                .font(.headline)
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.linearGradient(colors:[.clear, .black.opacity(0.7)],startPoint: .top, endPoint: .bottom))
        }.clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    NoticiaDestacada(noticia: Noticia.ejemplos[0])
}
