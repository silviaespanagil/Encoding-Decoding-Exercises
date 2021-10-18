
import Foundation

let personsJSON = """
[
    {
        "name": "James",
        "age": 45,
        "gender": "Male",
        "sign": "Sagitarius",
        "partner": "Emily",
        "isEmployed": true
    },
    {
        "name": "Mary",
        "age": 45,
        "gender": "Female",
        "sign": "Taurus",
        "isEmployed": false
    }
]
"""
struct Person: Decodable {
let name: String
let age: Int
let gender: String
let sign: String
let partner : String?
let isEmployed: Bool
}

let decoder = JSONDecoder()

//Convert string to data
let personsJSONData = personsJSON.data(using: .utf8)!

//Decode the data, as is an Array we need an array of person
let personsArray = try! decoder.decode([Person].self, from: personsJSONData)

for person in personsArray {
    print("\(person.name)'s partner is \(person.partner ?? "none")")
    
}
