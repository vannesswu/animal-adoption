//
//  AdoptCuteVideos.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/15.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import UIKit

class AdoptCuteVideosView: AdoptShelterView {
    let VideoAdress:String = "https://m.youtube.com/results?sp=CAI%253D&q=\("貓狗可愛影片".addEncoding())"
    override init() {
        super.init()
    }
    override func webViewStartLoading() {
        let url = NSURL(string:VideoAdress)
        let urlRequest = URLRequest(url: url! as URL)
        webView?.loadRequest(urlRequest)
    }
    
}
