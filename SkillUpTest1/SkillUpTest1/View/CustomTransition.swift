//
//  CustomTransition.swift
//  SkillUpTest1
//
//  Created by Jack Wong on 2018/05/25.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

final class CustomTransition:NSObject {
    
    private let duration = 0.5
    var presenting = true
    var originFrame = CGRect.zero
    var dismissCompletion: (()->Void)?
    
}

extension CustomTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let preview = presenting ? toView:
            transitionContext.view(forKey: .from)!
        let initialFrame = presenting ? originFrame : preview.frame
        let finalFrame = presenting ? preview.frame : originFrame
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            preview.transform = scaleTransform
            preview.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            preview.clipsToBounds = true
        }
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: preview)
        // Opening animation
        if presenting {
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear ,animations: {
            preview.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
            preview.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }) { (_) in
            
          
            transitionContext.completeTransition(true)
        }
        } else {
            // closing animation
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
                preview.transform = scaleTransform
                preview.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            }) { (_) in
                if !self.presenting {
                    self.dismissCompletion?()
                }
                transitionContext.completeTransition(true)
            }
        }
//        toView.alpha = 0.0
//        UIView.animate(withDuration: duration, animations: {
//            toView.alpha = 1.0
//        }) { (_) in
//            transitionContext.completeTransition(true)
//        }
    }
    
    
}
