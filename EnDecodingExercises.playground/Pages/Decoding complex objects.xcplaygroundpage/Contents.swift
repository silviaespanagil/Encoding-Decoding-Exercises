

import Foundation

let familyJSON = """
{
    "familyName": "Smith",
    "members": [
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
}
"""

//Como ya tenemos el struct de Person, podemos crear un Struct de la familia que tenga como propiedad el struct Person
struct Family : Decodable {
    let familyName: String
    let members: [Person]
}

struct Person: Decodable {
let name: String
let age: Int
let gender: String
let sign: String
let partner : String?
let isEmployed: Bool
}

let decoder = JSONDecoder()
let familyJSONData = familyJSON.data(using: .utf8)!
let myFamily = try! decoder.decode(Family.self, from: familyJSONData)

for member in myFamily.members {
    print("From first example \(member.name)")
}

//ANOTHER BETTER WAY

/* Person struct should be inside the family struct also, as Gender is always 1/3 options is a good practice to make an enum so we minimize possible mistakes or errors */

struct Family2: Decodable {
    
    enum Gender : String, Decodable {
        case Male, Female, Other
    }
    
    struct Person2: Decodable {
    let name: String
    let age: Int
    let gender: Gender
    let sign: String
    let partner : String?
    let isEmployed: Bool
    }
    
    let familyName: String
    let members: [Person2]
}

let myFamily2 = try! decoder.decode(Family2.self, from: familyJSONData)
print(myFamily2.familyName)
for member in myFamily2.members {
    print("From second example \(member.name)")
}
