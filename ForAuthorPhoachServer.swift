//
//  ForAuthorPhoachServer.swift
//  PhoachingWithDB
//
//  Created by Artem Vekshin on 14.07.2023.
//

import Foundation

struct PhoachresultsForAuthorElement: Codable, Hashable, Identifiable {
    let id: Int
    let created, updated, status: String
    let userID, seminarID, authorid: Int
    let checklistid: Int?
    let title, insights, description, author: String
    let duration, dayWithTitleInJSON, quantityFailTasksForFailSeminar: String
    let resultanswer: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, created, updated, status
        case userID = "userId"
        case seminarID = "seminarId"
        case authorid, checklistid, title, insights, description, author, duration
        case dayWithTitleInJSON = "day_with_title_in_json"
        case quantityFailTasksForFailSeminar = "quantity_fail_tasks_for_fail_seminar"
        case resultanswer
    }
}

typealias PhoachresultsForAuthor = [PhoachresultsForAuthorElement]







class AuthorphoachServer: ObservableObject{
    static let shared = AuthorphoachServer()
    func sendRequestWithAuthorization(completion: @escaping ([PhoachresultsForAuthorElement]?) -> Void) {
        
        let url = URL(string: "http://90.156.205.157:8090/api/v1/users/seminars_of_users")!
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
                if let phoachDataAuth = try? JSONDecoder().decode([PhoachresultsForAuthorElement]?.self, from: data) {
                    completion(phoachDataAuth)
                    
                    
                } else {
                    print("FAILwithMy")}
            }
            
            
        }
        task.resume()
    }
}
