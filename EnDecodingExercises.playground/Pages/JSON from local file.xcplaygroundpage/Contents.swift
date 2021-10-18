
import UIKit
import Foundation
import Darwin

//Viendo el json armamos las propiedades del struct

struct ColorPalette: Decodable {
    struct PaletteColor: Decodable {
        let sort_order: Int
        let description: String
        let red: Int
        let green: Int
        let blue: Int
        let alpha: Double
    }
    let palette_name: String
    let palette_info: String
    let palette_colors:[PaletteColor]
}

guard let sourcesURL = Bundle.main.url(forResource: "FlatColors", withExtension: "json") else { fatalError("Could not find FlatColor")}

guard let colorData = try? Data(contentsOf: sourcesURL) else {
    fatalError("Could not convert data")
}

let decoder = JSONDecoder()

guard let flatColors = try? decoder.decode(ColorPalette.self, from: colorData) else { fatalError("Something happened decoding")
}

print(flatColors.palette_name)

for color in flatColors.palette_colors {
    print(color.description)
}
