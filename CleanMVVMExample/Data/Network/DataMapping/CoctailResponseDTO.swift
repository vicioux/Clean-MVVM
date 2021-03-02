//
//  CoctailResponseDTO.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 22/02/21.
//

import Foundation

struct CoctailsResponseDTO: Decodable {
    let drinks: [CoctailResponseDTO]
    
    enum CodingKeys: String, CodingKey {
        case drinks = "drinks"
    }
}

struct CoctailResponseDTO: Decodable {
    let id: String
    let name: String
    let category: String
    let instructions: String?
    let imagePath: String?
    let ingredients: [IngredientDTO]
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case instructions = "strInstructions"
        case imagePath = "strDrinkThumb"
    }
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: CodingKeys.id)
        self.name = try container.decode(String.self, forKey: CodingKeys.name)
        self.category = try container.decode(String.self, forKey: CodingKeys.category)
        self.instructions = try container.decode(String.self, forKey: CodingKeys.instructions)
        self.imagePath = try container.decode(String.self, forKey: CodingKeys.imagePath)
        
        var ingredients: [String] = []
        var measures: [String] = []
        var ingredientList: [IngredientDTO] = []
        
        for key in dynamicContainer.allKeys where key.stringValue.contains(find: "strIngredient")
            || key.stringValue.contains(find:"strMeasure") {
            
            if key.stringValue.contains(find: "strIngredient"),
               let ingredient
                = try dynamicContainer.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!) {
                ingredients.append(ingredient)
            }
            
            if key.stringValue.contains(find: "strMeasure"),
               let measure
                = try dynamicContainer.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!) {
                measures.append(measure)
            }
        }
        
        for (index, value) in ingredients.enumerated() {
            let measure = measures.item(at: index) ?? ""
            ingredientList.append(IngredientDTO(name: value, measure: measure))
        }
        
        self.ingredients = ingredientList
    }
}

struct IngredientDTO: Decodable {
    let name: String
    let measure: String?
}

extension CoctailsResponseDTO {
    func toDomain() -> Coctails {
        return .init(coctails: drinks.map { $0.toDomain() })
    }
}

extension CoctailResponseDTO {
    func toDomain() -> Coctail {
        return .init(id: Coctail.Identifier(id),
                     name: name,
                     category: category,
                     instructions: instructions,
                     imagePath: imagePath)
    }
}

extension IngredientDTO {
    func toDomain() -> Ingredient {
        return .init(name: name,
                     measure: measure)
    }
}

