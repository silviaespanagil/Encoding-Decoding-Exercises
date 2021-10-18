
import Foundation
import UIKit

struct gitFollower: Decodable {
    let login: String
    let id: Int
}

//function to retrieve any data, not only github link.
//  We will add a completion callback that takes an option array of gitFollower (later changed to the placeholder T). The function will be called but will only be executed after task is completed

//if we want the function to be generic in order to use it with any type of object we can specify a generic placeholder where we say we accept anything only if is decodable

func getJSON<T: Decodable>(urlString: String, completion: @escaping (T?) -> Void) {
    
    guard let url = URL(string: urlString) else {
        return
    }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
            completion(nil)
            return
        }
        guard let data = data else {
            completion(nil)
            return
        }
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            completion(nil)
            return
        }
        
        completion(decodedData)
    }.resume()
}

getJSON(urlString: "https://api.github.com/users/silviaespanagil/followers") {(followers:[gitFollower]?) in
    if let followers = followers {
        for follower in followers {
            print(follower.login)
        }
    }
}
