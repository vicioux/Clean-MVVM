//
//  CoctailDetailsView.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 28/06/21.
//
import Foundation
import SwiftUI

extension DefaultCoctailDetailsViewModel: Identifiable { }

struct CoctailDetailsView: View {
    @ObservedObject var viewModelWrapper: CoctailDetailsViewModelWrapper
    
    var body: some View {
        Text(self.viewModelWrapper.viewModel?.name ?? "")
        
        if #available(iOS 15.0, *) {
             AsyncImage(url: URL(string: self.viewModelWrapper.viewModel?.imagePath ?? ""))
        } else {
            
        }
    }
}

final class CoctailDetailsViewModelWrapper: ObservableObject {
    var viewModel: CoctailDetailsViewModel?
    @Published var coctailImage: Data?
    
    init(viewModel: CoctailDetailsViewModel?) {
        self.viewModel = viewModel
    }
}

struct CoctailDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        CoctailDetailsView(viewModelWrapper: defaultVm)
    }
    
    static var defaultVm: CoctailDetailsViewModelWrapper = {
        let coctail = Coctail(id: "", name: "test", category: "test", instructions: "test", imagePath: nil)
        
        return CoctailDetailsViewModelWrapper(viewModel: DefaultCoctailDetailsViewModel(coctail: coctail))
    }()
}
