//
//  EmptyView.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 5/7/23.
//

import UIKit

class EmptyView: UIView {
    
    // MARK: - Properties
    
    private var emptyTitleText: UILabel = {
        let emptyText = UILabel()
        emptyText.textColor = .secondaryLabel
        emptyText.adjustsFontSizeToFitWidth = true
        emptyText.minimumScaleFactor = 0.9
        emptyText.lineBreakMode = .byTruncatingTail
        emptyText.textAlignment = .center
        emptyText.numberOfLines = 3
        emptyText.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        emptyText.translatesAutoresizingMaskIntoConstraints = false
        return emptyText
    }()
    
    private var logoImageView: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "digimon-logo")
        logoImage.translatesAutoresizingMaskIntoConstraints = false
  
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureMessageLabel()
        configureLogoImage()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        emptyTitleText.text = message
        configure()
    }
    
    
    
    // MARK: - Setup UI
    private func configure() {
        addSubview(emptyTitleText)
        addSubview(logoImageView)
    }
    
   
    
    private func configureMessageLabel() {
        NSLayoutConstraint.activate([
            emptyTitleText.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150), // -150 is shifting it UP from the center Y
            emptyTitleText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            emptyTitleText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            emptyTitleText.heightAnchor.constraint(equalToConstant: 200)
        
        ])
    }
    
    private func configureLogoImage() {
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}
