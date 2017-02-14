//
//  BaseView.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/15.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import UIKit

class BaseView:NSObject {
    
    var blackView = UIView()
    var popView = UIView()
    override init() {
        super.init()
    }
    func makeViews(){
        self.blackView = UIView()
        self.popView = UIView()
    }
    
    lazy var dismissButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("知道了", for: .normal)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        btn.backgroundColor = UIColor.adoptRed
        return btn
    }()
    
    
    func showup() {
        
        
        
        if let window = UIApplication.shared.keyWindow {
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            blackView.fillSuperview()
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            
            
            blackView.addSubview(popView)
            popView.backgroundColor = UIColor.white
            popView.anchorCenterSuperview()
            popView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 300, heightConstant: 400)
            
        }
        
        
        
        
    }
    func handleDismiss() {
        print("here")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
        }) { (completed: Bool) in
            if completed {
                self.blackView.removeFromSuperview()
            }
        }
        
    }

    
    

}
