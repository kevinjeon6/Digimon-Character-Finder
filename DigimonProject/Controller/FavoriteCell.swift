//
//  FavoriteCell.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 4/29/23.
//

import UIKit

class FavoriteCell: UITableViewCell {
    

    
    
    private var digimonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "x.circle") //If failed to set imageView then it'll have a x with circle
        imageView.tintColor = .systemRed
        return imageView
    }()
    
    
    //{} with () at the end is a constructor
    private var digimonTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.text = "Digimon name goes here"
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    
    private var digimonLevelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.text = "Digimon level goes here"
        label.minimumScaleFactor = 0.1
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
     setupFavoritesUI()
    }
    
    
    private func setupFavoritesUI() {
        contentView.addSubview(digimonImageView)
        contentView.addSubview(digimonTitleLabel)
        contentView.addSubview(digimonLevelLabel)
        
        
        NSLayoutConstraint.activate([
            digimonImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            digimonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            digimonImageView.heightAnchor.constraint(equalToConstant: 80),
            digimonImageView.widthAnchor.constraint(equalToConstant: 80),
            
            digimonTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            digimonTitleLabel.leadingAnchor.constraint(equalTo: digimonImageView.trailingAnchor, constant: 14),
            digimonTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            digimonTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            digimonLevelLabel.leadingAnchor.constraint(equalTo: digimonImageView.trailingAnchor, constant: 14),
            digimonLevelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            digimonLevelLabel.topAnchor.constraint(equalTo: digimonTitleLabel.bottomAnchor),
        
        ])
    }

}
