//
//  CoctailsListViewController.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 2/03/21.
//

import UIKit

public struct AccessibilityIdentifier {
    static let searchField = "AccessibilityIdentifierSearchCoctails"
}


final class CoctailListViewController: UIViewController {
    
    private var viewModel: CoctailListViewModel!
    private var coctailTableView: CoctailListTableView!
    
    @IBOutlet private weak var searchContainerView: UIView!
    @IBOutlet private weak var coctailListContainer: UIView!
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSearchController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
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
        coctailListContainer.addSubview(coctailTableView)
        coctailTableView.pinToParent()
        
        // Coctail Table setup
        coctailTableView.viewModel = viewModel
        coctailTableView.load()
        
        // Bind to items when they're load
        bind(to: viewModel)
        
        title = viewModel.screenTitle
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

// MARK: - Search View

extension CoctailListViewController {
    
    private func setupSearchController() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = self.viewModel.searchBarPlaceholder
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchController.searchBar.barStyle = .black
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.frame = searchContainerView.bounds
        searchController.searchBar.autoresizingMask = [.flexibleWidth]
        searchContainerView.addSubview(searchController.searchBar)
        definesPresentationContext = true
        
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.accessibilityIdentifier = AccessibilityIdentifier.searchField
        }
    }
}

extension CoctailListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchController.isActive = false
        viewModel.didSearch(query: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("don't drop that shit")
    }
}

extension CoctailListViewController: UISearchControllerDelegate {
    
}
