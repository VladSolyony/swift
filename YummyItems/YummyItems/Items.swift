//
//  Items.swift
//  OrderMaking
//
//
//  Created by macOS Catalina on 19.12.2022.
//

import Foundation

enum ItemCategory: String, Codable {
    case curry = "Curry"
    case starters = "Starters"
    case biryani = "Biryani"
    case rotiBreads = "Roti & Breads"
}

struct Item: Codable, Identifiable {
    var id, name: String
    let category: ItemCategory
    var count: Int = 0
    let cost: String
    let isVeg: Bool = true
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        category = try values.decode(ItemCategory.self, forKey: .category)
        cost = try values.decode(String.self, forKey: .cost)
    }
}

struct Menu {
    let items: [Item]
    var isExpanded: Bool = true
    var category: ItemCategory
}

extension Menu {
    
    static func allItems() -> [Menu] {
        do {
            let parsedElements: [Item] = try "OrderItems".parse()
            let items = Dictionary(grouping: parsedElements) { (element) -> ItemCategory in
                return element.category
            }
            return items.map { Menu(items: $1, category: $0) }
        } catch let error {
            print(error.localizedDescription)
        }
        return []
    }
}
