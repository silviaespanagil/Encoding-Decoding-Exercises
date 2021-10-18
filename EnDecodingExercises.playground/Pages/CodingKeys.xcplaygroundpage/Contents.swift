
import UIKit
import Foundation
import Darwin

//Taking the JSON from local array code, we are gonna change the properties name, as the JSON sends snake case and we want camelCase as is a better practice

/*
 If we only want to change from snake to camel
 a) We change properties manually to camelCase
 b) We fix the code where we call the properties so we are calling the new ones
 c) We add the keyDecodingStrategy
 decoder.keyDecodingStrategy = .convertFromSnakeCase
 */

/*
 If we want to change the names as to use others
 a) Create an enum for ALL the properties. Enum must be String and call the CodingKey protocole. Each case has the property name we want and the one that references
 b) Change properties name to the ones defined by the enum
 c) Change code properties
 */

struct ColorPalette: Decodable {
    enum codingKeys: String, CodingKey{
        case name = "palette_name"
        case info = "palette_info"
        case colors = "palette_colors"
    }
    
    struct PaletteColor: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case order = "sort_order"
            case description = "description"
            case red = "red"
            case green = "green"
            case blue = "blue"
            case alpha = "alpha"
        }
        
        let order: Int
        let description: String
        let red: Int
        let green: Int
        let blue: Int
        let alpha: Double
    }
    let name: String
    let info: String
    let colors: [PaletteColor]
}

guard let sourcesURL = Bundle.main.url(forResource: "FlatColors", withExtension: "json") else {
    fatalError("Could not find FlatColors.json")
}

guard let colorData = try? Data(contentsOf: sourcesURL) else {
    fatalError("Could not convert data")
}

let decoder = JSONDecoder()

guard let flatColors = try? decoder.decode(ColorPalette.self, from: colorData) else {
    fatalError("There was a problem decoding the data....")
}

print(flatColors.name)

/*for color in flatColors.colors {
    print(color.description)
}*/
