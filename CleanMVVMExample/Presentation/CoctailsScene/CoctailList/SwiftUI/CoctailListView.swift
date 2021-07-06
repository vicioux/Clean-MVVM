//
//  CoctailListView.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 30/06/21.
//

import SwiftUI

extension CoctailListItemViewModel: Identifiable { }

struct CoctailListView: View {
    @ObservedObject var viewModelWrapper: CoctailListViewModelWrapper
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List(viewModelWrapper.coctailList) { item in
                CoctailRowView(item: item).onTapGesture {
                    viewModelWrapper.viewModel.didSelect(item: item)
                }
            }
            .navigationTitle("Coctails")
            .listStyle(.plain)
        }
        .searchable(text: $searchText)
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
