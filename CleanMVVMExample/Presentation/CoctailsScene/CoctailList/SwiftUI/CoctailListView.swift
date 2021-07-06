//
//  CoctailListView.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 30/06/21.
//

import SwiftUI

extension CoctailListItemViewModel: Identifiable { }

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
            }.scaledToFit()
                .frame(width: 50, height: 50)
        }
        Text(item.name)
        Spacer()
    }
    
}

struct CoctailListView: View {
    @ObservedObject var viewModelWrapper: CoctailListViewModelWrapper
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List(viewModelWrapper.coctailList) { item in
                CoctailRowView(item: item).onTapGesture {
                    viewModelWrapper.viewModel.didSelect(item: item)
                }
            }.navigationTitle("Coctails")
                .listStyle(.plain)
        }.searchable(text: $searchText)
            .onSubmit(of: .search) {
                viewModelWrapper.viewModel.didSearch(query: searchText)
            }
    }
}

final class CoctailListViewModelWrapper: ObservableObject {

    var viewModel: CoctailListViewModel
    @Published var coctailList: [CoctailListItemViewModel] = []

    init(viewModel: CoctailListViewModel) {
        self.viewModel = viewModel

        viewModel.items.observe(on: self) { [weak self]
            values in self?.coctailList = values
        }
    }
}

//struct CoctailListView_Previews: PreviewProvider {
//    static var previews: some View {
//        let wrapper = CoctailListViewModelWrapper(viewModel: UITestCoctailListViewModel())
//        CoctailListView(viewModelWrapper: wrapper)
//    }
//}
//
//class UITestCoctailListViewModel: CoctailListViewModel {
//
//    var items: Observable<[CoctailListItemViewModel]> = Observable([])
//
//    var loading: Observable<Bool> = Observable(false)
//
//    var screenTitle: String = ""
//
//    var emptyDataTitle: String = ""
//
//    var errorTitle: String = ""
//
//    var searchBarPlaceholder: String = ""
//
//    func didSearch(query: String) {
//
//    }
//
//    func didSelectItem(at: Int) {
//
//    }
//}
