//
//  Animals.swift
//  SkillUpTest1
//
//  Created by Jack Wong on 2018/05/15.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

struct AnimalCellItem {
    var text = ""
    var image: UIImage?
}

final class Animals {
    static func fetch() -> [AnimalCellItem] {
        let fileName = "Animals"
        let fileType = "plist"
        let animalKey = "animals"
        let textKey = "text"
        let imageNameKey = "imageName"
        
        guard  let url = Bundle.main.url(forResource: fileName, withExtension: fileType),
               let dic = NSDictionary(contentsOf: url),
               let animals = dic[animalKey] as? [AnyObject]
        else {
            return []
        }
        var animalCellItems = [AnimalCellItem]()
        for animal in animals {
            guard
                let text = animal[textKey] as? String,
                let imageName = animal[imageNameKey] as? String,
                let image = UIImage(named: imageName) else {
                continue
            }
            animalCellItems.append(AnimalCellItem(text: text, image: image))
        }
        return animalCellItems
    }
}
