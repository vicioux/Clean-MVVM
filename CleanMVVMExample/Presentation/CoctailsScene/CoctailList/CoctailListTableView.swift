//
//  CoctailListTableView.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 15/03/21.
//

import UIKit

class CoctailListTableView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: CoctailListViewModel?
    
    open func load(withViewModel vm: CoctailListViewModel) {
        self.viewModel = vm
    }
}

extension CoctailListTableView: UITableViewDelegate {
    
}

extension CoctailListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

