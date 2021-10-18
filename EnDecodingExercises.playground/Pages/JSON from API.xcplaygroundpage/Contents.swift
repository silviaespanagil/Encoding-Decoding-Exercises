
import Foundation
import UIKit

struct gitFollower: Decodable {
    let login: String
    let id: Int
}

//funcion to retrieve data

func getJSON() {
    guard let url = URL(string: "https://api.github.com/users/silviaespanagil/followers") else {
        return
    }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let data = data else {
            return
        }
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode([gitFollower].self, from: data) else {
            return
        }
        let followers = decodedData
        for follower in followers {
            print(follower.login)
        }
    }.resume()
}

getJSON()
