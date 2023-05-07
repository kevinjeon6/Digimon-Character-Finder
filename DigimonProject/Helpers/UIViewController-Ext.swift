//
//  UIViewController-Ext.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 5/7/23.
//

import UIKit

extension UIViewController {
    
    
    func showEmptyView(with message: String, in view: UIView) {
        let emptyView = EmptyView(message: message)
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
    }
}
