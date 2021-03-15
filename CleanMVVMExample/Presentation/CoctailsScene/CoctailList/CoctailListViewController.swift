//
//  CoctailsListViewController.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 2/03/21.
//

import UIKit

final class CoctailListViewController: UIViewController {
    
    private var viewModel: CoctailListViewModel!
    private var coctailTableView: CoctailListTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    init(withViewModel vm: CoctailListViewModel) {
        super.init(nibName: "CoctailListViewController", bundle: nil)
        self.viewModel = vm
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        coctailTableView = CoctailListTableView.createView(CoctailListTableView.self)
        view.addSubview(coctailTableView)
        coctailTableView.pinToParent()
        viewModel?.didSearch(query: "Margarita")
        
        // Coctail Table setup
        coctailTableView.viewModel = viewModel
        coctailTableView.load()
        
        // Bind to items when they're load
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: CoctailListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in
            self?.updateItems()
        }
    }
    
    private func updateItems() {
        coctailTableView.reload()
    }
}
