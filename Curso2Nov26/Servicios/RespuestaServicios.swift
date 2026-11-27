//
//  RespuestaServicios.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 26/11/26.
//

import Foundation

nonisolated struct ClaveDinamica: CodingKey {
    let stringValue: String
    var intValue: Int? {nil}
    init(_ texto: String){stringValue = texto}
    init?(stringValue: String) {self.stringValue = stringValue}
    init?(intValue: Int) {nil}
}

nonisolated protocol RespuestaConClave: Decodable, Sendable{
    static var clave: String {get}
}

nonisolated struct RespuestaServicios<T: RespuestaConClave>:Decodable,Sendable{
    let valid: Int
    let message: String?
    let datos: [T]?

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: ClaveDinamica.self)
        valid = try c.decode(Int.self, forKey: ClaveDinamica("valid"))
        message = try c.decodeIfPresent(String.self, forKey: ClaveDinamica("message"))
        datos = try c.decodeIfPresent([T].self, forKey: ClaveDinamica(T.clave))
    }
}
