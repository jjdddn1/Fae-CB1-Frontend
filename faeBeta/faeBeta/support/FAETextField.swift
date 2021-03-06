//
//  FaeTextField.swift
//  faeBeta
//
//  Created by Huiyuan Ren on 16/8/21.
//  Copyright © 2016年 fae. All rights reserved.
//

import Foundation
import UIKit

class FAETextField: UITextField {
    //MARK: - Interface
    var contentInset : CGFloat! = 50
    var rightButton : UIButton!
    var rightPlaceHolderView: UIView!
    var leftPlaceHolderView:UIView!
    
    override var secureTextEntry: Bool
    {
        set {
            super.secureTextEntry = newValue
            if newValue {
                setupPasswordTextField()
            }
        }
        get {
            return super.secureTextEntry
        }
    }
    
    private var _placeholder:String = ""
    override var placeholder: String?
    {
        set{
            _placeholder = newValue!
            let font = UIFont(name: "AvenirNext-Regular", size: 25)
            self.attributedPlaceholder = NSAttributedString(string: newValue!, attributes: [NSForegroundColorAttributeName: UIColor.faeAppInputPlaceholderGrayColor(), NSFontAttributeName:font!])
        }
        get{
            return _placeholder
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    private func setup()
    {
        self.autocorrectionType = .No
        self.textColor = UIColor.faeAppInputTextGrayColor()
        self.font = UIFont(name: "AvenirNext-Regular", size: 25.0)
        self.clearButtonMode = UITextFieldViewMode.Never
        self.contentHorizontalAlignment = .Center
        self.textAlignment = .Center
        self.tintColor = UIColor.faeAppRedColor()
        rightPlaceHolderView = UIView(frame: CGRectMake(0, 0, contentInset, 30))
        leftPlaceHolderView = UIView(frame: CGRectMake(0, 0, contentInset, 30))
        self.rightView = rightPlaceHolderView
        self.rightViewMode = .WhileEditing
        self.leftView = rightPlaceHolderView
        self.leftViewMode = .WhileEditing
        self.clipsToBounds = true

    }
    
    private func setupPasswordTextField()
    {
        self.textColor = UIColor.faeAppRedColor()
        rightButton = UIButton(frame: CGRectMake(contentInset - 20, 5, 20, 20))
        rightButton.setImage(UIImage(named: "check_eye_close_red")!, forState: UIControlState.Normal)
        rightPlaceHolderView.addSubview(rightButton)

        rightButton.addTarget(self, action: #selector(FAETextField.rightButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)

    }
    
    func rightButtonTapped()
    {
        secureTextEntry = !secureTextEntry
        if secureTextEntry {
            rightButton.setImage(UIImage(named: "check_eye_close_red")!, forState: UIControlState.Normal)
            self.textColor = UIColor.faeAppRedColor()
        }else{
            rightButton.setImage(UIImage(named: "check_eye_open_red")!, forState: UIControlState.Normal)
            self.textColor = UIColor.faeAppInputTextGrayColor()
        }
        
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, contentInset, 0)
    }
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }
}
