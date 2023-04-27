//
//  DigimonCell.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 4/16/23.
//

import UIKit

class DigimonCell: UITableViewCell {
    
    static let identifier = "DigimonCell"
    
    // MARK: - Properties
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
   
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //FIRST thing to do
    
        //Now views are added to the subview
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // convert the URL string to an actual image object and set it to the UIImageView instance in the cell.
    func set(imageUrlString: String, label: String, level: String) {
        digimonTitleLabel.text = label
        digimonLevelLabel.text = level
        
        guard let imageUrl = URL(string: imageUrlString) else {
            return
        }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl) {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.digimonImageView.image = image
                }
            }
        }
    }

    
    
    private func setupUI() {
        contentView.addSubview(digimonImageView)
        contentView.addSubview(digimonTitleLabel)
        contentView.addSubview(digimonLevelLabel)

        digimonImageView.translatesAutoresizingMaskIntoConstraints = false
        digimonTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        digimonLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            digimonImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            digimonImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            digimonImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            
//            digimonImageView.heightAnchor.constraint(equalToConstant: 90),
            digimonImageView.widthAnchor.constraint(equalToConstant: 90),
            
            
            digimonTitleLabel.leadingAnchor.constraint(equalTo: digimonImageView.trailingAnchor, constant: 16),
            digimonTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            digimonTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            digimonTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            digimonLevelLabel.leadingAnchor.constraint(equalTo: digimonImageView.trailingAnchor, constant: 16),
            digimonLevelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            digimonLevelLabel.topAnchor.constraint(equalTo: digimonTitleLabel.topAnchor, constant: 45),
            digimonLevelLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            
            
        ])
    }
    
    
}
