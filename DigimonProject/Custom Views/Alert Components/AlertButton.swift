//
//  AlertButton.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 5/9/23.
//

import UIKit

class AlertButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        set(color: backgroundColor, title: title)
   
    }
    
    // MARK: - Set up UI
    private func configureButton() {
        configuration = .filled()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    final func set(color: UIColor, title: String) {
        configuration?.baseBackgroundColor = color
        configuration?.title = title
    }
    
    

}
