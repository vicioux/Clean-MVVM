//
//  CoctailDetailsViewController.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 18/03/21.
//

import UIKit

class CoctailDetailsViewController: UIViewController {
    
    private var viewModel: CoctailDetailsViewModel!
    
    init(withViewModel vm: CoctailDetailsViewModel) {
        super.init(nibName: "CoctailDetailsViewController", bundle: nil)
        self.viewModel = vm
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
