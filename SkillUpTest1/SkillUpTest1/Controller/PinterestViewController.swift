//
//  PinterestViewController.swift
//  SkillUpTest1
//
//  Created by Jack Wong on 2018/05/12.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit
import Crashlytics

final class PinterestViewController: UIViewController {
    //MARK: -IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: -Properties
    private let collectionProvider = CollectionProvider()
    private var photos = Animals.fetch()
    private let customTransition = CustomTransition()
    private var cell = CustomCollectionViewCell()
    //MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerNib()
        setupFlowLayout()
    }

}

//MARK: -func
extension PinterestViewController {
    private func setupCollectionView(){
       collectionProvider.set(items: photos)
        collectionView.dataSource = collectionProvider
        collectionView.delegate = self
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        
    }
    private func registerNib(){
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AnimalCell")
    }
    private func setupFlowLayout(){
        if let flowLayout = collectionView.collectionViewLayout as? PinterestLayout {
            //flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
            flowLayout.delegate = self
        }
    }
   private func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
        
    }
}

//MARK: -CollectionViewDelegate
extension PinterestViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        
        guard let selectedPhoto = cell.animalImg.image else {
            return
        }
        let previewVC = PreviewViewController.make(with: selectedPhoto)
        previewVC.transitioningDelegate = self
        self.present(previewVC, animated: true, completion: nil)
    }
}

//MARK: -PinterestLayoutDelegate
extension PinterestViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return (photos[indexPath.item].image?.size.height)!
    }
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath) -> CGFloat {
        let height = heightForLabel(text: photos[indexPath.item].text, font: UIFont(name: "Verdana", size: 17)!, width: collectionView.bounds.size.width / 2)
        print("Height \(height)")
        return height
    }
}
//MARK: - UIViewControllerTransitioningDelegate
extension PinterestViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("custom transition")
        guard let originFrame = cell.superview?.convert(cell.frame, to: nil) else {
            return customTransition
        }
        customTransition.originFrame = originFrame
        customTransition.presenting = true
    
        return customTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("dismiss")
        customTransition.presenting = false 
        return customTransition
    }
}

