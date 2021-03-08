//
//  CoctailsListViewController.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 2/03/21.
//

import UIKit

final class CoctailListViewController: UIViewController {
    
    private var viewModel: CoctailListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(withViewModel vm: CoctailListViewModel) {
        super.init(nibName: "CoctailListViewController", bundle: nil)
        self.viewModel = vm
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
