//
//  DeletePhoach.swift
//  PhoachingWithDB
//
//  Created by Artem Vekshin on 21.07.2023.
//

import Foundation



import Foundation

// MARK: - PhoachresultsForMyElement
struct PhoacingDelete: Codable, Hashable, Identifiable {
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











class DeletePhoaching: ObservableObject{
    static let shared = DeletePhoaching()
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
