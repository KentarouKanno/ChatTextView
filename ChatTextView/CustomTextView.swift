//
//  CustomTextView.swift
//  ChatTextView
//
//  Created by Kentarou on 2016/12/23.
//  Copyright © 2016年 Kentarou. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {

    var placeHolderLabel:UILabel = UILabel()
    var placeHolderColor:UIColor = .lightGray
    var placeHolder: NSString    = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // 通知を登録
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.textChanged(_:)),
                                               name: NSNotification.Name.UITextViewTextDidChange,
                                               object: nil)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true 
    }
    
    deinit {
        // 通知を解除
        NotificationCenter.default.removeObserver(self)
    }
    
    func setText(text: String) {
        super.text = text
        self.textChanged(nil)
    }
    
    override public func draw(_ rect: CGRect) {
        
        if self.placeHolder.length > 0 {
            self.placeHolderLabel.frame           = CGRect(x: 8, y: 8, width: self.bounds.size.width - 16, height: 0)
            self.placeHolderLabel.lineBreakMode   = NSLineBreakMode.byWordWrapping
            self.placeHolderLabel.numberOfLines   = 0
            self.placeHolderLabel.font            = self.font
            self.placeHolderLabel.backgroundColor = .clear
            self.placeHolderLabel.textColor       = self.placeHolderColor
            self.placeHolderLabel.alpha           = 0
            self.placeHolderLabel.tag             = 999
            
            self.placeHolderLabel.text = self.placeHolder as String
            self.placeHolderLabel.sizeToFit()
            self.addSubview(placeHolderLabel)
        }
        
        self.sendSubview(toBack: placeHolderLabel)
        
        if self.text.utf16.count == 0 && self.placeHolder.length > 0 {
            self.viewWithTag(999)?.alpha = 1
        }
        super.draw(rect)
    }
    
    public func textChanged(_ notification: Notification?) {
        if(self.placeHolder.length == 0){
            return
        }
        self.viewWithTag(999)?.alpha =  self.text.characters.count == 0 ? 1 : 0
    }
}
