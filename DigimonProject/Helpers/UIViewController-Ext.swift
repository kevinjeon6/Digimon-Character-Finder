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
    
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = AlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
