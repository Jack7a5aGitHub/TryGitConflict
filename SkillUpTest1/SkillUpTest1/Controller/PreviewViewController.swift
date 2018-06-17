//
//  PreviewViewController.swift
//  SkillUpTest1
//
//  Created by Jack Wong on 2018/05/24.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

final class PreviewViewController: UIViewController {
    
    //MARK: -Properties
    private var selectedImg : UIImage?
    //MARK: -IBOutlet
    @IBOutlet weak var selectedImgView: UIImageView!
    
    // MARK: - Factory
    class func make(with image: UIImage) -> PreviewViewController {
        //let vcName = GalleryViewController.className
        guard let previewVC = UIStoryboard.viewController(storyboardName: "Preview", identifier: "preview") as? PreviewViewController else {
            fatalError("GalleryVC is nil")
        }
        previewVC.selectedImg = image
        return previewVC
        
    }
    // MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImgView.image = selectedImg
    }
    //MARK: -IBAction
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


