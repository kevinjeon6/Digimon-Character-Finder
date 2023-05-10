//
//  FavoriteCell.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 4/29/23.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let identifier = "FavoriteCell"
    
    
    private var digimonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupFavoritesUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        digimonImageView.image = UIImage(systemName: "x.circle") //If failed to set imageView then it'll have a x with circle
    }

    // convert the URL string to an actual image object and set it to the UIImageView instance in the cell.
    func setFave(favorite: Digimon) {
        digimonTitleLabel.text = favorite.name
        digimonLevelLabel.text = favorite.level
        
        
        guard let imageUrl = URL(string: favorite.img) else { return }
        
        imageContext += 1
        let startingContext = imageContext
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl) {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    let currentContext = self.imageContext
                    if currentContext == startingContext {
                        self.digimonImageView.image = image
                    }
                }
            }
        }
    }
    
    private var imageContext: Int = 0
    
    private func setupFavoritesUI() {
        for v in [digimonImageView, digimonTitleLabel, digimonLevelLabel] {
            v.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            digimonImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            digimonImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            digimonImageView.heightAnchor.constraint(equalToConstant: 80),
            digimonImageView.widthAnchor.constraint(equalToConstant: 80),
            
            digimonTitleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            digimonTitleLabel.leadingAnchor.constraint(equalTo: digimonImageView.trailingAnchor, constant: 14),
            digimonTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            digimonTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            digimonLevelLabel.leadingAnchor.constraint(equalTo: digimonImageView.trailingAnchor, constant: 14),
            digimonLevelLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            digimonLevelLabel.topAnchor.constraint(equalTo: digimonTitleLabel.bottomAnchor),
        
        ])
    }

}
