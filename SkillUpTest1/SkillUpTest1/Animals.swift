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
    }
}
