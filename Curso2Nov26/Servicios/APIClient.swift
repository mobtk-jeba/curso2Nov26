//
//  APIClient.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 24/11/26.
//

import Foundation


enum ErrorAPI: LocalizedError {
    case sinConexion
    case servidor(codigo: Int)
    case rechazada(String)
    case decodificacion(String)

    var errorDescription: String? {
        switch self {
            case .sinConexion: "Revisa tu conexión a internet"
            case .servidor(let codigo): "El servidor respondió con error \(codigo)"
            case .rechazada(let mensaje): mensaje
            case .decodificacion(let detalle): "Respuesta inesperada del servidor: \(detalle)"
        }
    }
}

nonisolated struct APIClient: Sendable {
    private let base = URL(string: "https://cognitus.administradordemo.info/processrequest/")!
    private let campo = "datacog"


    func consulta<T: RespuestaConClave>(_ texto: String, como tipo: T.Type) async throws ->[T]{
        let base64 = Data(texto.utf8).base64EncodedString()
        let valor = base64.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""

        return try await enviar(ruta:"processrequest-add", cuerpo:"\(campo)=\(valor)", como: tipo)
    }



    private func enviar<T: RespuestaConClave>(ruta: String, cuerpo: String, como tipo: T.Type) async throws -> [T] {

        var request = URLRequest(url: base.appending(path: ruta))
        request.httpMethod = "POST"
        request.httpBody = Data(cuerpo.utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20


        let data: Data
        let respuesta: URLResponse
        do{
            let (data, respuesta) = try await URLSession.shared.data(for: request)
            //let codigo = (response as? HTTPURLResponse)?.statusCode ?? -1
            //return (data,codigo)
        }catch let error as URLError where error.code == .notConnectedToInternet || error.code == .timedOut{
            throw ErrorAPI.sinConexion
        }
    }
}

func procesar<T: Decodable>(_ tipo: T.Type, data: Data, codigoHTTP: Int) throws -> [T] {

    guard (200..<300).contains(codigoHTTP) else {
        throw ErrorAPI.servidor(codigo: codigoHTTP)
    }

    let respuesta: RespuestaServicios<T>
    do {
        respuesta = try JSONDecoder().decode(RespuestaServicios<T>.self,from: data)
        print(respuesta)
    } catch {
        throw ErrorAPI.decodificacion(String(describing: error))
    }
    guard respuesta.valid == 1 else {
        throw ErrorAPI.rechazada(respuesta.message ?? "Operación no válida")
    }
    return respuesta.user ?? []
}
