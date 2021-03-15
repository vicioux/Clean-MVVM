//
//  UIView+Constraints.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 15/03/21.
//

import Foundation
import UIKit

extension UIView {
    
    @discardableResult
    open func pinToParent(leading led: CGFloat = 0, trailing: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) -> [NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        let leading = NSLayoutConstraint.init(item: self,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: self.superview,
                                              attribute: .leading,
                                              multiplier: 1, constant: led)
        
        let trailing = NSLayoutConstraint.init(item: self,
                                               attribute: .trailing,
                                               relatedBy: .equal,
                                               toItem: self.superview,
                                               attribute: .trailing,
                                               multiplier: 1, constant: trailing)
        
        let top = NSLayoutConstraint.init(item: self,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.superview,
                                               attribute: .top,
                                               multiplier: 1, constant: top)
        
        let bottom = NSLayoutConstraint.init(item: self,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: self.superview,
                                             attribute: .bottom,
                                             multiplier: 1, constant: bottom)
        
        leading.isActive = true
        trailing.isActive = true
        top.isActive = true
        bottom.isActive = true
        
        constraints.append(contentsOf: [leading, trailing, top, bottom])
        return constraints
    }
    
}
