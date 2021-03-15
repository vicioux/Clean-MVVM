//
//  CoctailListTableView.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 15/03/21.
//

import UIKit

class CoctailListTableView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CoctailListViewModel!
    
    open func load() {
        setupTableView()
    }
    
    public func reload() {
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(CoctailListTableViewCell.self)
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = 60
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CoctailListTableView: UITableViewDelegate {
    
}

extension CoctailListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CoctailListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CoctailListTableViewCell
        return cell
    }
}

