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

nonisolated struct APIClient {
    private let url = URL(string: "https://cognitus.administradordemo.info/processrequest/processrequest-add")!
    private let campo = "datacog"

    func enviar(_ consulta: String) async throws -> (Data, Int) {
        print(consulta)
        let base64 = Data(consulta.utf8).base64EncodedString()
        print(base64)
        let valor = base64.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "\(campo)=\(valor)".data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            let codigo = (response as? HTTPURLResponse)?.statusCode ?? -1
            return (data,codigo)
        }catch let e as URLError where e.code == .notConnectedToInternet{
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
