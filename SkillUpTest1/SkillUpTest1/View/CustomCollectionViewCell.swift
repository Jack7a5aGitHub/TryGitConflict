//
//  CustomCollectionViewCell.swift
//  SkillUpTest1
//
//  Created by Jack Wong on 2018/05/14.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animalImg: UIImageView!
    @IBOutlet weak var animalText: UITextView!
    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    static var identifier: String {
        return "AnimalCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

//        containerView.layer.cornerRadius = 6
//        containerView.layer.masksToBounds = true
       
        animalImg.layer.cornerRadius = 6
        animalImg.layer.masksToBounds = true
        
    }
    
    // MARK: - Setter
    
    func setText(text: String) {
        animalLabel.text = text
        
    }
    
    func setImage(image: UIImage?) {
        animalImg.image = image
    }
}
