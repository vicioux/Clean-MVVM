//
//  UITableView+Utils.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 15/03/21.
//

import UIKit

extension UITableView {
    func register<T:UITableViewCell>(_: T.Type) where T:ReusableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.NibName, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T:UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: Self.self)
    }
}
