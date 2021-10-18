import UIKit
//An array of objects but not all are the same some come as an array for example Margaret entry but others as single objects as Pierre entry

let booksJSON = """
[
  {
    "feed": {
      "publisher": "Penguin",
      "country": "ca"
    },
    "entry": [
      {
        "author": "Margaret Atwood",
        "nationality": "Canadian"
      },
      {
        "author": "Dan Brown",
        "nationality": "American"
      }
    ]
  },
  {
    "feed": {
      "publisher": "Penguin",
      "country": "ca"
    },
    "entry": {
      "author": "Pierre Burton",
      "nationality": "Canadian"
    }
  }
]
"""
struct Book: Decodable {
    enum CodingKeys: String, CodingKey{
        case feed, entry
    }
    
    struct Feed: Decodable{
        let publisher: String
        let country: String
    }
    struct Entry: Decodable{
        let author: String
        let nationality: String
    }
    let feed: Feed
    var entry: [Entry]
    //entry can't be [Entry] because we know sometimes it comes as an object so we are first creating an enum with the coding key for feed and entry. And we init it
    
    init (from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        feed = try container.decode(Feed.self, forKey: .feed)
        //for entry we use a do so we can say what to do if it first finds an array
        do {
            entry = try container.decode([Entry].self, forKey: .entry)
        } catch {
            let newValue = try container.decode(Entry.self, forKey: .entry)
            entry = [newValue]
        }
    }
}

let decoder = JSONDecoder()
let booksJSONData = booksJSON.data(using: .utf8)!
let books = try! decoder.decode([Book].self, from: booksJSONData)

for book in books {
    print(book.feed.publisher)
    for entry in book.entry {
        print(entry.author)
    }
}

/*:
Property wrappers such as @Published, do not conform to codable so is needed to create custom codingKeys
 */

/* Some property wrappers such as @Published are not codable so when we put decodable it wont compile, for such we can also use CodingKeys*/


class User: Decodable {
    enum CodingKeys: String, CodingKey{
        case name, age
    }
    @Published var name = "Aidan Lynch"
    var age = 27
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
    }
}
