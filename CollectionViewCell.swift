
//
//  File.swift
//  IOSAssignment
//
//  Created by Srinivasulu Arigela on 22/04/24.

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CollectionViewCell{
    
    func configureUI(){
        backgroundView?.backgroundColor = .clear
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        addImageView()
    }
    
    func addImageView(){
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
        
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

        ])
    }
    
}

