//
//  NoticiasView.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 25/11/26.
//

import SwiftUI

struct NoticiasView: View {
    @State var noticias = Noticia.ejemplos
    @State private var ruta: [Noticia] = []
    @State private var noticiaEnGrande: Noticia?

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

    /*
    enum Ruta: Hashable{
        case noticia(Noticia)
        case autor(nombre:String)
        case ajustes
    }

        .navigationDestination(for: Ruta.self){ruta in
            switch ruta{
            case .noticia(let noticia): NoticiaDetalle(noticia:noticia)
            case .autor(let nombre): Text("Perfil de \(nombre)")
            case .ajustes: Text("Ajustes")
            }

        }*/

    var body: some View {
        if noticias.isEmpty{
            ContentUnavailableView("No hay noticias", systemImage: "newspaper",
            description: Text("Vuelve mas tarde"))
        }else{
            NavigationStack(path: $ruta){
                List {
                    ForEach(noticias){ noticia in
                        NavigationLink(value:noticia){
                            NoticiaFila(noticia: noticia)
                        }
                    }.onDelete{ posiciones in
                        noticias.remove(atOffsets: posiciones)
                    }
                }
                .navigationTitle("Noticias")
                .navigationDestination(for: Noticia.self){noticia in
                    NoticiaDetalleView(noticia:noticia)
                }
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button{
                            print("Abrir notificaciones")
                        }label: {
                            Image(systemName: "bell")
                        }
                    }
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
                    Button{
                        noticiaEnGrande = noticia
                    }label: {
                        Text(noticia.titulo)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(width: 260, height: 140, alignment: .bottomLeading)
                            .background(Color.blue.gradient, in: .rect(cornerRadius: 16))
                    }
                    .fullScreenCover(item: $noticiaEnGrande){noticia in
                        NoticiaDetalleView(noticia: noticia)
                            .overlay(alignment:.topTrailing){
                                Button{
                                    noticiaEnGrande = nil
                                } label:{
                                    Image(systemName: "xmark.circle.fill").font(.title)
                                }
                                .padding()
                            }
                    }
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal)
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
    }

}

struct InfoSistemaView: View{
    @Environment(\.colorScheme) private var esquema
    @Environment(\.dynamicTypeSize) private var tamanoTexto
    @Environment(\.openURL) private var abrirURL

    var body: some View{
        VStack(spacing:12){
            Text(esquema == .dark ? "Modo oscuro": "Modo claro")
            Text("Tamaño texto: \(String(describing: tamanoTexto))")
            Button("Abrir Apple Developer"){
                abrirURL(URL(string: "https://developer.apple.com")!)
            }
        }
    }
}

#Preview {
    NoticiasView()
}
