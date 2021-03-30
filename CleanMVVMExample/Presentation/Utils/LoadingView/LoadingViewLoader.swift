//
//  LoadingViewLoader.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 29/03/21.
//

import UIKit

public protocol LoadingViewLoader {
    func showNetworkActivityIndicator(show: Bool)
    func addLoadingHUD<T: LoadingViewType>(_ T: T.Type, inView: UIView?)
    func removeLoadingHUD<T: LoadingViewType>(_ T: T.Type, _ completion: (() -> Void)?)
}

extension LoadingViewLoader {
    public func showNetworkActivityIndicator(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    public func addLoadingHUD<T: LoadingViewType>(_ T: T.Type, inView: UIView?) {
        showNetworkActivityIndicator(show: true)
        T.addLoadingView(inView: inView)
    }
    
    func removeLoadingHUD<T: LoadingViewType>(_ T: T.Type, _ completion: (() -> Void)? = nil ) {
        showNetworkActivityIndicator(show: false)
        T.removeLoadingView(animated: true, keepInMemory: false, completion: completion)
    }
}
