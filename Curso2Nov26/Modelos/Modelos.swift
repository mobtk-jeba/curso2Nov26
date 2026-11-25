//
//  Models.swift
//  Curso2Nov26
//
//  Created by CARLOS GABRIEL TORRES PAEZ on 24/11/26.
//

struct RespuestaServicios<T: Decodable>: Decodable {
    let valid: Int
    let message: String?
    let user: [T]?
}

struct Usuario: Decodable {
    let id: Int
    let name: String?
    let age: Int?
    let email: String?
    let numemp: String?

    enum CodingKeys: String, CodingKey {
        case id = "usrid"
        case name = "usrname"
        case age = "usrage"
        case email = "usrmail"
        case numemp = "usrnumemp"
    }

}
