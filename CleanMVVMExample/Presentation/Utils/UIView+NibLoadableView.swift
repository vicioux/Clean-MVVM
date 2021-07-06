//
//  UIView+NibLoadableView.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 15/03/21.
//

import UIKit

public protocol NibLoadableView: AnyObject {}

/**
 Adds a convienience initializer for views
 */

extension NibLoadableView {
    public static var NibName: String {
        return String(describing: self)
    }
    
    public static func createView<T>(_: T.Type, inBunddleWithName: String? = nil, withIndexInXib indexInXib: Int = 0) -> T where T: NibLoadableView {
        if let customBundle = inBunddleWithName, let bundle = Bundle(identifier: customBundle) {
            return bundle.loadNibNamed(T.NibName, owner: nil, options: nil)![indexInXib] as! T
        }
        
        return Bundle.main.loadNibNamed(T.NibName, owner: nil, options: nil)![indexInXib] as! T
    }
}

extension UIView: NibLoadableView { }
