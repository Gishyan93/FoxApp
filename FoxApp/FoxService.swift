//
//  FoxService.swift
//  FoxApp
//
//  Created by Tigran Gishyan on 16.04.22.
//

import UIKit

//class FoxService {
//    let defaultSession = URLSession(configuration: .default)
//
//    var dataTask: URLSessionDataTask?
//    var errorMessage = ""
//    var tracks: [Fox] = []
//    typealias QueryResults = (Fox?) -> Void
//
//    func getSearchResults(
//        searchTerm: String, completion: @escaping QueryResults
//    ) {
//        dataTask?.cancel()
//
//        if let urlComponents = URLComponents(string: searchTerm) {
//
//            guard let url = urlComponents.url else {
//                return
//            }
//
//            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
//                defer {
//                    self?.dataTask = nil
//                }
//
//                if let error = error {
//                    self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
//                } else if
//                    let data = data,
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode == 200 {
//
//                    let decoder = JSONDecoder()
//
//                    do {
//                        let fox = try decoder.decode(Fox.self, from: data)
//                        DispatchQueue.main.async {
//                            completion(fox)
//                        }
//                    } catch {
//                        print("Failed to decode JSON")
//                    }
//                }
//            }
//
//            dataTask?.resume()
//        }
//    }
//
//}

class FoxService {
    // 1.
    func getFoxImages(completion: @escaping (Fox?) -> Void) {
        URLSession.shared.dataTask(
            with: URL(string: "https://randomfox.ca/floof/")!
        ) { (data, response, error) in
            let fox = try! JSONDecoder().decode(
                Fox.self, from: data!
            )
            completion(fox)
        }.resume()
    }
}
