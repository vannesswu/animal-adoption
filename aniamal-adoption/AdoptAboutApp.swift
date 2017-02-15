//
//  AdoptAboutApp.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/15.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import UIKit

class AdoptAboutAppView: AdoptNoteView {
    

    override var titleLabel: UILabel {
        get {
            super.titleLabel.text = "關於"
            return super.titleLabel
        }
        set {
            
        }

    }
    
    override func setTextViewText() {
        textView.text = "動物認領養APP資料來源為行政院農業委員會資料開放平台\n\n主要用途為提供給台灣市民認養流浪犬貓使用，實現以領養代替購買，以絕育取代滅殺。\n\n希望大家都能在這裡找到自己喜歡的毛小孩\n\n如果有任何建議或想法歡迎聯絡APP作者\n\n\n信箱:stjerryi@hotmail.com"
        textView.font = UIFont.italicSystemFont(ofSize: 20)
    }
    
}
