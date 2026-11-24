import UIKit
import SwiftUI

protocol Figura {
    var nombre: String { get }
    func area() -> Double
}

struct Rectangulo: Figura {
    let ancho: Double
    let alto: Double

    var nombre: String = "Rectangulo"
    func area() -> Double {
        return ancho * alto
    }
}

struct Circulo: Figura {
    let radio: Double
    let nombre = "Circulo"
    func area() -> Double {
        return .pi * radio * radio
    }
}

extension Figura {
    func describir()-> String {
        "\(self.nombre) de area \(self.area().formatted(.number.precision(.fractionLength(2))))"
    }
}



let figuras: [Figura] = [Rectangulo(ancho: 5, alto: 8),
                         Circulo(radio: 3)]

/*for figura in figuras {
    print(figura.describir())
}*/

///----------------------------------

protocol Contador{
    var valor: Int { get set }
    mutating func incrementar()
    static var nombreTipo: String {get}
    init(inicial:Int)
}

struct ContadorSimple: Contador {
    var valor: Int
    static let nombreTipo: String = "Simple"
    init(inicial: Int) {
        self.valor = inicial
    }
    mutating func incrementar() {
        valor += 1
    }
}

/*
var cont = ContadorSimple(inicial: 3)
print(cont.valor)
cont.incrementar()
print(cont.valor)

Equatable
Hashable
Comparable
Identifiable
CustomStringConvertible
Codable*/

struct Tarea: Identifiable, Equatable, Comparable, CustomStringConvertible {

    let id: Int
    var titulo: String
    var prioridad: Int

    static func < (a: Tarea, b: Tarea) -> Bool{
        a.prioridad < b.prioridad
    }

    var description:
        String {"#\(id) \(titulo) (prioridad  \(prioridad))"}
}

let tareas: [Tarea] = [
    .init(id: 1, titulo: "Aprender Swift", prioridad: 1),
    .init(id: 2, titulo: "Aprender CoreData", prioridad: 3),
    .init(id: 3, titulo: "Aprender SwiftUI", prioridad: 2)
]

//print(tareas.sorted())
//print(tareas[0] == tareas[1])

func imprimirOrdenadas<T: Comparable & CustomStringConvertible>(_ lista: [T]){
    for x in lista.sorted() {
        print(x.description)
    }
}

//imprimirOrdenadas(tareas)
//imprimirOrdenadas(figuras)

//----------------------------------------------------------------

/*
Notificable
titulo y mensaje
resumen(titulo:mensaje)

AvisoTarea
AvisoNoticia*/

protocol Notificable {
    var titulo: String { get }
    var mensaje: String { get }
}

extension Notificable {
    func resumen() -> String {
        "\(titulo): \(mensaje)"
    }
}

struct AvisoTarea: Notificable {
    var titulo: String {"Nueva tarea"}
    var mensaje: String {tarea}
    let tarea: String
}

struct AvisoNoticia: Notificable {
    let titulo: String
    let mensaje: String
}

let avisos: [any Notificable] = [
    AvisoTarea(tarea: "Solo terminala"),
    AvisoNoticia(titulo: "Nueva noticia", mensaje: "No has hecho la tarea")
]

//avisos.forEach{print($0.resumen())}
//----------------------------------------------------------------


func primerEntero(_ lista: [Int]) -> Int? {
    lista.isEmpty ? nil : lista[0]
}

func primerString(_ lista: [String]) -> String? {
    lista.isEmpty ? nil : lista[0]
}

func primero<T>(_ lista: [T]) -> T? {
    lista.isEmpty ? nil : lista[0]
}

primero([1,2,3])
primero(["Uno","Dos","Tres"])

//[String] Array<String>
//String? Optional<String>
//[String: Int] Dictionary<String,Int>

struct Pila<Elemento>{
    private var elementos: [Elemento] = []

    mutating func meter(_ e: Elemento) {
        elementos.append(e)
    }
    mutating func sacar() -> Elemento? {
        elementos.popLast()
    }
    var tope: Elemento? {
        elementos.last
    }
    var estaVacia: Bool {
        elementos.isEmpty
    }
}

var historial = Pila<String>()
historial.meter("Login")
historial.meter("Menu")
historial.meter("Noticias")
//print(historial.tope!)
historial.sacar()
//print(historial.tope!)
//historial.meter(5)

func maximo<T:Comparable>(_ lista:[T]) -> T?{
    guard var mayor = lista.first else {return nil}
    for x in lista where x > mayor {
        mayor = x
    }
    return mayor
}

maximo([4,9,2])
maximo(["pera","uva","kiwi"])

func buscarPorId<T>(_ id: T.ID, en lista: [T]) ->T? where T: Identifiable {
    lista.first(where: {$0.id == id})
}

buscarPorId(2, en: tareas)



func decodificar<T:Decodable>(_ tipo: T.Type, de data: Data) throws -> T {
    try JSONDecoder().decode(tipo, from: data)
}

struct Post: Decodable {
    let id: Int
    let title: String
}

let json = #"{"id":1,"title":"Hello, World!"}"#.data(using: .utf8)!
let post = try decodificar(Post.self, de: json)
//print(post.title)



protocol Repositorio {
    associatedtype Elemento
    func todos() -> [Elemento]
}

struct RepositorTareas: Repositorio {
    func todos() -> [Tarea] {tareas}
}


//any / some

func figuraFavorita() -> some Figura{
    Circulo(radio: 2)
}

/*
func figuraAzar() -> some Figura{
    if Bool.random() {
        return Circulo(radio: 1)
    }
    return Rectangulo(ancho: 1, alto: 2)
}*/

func figuraAzar() -> any Figura{
    if Bool.random() {
        return Circulo(radio: 1)
    }
    return Rectangulo(ancho: 1, alto: 2)
}

struct Respuesta<T>{
    let valido: Int
    let mensaje: String?
    let datos: [T]

    func primerDato() -> T? {datos.first}
}

let r1 = Respuesta(valido: 1, mensaje: nil, datos: ["a","b"])
let r2 = Respuesta(valido: 1, mensaje: "OK", datos: tareas)
//print(r1.primerDato() ?? "", r2.primerDato()?.titulo ?? "")



//MANEJO DE ERRORES ------------------------------------------------------

enum ErrorLogin: Error {
    case usuarioVacio
    case passwordCorto(minimo:Int)
    case credencialesInvalidas
}

extension ErrorLogin:LocalizedError{
    var errorDescription: String?{
        switch self{
        case .usuarioVacio: "Escribe tu usuario"
        case .passwordCorto(let minimo): "la contraseña debe tener al menos \(minimo) caracteres"
        case .credencialesInvalidas: "Usuario o contraseña incorrectos"
        }
    }
}

func validarLogin(usuario:String, password: String) throws -> String {
    guard !usuario.isEmpty else {throw ErrorLogin.usuarioVacio}
    guard password.count >= 8 else {throw ErrorLogin.passwordCorto(minimo: 8)}
    guard usuario == "admin" && password == "12345678" else {throw ErrorLogin.credencialesInvalidas}
    return "Bienvenido \(usuario)"
}

do{
    let saludo = try validarLogin(usuario: "ana", password: "12345678")
    //print(saludo)
}catch {
    //print(error.localizedDescription)
}

let saludo = try? validarLogin(usuario: "ana", password: "12345678")

//let seguro = try! validarLogin(usuario: "admin", password: "12")

func iniciarSesion(usuario:String, password:String) throws{
    let saludo = try validarLogin(usuario: usuario, password: password)
    print(saludo)
}
/*
do{
    let resultado = try iniciarSesion(usuario: "", password: "")
}catch{
    print(error.localizedDescription)
}*/

func cargarFatos() throws {
    print("Mostrar inidicador")
    defer { print("Ocultar indicador")}
    _ = try validarLogin(usuario: "admin", password: "12345678")
    print("Datos cargados")
}

//try? cargarFatos()

func validar(_ usuario: String, completion:(Result<String, ErrorLogin>) -> Void){
    if usuario.isEmpty {
        completion(.failure(.usuarioVacio))
    }else{
        completion(.success("Hola \(usuario)"))
    }
}
/*
validar(""){resultado in
    switch resultado{
    case .success(let saludo): print(saludo)
    case .failure(let error): print(error.localizedDescription)
    }
}*/

//closures avanzados----------------------------------------------

func crearContador() -> () -> Int {
    var cuenta = 0
    return {
        cuenta += 1
        return cuenta
    }
}

let contadorA = crearContador()
contadorA()
contadorA()
contadorA()

let contadorB = crearContador()
contadorB()

var mensaje = "Hola"
let porReferencia = {print(mensaje)}
let porValor = {[mensaje] in print(mensaje)}

mensaje = "Adios"
//porReferencia()
//porValor()

//@escaping
var pendientes: [() -> Void] = []

func ejecutarAhora(_ trabajo:() -> Void){
    trabajo()
}

@MainActor
func programar(_ trabajo: @escaping () -> Void){
    pendientes.append(trabajo)
}
/*
programar {
    print("Tarea 1")
}
programar {
    print("Tarea 2")
}
//pendientes.forEach{$0()}*/

//trailing closures
/*UIView.animate(withDuration: 0.3, animations: {
    print("animando")
}, completion: {_ in
    print("termino")
})

UIView.animate(withDuration: 0.3){
    print("animando2")
} completion: { _ in
    print("termino2")
}*/

Button {
    print("tocado")
} label:{
    Text("Entrar")
}



struct Pendiente {
    let titulo: String
    let prioridad: Int
    let terminada: Bool
}

let lista = [
    Pendiente(titulo: "Instalar Xcode", prioridad: 1, terminada: true),
    Pendiente(titulo: "Leer guía", prioridad: 3, terminada: false),
    Pendiente(titulo: "Crear repo", prioridad: 2, terminada: false)
]

lista.map{$0.titulo}
lista.map(\.titulo)
lista.filter{!$0.terminada}
lista.sorted{$0.prioridad < $1.prioridad}
lista.first{$0.prioridad == 2}?.titulo
lista.contains{$0.terminada}
lista.reduce(0){$0 + $1.prioridad}
["1","dos","3"].compactMap{Int($0)}

let porHacer = lista
    .filter {!$0.terminada}
    .sorted { $0.prioridad < $1.prioridad }
    .map(\.titulo)
//print(porHacer)


//property wrappers-----------

class PantallaNoticias{
    lazy var formateador: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd/MM/yyyy"
        f.locale = Locale(identifier: "es_MX")
        return f
    }()

    var noticias: [String] = []{
        didSet {
            print("Recargando tabla: \(oldValue.count) -> \(noticias.count) noticias")
        }
    }

    private(set) var cargando = false

    func cargar(){
        cargando = true
        noticias = ["Bienvenidos","Nuevo curso"]
        cargando = false
    }
}
/*
let pantalla = PantallaNoticias()
pantalla.cargar()
print(pantalla.cargando)*/


@propertyWrapper
struct Recortado {
    private var valor = ""

    var wrappedValue: String {
        get { valor }
        set { valor = newValue.trimmingCharacters(in: .whitespacesAndNewlines)}
    }

    init(wrappedValue: String){
        self.wrappedValue = wrappedValue
    }
}

struct Registro{
    @Recortado var correo: String = ""
    @Recortado var nombre: String = ""
}

var r = Registro()
r.correo = "   juan@ejemplo.com  "
//print("[\(r.correo)]")


@propertyWrapper
struct Limitado{
    private var valor: Int
    private let rango: ClosedRange<Int>

    var wrappedValue: Int {
        get { valor }
        set { valor = min(max(newValue, rango.lowerBound), rango.upperBound) }
    }
    
    init(wrappedValue: Int, rango: ClosedRange<Int>){
        self.rango = rango
        self.valor = min(max(wrappedValue, rango.lowerBound), rango.upperBound)
    }
}

struct Evaluacion{
    @Limitado(rango: 6...10) var calificacion: Int = 5
}

var e = Evaluacion()
e.calificacion = 4
//print(e.calificacion)



@propertyWrapper
struct Validado{
    var wrappedValue: String
    var projectedValue: Bool {
        wrappedValue.contains("@")
    }
}

struct Formulario{
    @Validado var email: String = ""
}

var f = Formulario()
f.email = "juan@ejemplo.com"
//print(f.email)
//print(f.$email)


///CONCURRENCIA----- async/await

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

func prepararCafe() async -> String {
    print("Preparando...")
    try? await Task.sleep(for: .seconds(2))
    return "Cafe listo"
}
/*
Task{
    let cafe = await prepararCafe()
    print(cafe)
}

print("Mientras sigo trabajando...")*/

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

// 2. Respuesta genérica
struct RespuestaServicios<T: Decodable>: Decodable {
    let valido: Bool
    let mensaje: String?
    let datos: [T]?
}

L

// 3. Procesar
func procesar<T: Decodable>(_ tipo: T.Type, data: Data, codigoHTTP: Int) throws -> [T] {

    guard (200..<300).contains(codigoHTTP) else {
        throw ErrorAPI.servidor(codigo: codigoHTTP)
    }

    let respuesta: RespuestaServicios<T>
    do {
        respuesta = try JSONDecoder().decode(RespuestaServicios<T>.self,from: data)
    } catch {
        throw ErrorAPI.decodificacion(String(describing: error))
    }
    guard respuesta.valido else {
        throw ErrorAPI.rechazada(respuesta.mensaje ?? "Operación no válida")
    }
    return respuesta.datos ?? []
}

struct Post2: Decodable,Identifiable{
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

struct Autor: Decodable,Identifiable{
    let id: Int
    let name: String
    let email: String
}

func cargarPost(id:Int) async throws -> Post2{
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")!
    let (data,respuesta) = try await URLSession.shared.data(from: url)
    guard let http = respuesta as? HTTPURLResponse else{throw
        ErrorAPI.sinConexion
    }
    guard (200..<300).contains(http.statusCode) else {
        throw ErrorAPI.servidor(codigo: http.statusCode)
    }
    return try JSONDecoder().decode(Post2.self, from: data)
}

func cargarAutor(id:Int) async throws -> Autor{
    let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(id)")!
    let (data,_) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(Autor.self, from: data)
}
/*
Task {
    do{
        let post = try await cargarPost(id: 1)
        let autor = try await cargarAutor(id: post.userId)
        print("\(post.title) - \(autor.name)")
    }catch{
        print(error.localizedDescription)
    }
}*/

func validar(_ usuario: String) async throws -> String{
    try await withCheckedThrowingContinuation{ continuacion in
        validar(usuario){resultado in
            continuacion.resume(with: resultado)
        }
    }
}


let tareaPost = Task{
    try await cargarPost(id: 1)
}
/*
Task{
    let post = try await tareaPost.value
    print(post.title)
}*/
/*
let reloj = Task{
    for segundo in 1...10{
        try await Task.sleep(for: .seconds(1))
        print("Segundo \(segundo)")
    }
    print("Terminó completo")
}

Task{
    try await Task.sleep(for: .seconds(3.5))
    reloj.cancel()
    print("Cancelado")
}*/

func contarPosts(deUsuario id: Int) async throws -> Int {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(id)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode([Post].self, from: data).count
}
/*
Task{
    let tiempo = try await ContinuousClock().measure{
        let autor = try await cargarAutor(id: 1)
        let total = try await contarPosts(deUsuario: 1)
        let post = try await cargarPost(id: 1)
        print(autor.name, total, post.title)
    }
    print("Secuencial:\(tiempo)")
}

Task{
    let tiempo = try await ContinuousClock().measure{
        async let autor = cargarAutor(id: 1)
        async let total = contarPosts(deUsuario: 1)
        async let post =  cargarPost(id: 1)
        let (a,t,p) = try await (autor,total,post)
        print(a.name, t, p.title)
    }
    print("En paralelo:\(tiempo)")
}*/

func cargarPosts(ids:[Int]) async throws -> [Post2]{
    try await withThrowingTaskGroup(of: Post2.self) { grupo in
        for id in ids{
            grupo.addTask {
                try await cargarPost(id: id)
            }
        }

        var resultado:[Post2] = []
        for try await post in grupo {
            resultado.append(post)
        }
        return resultado.sorted{$0.id < $1.id}
    }
}
/*
Task{
    let posts = try await cargarPosts(ids: [1,2,3,4,5])
    posts.forEach{print($0.id, $0.title)}
}*/

//--------------Actores

final class ContadorInseguro {
    var total = 0
}

func provocarCarrera(){
    let inseguro = ContadorInseguro()
    DispatchQueue.concurrentPerform(iterations: 1000){_ in
        inseguro.total += 1
    }
    print(inseguro.total)
}

//provocarCarrera()

actor ContadorSeguro {
    private(set) var total = 0

    func registrar(){
        total += 1
    }
}

let seguro = ContadorSeguro()
/*
Task{
    await withTaskGroup(of: Void.self){grupo in
        for _ in 1...1000{
            grupo.addTask {
                await seguro.registrar()
            }
        }
    }
    print(await seguro.total)
}*/


@MainActor
final class NoticiasViewModel {
    var titulos: [String] = []
    var cargando = false

    func cargar() async{
        cargando = true
        defer {cargando = false}
        do{
            let posts = try await cargarPosts(ids: [1,2,3])
            titulos = posts.map(\.title)
        }catch{
            print(error.localizedDescription)
        }
    }
}
/*
Task {@MainActor in
    let vm = NoticiasViewModel()
    await vm.cargar()
    print(vm.titulos)
}*/

//Sendable

class Configuracion {
    var tema = "claro"
}

func probar(){
    let config = Configuracion()
    Task.detached{
        config.tema = "otro"
        print(config.tema)
    }
}

probar()


///INTEGRACION
///
///
///

struct APIClient{
    private let url = URL(string: "https://cognitus.administradordemo.info/processrequest/processrequest-add")!
    private let campo = "datacog"


    func enviar(_ consulta: String) async throws -> (Data, Int){
        let base64 = Data(consulta.utf8).base64EncodedString()
        let valor = base64.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""

        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = "\(campo)=\(valor)".data(using: .utf8)

        do{
            let (data,respuesta) = try await URLSession.shared.data(for: request)
            let codigo = (respuesta as? HTTPURLResponse)?.statusCode ?? -1
            return (data,codigo)
        }catch let error as URLError where error.code == .notConnectedToInternet{
            throw ErrorAPI.sinConexion
        }
    }
}

struct Usuario2: Codable, Sendable{
    let user_id: Int
    let name: String?
}

struct RespuestaServicios2<T: Decodable & Sendable>: Decodable, Sendable{
    let valid: Bool
    let message: String?
    let user: [T]?

    enum CodingKeys: String, CodingKey{
        case valid
        case message
        case user = "data"
    }
}

func procesar2<T: Decodable>(_ tipo: T.Type, data: Data, codigoHTTP: Int) throws -> [T] {

    guard (200..<300).contains(codigoHTTP) else {
        throw ErrorAPI.servidor(codigo: codigoHTTP)
    }

    let respuesta: RespuestaServicios2<T>
    do {
        respuesta = try JSONDecoder().decode(RespuestaServicios2<T>.self,from: data)
    } catch {
        throw ErrorAPI.decodificacion(String(describing: error))
    }
    guard respuesta.valid else {
        throw ErrorAPI.rechazada(respuesta.message ?? "Operación no válida")
    }
    return respuesta.user ?? []
}

final class LoginViewModel {
    private(set) var cargando = false
    private(set) var mensajeError: String?
    private(set) var usuario: Usuario2?

    private let api = APIClient()

    func entrar(usuario nombre: String, password: String){
        cargando = true
        mensajeError = nil
        defer { cargando = false}

        do{
            let (data,codigo) = try await api.enviar("100|\(nombre)|\(password)")
            guard let u = try procesar(Usuario2.self, data: data, codigoHTTP: codigo) else {
                throw ErrorAPI.rechazada("El servidor no regreso los datos del usuario")
            }
        }catch{
            mensajeError = error.localizedDescription
        }
    }
}


