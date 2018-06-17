//
//  CollectionProvider.swift
//  SkillUpTest1
//
//  Created by Jack Wong on 2018/05/14.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

final class CollectionProvider: NSObject {
    private var items = [AnimalCellItem]()
    
    func set(items: [AnimalCellItem]) {
        self.items = items
    }
}

extension CollectionProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalCell", for: indexPath) as? CustomCollectionViewCell else {
            fatalError("No cell was found")
        }
        if !items[indexPath.row].text.isEmpty {
           cell.setText(text: items[indexPath.row].text)
        }
        if items[indexPath.row].image != nil {
            cell.setImage(image: items[indexPath.row].image)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
}
