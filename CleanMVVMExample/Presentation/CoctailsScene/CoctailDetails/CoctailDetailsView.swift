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
        ScrollView(.vertical) {
            VStack(spacing: 10)  {
                Text(self.viewModelWrapper.viewModel.name).font(.largeTitle)
                if #available(iOS 15.0, *) {
                    AsyncImage(url: self.viewModelWrapper.viewModel.imagePath) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }.scaledToFit()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                }
                Text(self.viewModelWrapper.viewModel.instructions)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .trailing], 10)
            }
        }
    }
}

final class CoctailDetailsViewModelWrapper: ObservableObject {
    var viewModel: CoctailDetailsViewModel
    @Published var coctailImage: Data?
    var imagePath: URL {
        return viewModel.imagePath
    }
    
    init(viewModel: CoctailDetailsViewModel) {
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
