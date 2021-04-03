//
//  ReactiveExtensiones.swift
//  
//
//  Created by Mohammad Zakizadeh on 7/27/18.
//  Copyright © 2018 Storm. All rights reserved.
//

import Foundation


import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView

protocol loadingViewable {
    func startAnimating()
    func stopAnimating()
}

extension UIViewController: loadingViewable {
    func startAnimating() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            let dimmedView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            dimmedView.tag = -1991
            dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            
            let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.midX - 50 / 2,
                                                                              y: self.view.frame.midY - 50 / 2,
                                                                              width: 50 , height: 50), color: .white)
                    activityIndicatorView.type = .ballClipRotatePulse
//            activityIndicatorView.type = .pacman
            dimmedView.addSubview(activityIndicatorView)
            self.view.addSubview(dimmedView)
            activityIndicatorView.startAnimating()
        }
        
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.view.subviews.forEach{
                if $0.tag == -1991 {
                    self.view.isUserInteractionEnabled = true
                    $0.removeFromSuperview()
                    return
                }
            }
        }
    }
}

extension Reactive where Base: UIViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }
    
}

