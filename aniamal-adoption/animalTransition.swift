//
//  animalTransition.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/12.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit
import LBTAComponents

class AnimalAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var presenting:Bool = true
    var originFrame = CGRect.zero
    var duration = 5.0
    var cellProfileViewFrame:CGRect = .zero
    var detailProfileViewFrame:CGRect = {
        if let window = UIApplication.shared.keyWindow {
        let width = window.frame.width
        let frame = CGRect(x: 0, y: 64, width: width, height: 200)
        return frame
        }
        return CGRect.zero
        }()
    var profileimage:UIImage?
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        let fromView = UIView()
        let animalView = UIImageView(image: profileimage)
        animalView.backgroundColor = UIColor.red
        
        let initialFrame = presenting ? cellProfileViewFrame : detailProfileViewFrame
        let finalFrame = presenting ? cellProfileViewFrame : cellProfileViewFrame
        
        let xScaleFactor = presenting ?
            (cellProfileViewFrame.width) / (detailProfileViewFrame.width) :
            (detailProfileViewFrame.width) / (cellProfileViewFrame.width)
        
        let yScaleFactor = presenting ?
            (cellProfileViewFrame.height) / (detailProfileViewFrame.height) :
            (detailProfileViewFrame.height) / (cellProfileViewFrame.height)
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        if presenting {
            animalView.transform = scaleTransform
            animalView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            animalView.clipsToBounds = true
        }
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: animalView)
        
        UIView.animate(withDuration: duration, delay:0.0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.0,
                       options: [],
                       animations: {
                        
                        animalView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                        animalView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                        
        }, completion:{_ in
            if !self.presenting {
          //      self.dismissCompletion?()
            }
            transitionContext.completeTransition(true)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

}
