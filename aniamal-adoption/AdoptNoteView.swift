//
//  adoptNoteView.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/15.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit

class AdoptNoteView : NoteBaseView {
    
   open var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "認養須知"
        label.textColor = UIColor.adoptRed
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    let textView:UITextView = {
        let view = UITextView()
        view.font = UIFont.italicSystemFont(ofSize: 15)
        view.textAlignment = .left
        view.isEditable = false
        
        return view
    }()
    
    
    override init() {
        super.init()
       
    }
    
    override func showup() {
        super.showup()
        blackView.addSubview(titleLabel)
        blackView.addSubview(textView)
        titleLabel.anchor(popView.topAnchor, left: popView.leftAnchor, bottom: nil, right: popView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        blackView.addSubview(textView)
        textView.anchor(titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: popView.bottomAnchor, right: popView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 40, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        setTextViewText()
        
        
        blackView.addSubview(dismissButton)
        dismissButton.anchor(textView.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: titleLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
    }
   func setTextViewText() {
    textView.text = "一、申請人：年滿20歲之民眾。未滿20歲者，以其法定代理人或法定監護人為飼主。\n\n 二、申請步驟：\n\n（一）申請人應攜身分證明文件，填具申請書。\n\n（二）承辦人員應就認養人核對身分證明文件，必要時得親自實地勘察。\n\n（三）待認養動物條件：於本處留置已逾7日尚無飼主認領或無身分標識者，且經本處健康行為評估適於認養者。\n\n（四）符合認養人資格者，得由管理人員協助，由可認養犬隻中，自行挑選合意犬隻。\n\n（五）繳交相關規費：晶片植入手續費250元、狂犬病預防注射費200元。\n\n（六）未實施晶片植入、狂犬病預防注射及寵物登記之動物，應於完成晶片植入、狂犬病預防注射及寵物登記後始得放行。唯8週齡以下幼犬暫免施打狂犬病疫苗。\n\n（七）認養之犬隻自領出日起1個月內，若因任何原因無法續養，可將該犬交還本所，填寫「不擬續養動物申請切結書」放棄該犬之所有權，並繳回寵物登記證及狂犬病預防注射證明辦理註銷。認養時所繳之費用概不退還。\n\n資料來源：臺北市動物保護處"
    
    }
    
    
}

