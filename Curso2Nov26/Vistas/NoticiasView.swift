//
//  NoticiasView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import SwiftUI

struct NoticiasView: View {
    @State var noticias = Noticia.ejemplos

    private var deHoy: [Noticia]{
        noticias.filter{
            Calendar.current.isDateInToday($0.fecha)
        }
    }
    private var anteriores: [Noticia]{
        noticias.filter{
            !Calendar.current.isDateInToday($0.fecha)
        }
    }

    var body: some View {
        if noticias.isEmpty{
            ContentUnavailableView("No hay noticias", systemImage: "newspaper",
            description: Text("Vuelve mas tarde"))
        }else{
            List {
                ForEach(noticias){ noticia in
                    NoticiaFila(noticia: noticia)
                }.onDelete{ posiciones in
                    noticias.remove(atOffsets: posiciones)
                }
            }
        }

        /*
        List{
            Section("Hoy"){
                ForEach(deHoy){noticia in
                    Text(noticia.titulo)
                }
            }
            Section("Anteriores"){
                ForEach(anteriores){noticia in
                    Text(noticia.titulo)
                }
            }
        }.listStyle(.sidebar)*/
        ScrollView(.horizontal){
            LazyHStack(spacing: 12){
                ForEach(noticias){noticia in
                    Text(noticia.titulo)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(width: 260, height: 140, alignment: .bottomLeading)
                        .background(Color.blue.gradient, in: .rect(cornerRadius: 16))
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal)
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    NoticiasView()
}
