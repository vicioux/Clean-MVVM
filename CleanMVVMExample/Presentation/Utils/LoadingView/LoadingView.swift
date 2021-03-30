//
//  LoadingView.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 29/03/21.
//

import UIKit

/**
 Defines a loadin view basic functionality
 */

public protocol LoadingViewType: class {
    static func addLoadingView(inView containerView: UIView?)
    static func removeLoadingView(animated anim: Bool, keepInMemory: Bool, completion: (() -> Void)?)
}

open class LoadingView: UIView, LoadingViewType {
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var activityViewContainer: UIView!
    
    fileprivate weak var containerView: UIView?
    
    static var currentView: LoadingView?
    public var activityViewContainerColor: UIColor = .black
    public var activityViewContainerAlpha: CGFloat = 0.60
    
    
    deinit {
        LoadingView.currentView = nil
        print("DEINIT LoadingView")
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        activityViewContainer.backgroundColor = activityViewContainerColor
        activityViewContainer.alpha = activityViewContainerAlpha
        
    }
    
    public static func addLoadingView(inView containerView: UIView?) {
        
        /**
         Only one loading view is allowed at a time
         */
        guard self.currentView == nil else {
            if self.currentView!.superview == nil {
                self.currentView!.activityView.startAnimating()
                let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
                keyWindow?.addSubview(self.currentView!)
                self.currentView?.pinToParent()
            }
            return
        }
        
        let loadingControlView = LoadingView.createView(LoadingView.self)
        loadingControlView.activityView.startAnimating()
        self.currentView = loadingControlView
        
        if let inAView = containerView {
            loadingControlView.containerView = inAView
            inAView .addSubview(loadingControlView)
            loadingControlView.pinToParent()
            return
        }
        
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        keyWindow?.addSubview(loadingControlView)
        loadingControlView.pinToParent()
    }
    
    public static func removeLoadingView(animated anim: Bool = false, keepInMemory: Bool = false, completion: (() -> Void)?) {
        if anim {
            UIView.animate(withDuration: 0.2, animations: {
                self.currentView?.alpha = 0.0
            }, completion: { _ in
                self.currentView?.activityView.stopAnimating()
                self.currentView?.removeFromSuperview()
                
                self.currentView = nil
                
                if let completitionCallback = completion {
                    completitionCallback()
                }
            })
        } else {
            self.currentView?.activityView.stopAnimating()
            self.currentView?.removeFromSuperview()
            
            if !keepInMemory {
                self.currentView = nil
            }
            
            
            if let completitionCallback = completion {
                completitionCallback()
            }
        }
    }
    
    override open func layoutSubviews() {
        frame = (UIApplication.shared.keyWindow?.frame)!
    }
}
