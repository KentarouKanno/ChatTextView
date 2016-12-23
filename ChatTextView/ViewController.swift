//
//  ViewController.swift
//  ChatTextView
//
//  Created by Kentarou on 2016/12/23.
//  Copyright © 2016年 Kentarou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var customTextView: CustomTextView!
    @IBOutlet weak var inputBaseViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var constraintTextViewHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Notification
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.willChangeKeyboard(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.willHideKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.willChangeKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        customTextView.placeHolder = "PlaceHolder"
        customTextView.delegate = self
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let maxHeight: CGFloat = 70.0
        let size = textView.sizeThatFits(textView.frame.size)
        
        dump(size)
        if size.height < maxHeight {
            constraintTextViewHeight.constant = size.height
            
            UIView.animate(withDuration:0.2, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // WillChange Keyboad
    func willChangeKeyboard(_ notification: Notification) {
        
        if let userInfo = (notification as NSNotification).userInfo {
            if let keyboard = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
                let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
                
                let keyBoardHeight = keyboard.cgRectValue.height
                self.inputBaseViewBottomConstraint.constant = keyBoardHeight
                
                UIView.animate(withDuration:duration, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    // WillHide Keyboard
    func willHideKeyboard(_ notification: Notification) {
        
        if let userInfo = (notification as NSNotification).userInfo {
            if let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
                
                self.inputBaseViewBottomConstraint.constant = 0
                UIView.animate(withDuration:duration, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { finish in
                    
                })
            }
        }
    }
    
    @IBAction func sendAction(_ sender: UIButton) {
        view.endEditing(true)
    }
    


}

