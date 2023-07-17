//
//  ForMyPhoachServer.swift
//  PhoachingWithDB
//
//  Created by Artem Vekshin on 14.07.2023.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let phoachresultsForMy = try? JSONDecoder().decode(PhoachresultsForMy.self, from: jsonData)

import Foundation

// MARK: - PhoachresultsForMyElement
struct PhoachresultsForMyElement: Codable, Hashable, Identifiable {
    let id: Int
    let created, updated: String
    let status: Status
    let userID: Int
    let accessgroup, title: String
    let description: String?
    let author, duration: String
    let cost: JSONNull?
    let dayWithTitleInJSON, quantityFailTasksForFailSeminar: String?
    let checklistid: Int?

    enum CodingKeys: String, CodingKey {
        case id, created, updated, status
        case userID = "userId"
        case accessgroup, title, description, author, duration, cost
        case dayWithTitleInJSON = "day_with_title_in_json"
        case quantityFailTasksForFailSeminar = "quantity_fail_tasks_for_fail_seminar"
        case checklistid
    }
}

enum Status: String, Codable {
    case active = "ACTIVE"
}

typealias PhoachresultsForMy = [PhoachresultsForMyElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}










class MyphoachServer: ObservableObject{
    static let shared = MyphoachServer()
    func sendRequestWithAuthorization(completion: @escaping ([PhoachresultsForMyElement]?) -> Void) {
        
        let url = URL(string: "http://90.156.205.157:8090/api/v1/users/seminarofuser")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        
        // Устанавливаем метод запроса (GET, POST, PUT, DELETE и т.д.)
        request.httpMethod = "GET"
        
        // Устанавливаем заголовок Authorization
        let token = "Bearer_eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJuaWtlcjY4QHlhbmRleC5ydSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2ODc2NzI5NjgsImV4cCI6MTcyMzY3Mjk2OH0.g4mpGK5-xS2SA2pLBy_4GekmX-D_bU_1UdIB-wtNHJo"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Ошибка: \(error.localizedDescription)")
                return
            }
            //Acces to HTTP Server
            guard response is HTTPURLResponse else { return }

            // Обрабатываем ответ сервера
            if let data = data {
                if let phoachDataforme = try? JSONDecoder().decode([PhoachresultsForMyElement]?.self, from: data) {
                    completion(phoachDataforme)
                   
                    
                } else {
                    print("FAILwithMy")}
            }
            
            
        }
        task.resume()
    }
}
