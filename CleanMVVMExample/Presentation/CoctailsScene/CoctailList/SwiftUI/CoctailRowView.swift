//
//  CoctailRowView.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 6/07/21.
//

import SwiftUI

struct CoctailRowView: View {
    
    var item: CoctailListItemViewModel
    
    var imagePath: URL {
        // add place holder image -_-
        return URL(string: item.imagePath ?? "") ?? URL(fileURLWithPath: "")
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: imagePath) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            .frame(width: 50, height: 50)
        }
        Text(item.name)
        Spacer()
    }
    
}

struct CoctailRowView_Previews: PreviewProvider {
    static var previews: some View {
        let mockCocktail = Coctail(id: "1",
                                   name: "margarita",
                                   category: "test",
                                   instructions: "test",
                                   imagePath: "test")
        CoctailRowView(item: CoctailListItemViewModel(coctail: mockCocktail))
    }
}
