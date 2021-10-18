import UIKit

struct Person: Codable {
    var name: String
    var age: Int
    var gender: String
    var partner: String?
    var isEmployed: Bool
}

var people = [
    Person(name:"Silvia", age: 34, gender:"Female", partner:"Luis", isEmployed: true),
    Person(name:"Luthien", age: 140, gender:"Other", isEmployed: false)
]

let encoder = JSONEncoder()
let peopleJSONData = try encoder.encode(people)

//To see sended data in a string
print(String(data: peopleJSONData, encoding: .utf8)!)
