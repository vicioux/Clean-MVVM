//
//  CoctailResponseDTO.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 22/02/21.
//

import Foundation

//    typealias Identifier = String
//
//    let id: Identifier
//    let name: String
//    let category: String?
//    let instructions: String?
//    let tags: [String] = []
//    let ingredients: [Ingredient] = []
//    let imagePath: String?

struct CoctailResponseDTO: Decodable {
    let id: String
    let name: String
    let category: String
    let instructions: String?
    let imagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case instructions = "strInstructions"
        case imagePath = "strDrinkThumb"
    }
}

struct CoctailsResponseDTO: Decodable {
    let drinks: [CoctailResponseDTO]
    
    enum CodingKeys: String, CodingKey {
        case drinks = "drinks"
    }
}

//"idDrink": "16158",
//"strDrink": "Whitecap Margarita",
//"strDrinkAlternate": null,
//"strTags": null,
//"strVideo": null,
//"strCategory": "Other/Unknown",
//"strIBA": null,
//"strAlcoholic": "Alcoholic",
//"strGlass": "Margarita/Coupette glass",
//"strInstructions": "Place all ingredients in a blender and blend until smooth. This makes one drink.",
//"strInstructionsES": null,
//"strInstructionsDE": "Alle Zutaten in einen Mixer geben und mischen.",
//"strInstructionsFR": null,
//"strInstructionsIT": "Metti tutti gli ingredienti in un frullatore e frulla fino a che non diventa liscio.",
//"strInstructionsZH-HANS": null,
//"strInstructionsZH-HANT": null,
//"strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/srpxxp1441209622.jpg",
//"strIngredient1": "Ice",
//"strIngredient2": "Tequila",
//"strIngredient3": "Cream of coconut",
//"strIngredient4": "Lime juice",
//"strIngredient5": null,
//"strIngredient6": null,
//"strIngredient7": null,
//"strIngredient8": null,
//"strIngredient9": null,
//"strIngredient10": null,
//"strIngredient11": null,
//"strIngredient12": null,
//"strIngredient13": null,
//"strIngredient14": null,
//"strIngredient15": null,
//"strMeasure1": "1 cup ",
//"strMeasure2": "2 oz ",
//"strMeasure3": "1/4 cup ",
//"strMeasure4": "3 tblsp fresh ",
//"strMeasure5": null,
//"strMeasure6": null,
//"strMeasure7": null,
//"strMeasure8": null,
//"strMeasure9": null,
//"strMeasure10": null,
//"strMeasure11": null,
//"strMeasure12": null,
//"strMeasure13": null,
//"strMeasure14": null,
//"strMeasure15": null,
//"strImageSource": null,
//"strImageAttribution": null,
//"strCreativeCommonsConfirmed": "No",
//"dateModified": "2015-09-02 17:00:22"
