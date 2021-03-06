//
//  RegisterInfoViewController.swift
//  faeBeta
//
//  Created by blesssecret on 8/15/16.
//  Copyright © 2016 fae. All rights reserved.
//

import UIKit

class RegisterInfoViewController: RegisterBaseViewController {
    
    // MARK: Variables
    
    var textField: UITextField!
    var dateOfBirth: String? = ""
    var numKeyPad: FAENumberKeyboard!
    var gender: String?
    var maleButton: UIButton!
    var femaleButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createTopView("Progress5")
        createDateOfBirthView()
        createGenderView()
        createBottomView(UIView(frame: CGRectZero))
        validation()
        //        addTapGesture()
    }
    
    // MARK: - Functions
    
    override func backButtonPressed() {
        view.endEditing(true)
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func continueButtonPressed() {
        view.endEditing(true)
        jumpToRegisterConfirm()
    }
    
    func jumpToRegisterConfirm() {
        let vc:UIViewController = UIStoryboard(name: "Main", bundle: nil) .instantiateViewControllerWithIdentifier("RegisterConfirmViewController") as! RegisterConfirmViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func handleTap(sender: UITapGestureRecognizer) {
        //using sender, we can get the point in respect to the table view
        let tapLocation = sender.locationInView(self.tableView)
        
        
        if numKeyPad != nil && !numKeyPad.pointInside(tapLocation, withEvent: nil) {
            hideNumKeyboard()
            
            UIView .animateWithDuration(0.3) {
                var frame = self.numKeyPad!.frame
                
                frame.origin.y = self.view.frame.size.height
                self.numKeyPad.frame = frame
            }
        }
    }
    
    func createDateOfBirthView() {
        
        let dobView = UIView(frame: CGRectMake(0, 90, view.frame.size.width, 120))
        
        let titleLabel = UILabel(frame: CGRectMake(0, 10, dobView.frame.size.width, 26))
        titleLabel.textColor = UIColor.init(red: 89/255.0, green: 89/255.0, blue: 89/255.0, alpha: 1.0)
        titleLabel.font = UIFont(name: "AvenirNext-Medium", size: 20)
        titleLabel.textAlignment = .Center
        titleLabel.text = "Birthday"
        
        textField = UITextField(frame: CGRectMake(0, 65, dobView.frame.size.width, 40))
        textField.keyboardType = .NumberPad
        
        textField.font = UIFont(name: "AvenirNext-Regular", size: 25)
        textField.textColor = UIColor.init(red: 89/255.0, green: 89/255.0, blue: 89/255.0, alpha: 1.0)
        textField.textAlignment = .Center
        textField.attributedPlaceholder = NSAttributedString(string:"placeholder text", attributes: [NSForegroundColorAttributeName: UIColor.init(colorLiteralRed: 155/255.0, green: 155/255.0, blue: 155/255.0, alpha: 1.0)])
        textField.placeholder = "MM/DD/YYYY"
        
        dobView.addSubview(titleLabel)
        dobView.addSubview(textField)
        
        view.addSubview(dobView)
        
    }
    
    func createGenderView() {
        let genderView = UIView(frame: CGRectMake(0, 240, view.frame.size.width, 130))
        
        let titleLabel = UILabel(frame: CGRectMake(0, 10, genderView.frame.size.width, 26))
        titleLabel.textColor = UIColor.init(red: 89/255.0, green: 89/255.0, blue: 89/255.0, alpha: 1.0)
        titleLabel.font = UIFont(name: "AvenirNext-Medium", size: 20)
        titleLabel.textAlignment = .Center
        titleLabel.text = "Gender"
        
        maleButton = UIButton(frame: CGRectMake(genderView.frame.size.width/3.0 - 30, 60, 60, 60))
        maleButton.setImage(UIImage(named: "male_unselected"), forState: .Normal)
        maleButton.setImage(UIImage(named: "male_selected"), forState: .Selected)
        maleButton.addTarget(self, action: #selector(self.maleButtonTapped), forControlEvents: .TouchUpInside)
        
        
        femaleButton = UIButton(frame: CGRectMake(2 * genderView.frame.size.width/3.0 - 30, 60, 60, 60))
        femaleButton.setImage(UIImage(named: "female_unselected"), forState: .Normal)
        femaleButton.setImage(UIImage(named: "female_selected"), forState: .Selected)
        femaleButton.addTarget(self, action: #selector(self.femaleButtonTapped), forControlEvents: .TouchUpInside)
        
        
        genderView.addSubview(titleLabel)
        genderView.addSubview(maleButton)
        genderView.addSubview(femaleButton)
        
        view.addSubview(genderView)
        
    }
    
    
    func maleButtonTapped() {
        gender = "male"
        maleButton.selected = true
        femaleButton.selected = false
    }
    
    func femaleButtonTapped() {
        gender = "female"
        maleButton.selected = false
        femaleButton.selected = true
    }
    
    func validation() {
        var isValid = false
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let date = dateFormatter.dateFromString(dateOfBirth!)
        
        
        isValid = date != nil && dateOfBirth!.characters.count == 10
        
        if isValid {
            isValid = date!.earlierDate(NSDate()).isEqualToDate(date!)
        }
        
        isValid = isValid && gender != nil
        
        enableContinueButton(isValid)
    }
    
    // MARK: - Memory Management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension RegisterInfoViewController: FAENumberKeyboardDelegate {
    func keyboardButtonTapped(num: Int) {
        if num != -1 {
            if dateOfBirth?.characters.count < 10 {
                dateOfBirth = "\(dateOfBirth!)\(num)"
            }
            
            let numberOfCharacters = dateOfBirth?.characters.count
            
            if  numberOfCharacters == 2 || numberOfCharacters == 5 {
                dateOfBirth = "\(dateOfBirth!)/"
            }
            
        } else {
            if dateOfBirth?.characters.count >= 0 {
                
                dateOfBirth = String(dateOfBirth!.characters.dropLast())
                
                let numberOfCharacters = dateOfBirth?.characters.count
                
                if  numberOfCharacters == 2 || numberOfCharacters == 5 {
                    dateOfBirth = String(dateOfBirth!.characters.dropLast())
                }
            }
        }
        
        validation()
        
        textField.text = dateOfBirth
    }
}


extension RegisterInfoViewController {
    
    override func keyboardWillShow(notification: NSNotification) {
        textField.resignFirstResponder()
        if numKeyPad == nil {
            numKeyPad = FAENumberKeyboard(frame:CGRectMake(57,view.frame.size.height, 300, 244))
            self.view.addSubview(numKeyPad)
            numKeyPad.delegate = self
        }
        
        UIView .animateWithDuration(0.3) {
            var frame = self.numKeyPad!.frame
            
            self.bottomView.frame.origin.y = self.view.frame.height - 244 - self.bottomView.frame.size.height
            frame.origin.y = self.view.frame.size.height - 244
            self.numKeyPad.frame = frame
        }
    }
    
    func hideNumKeyboard() {
        var bottomViewFrame = bottomView.frame
        bottomViewFrame.origin.y = view.frame.height - bottomViewFrame.size.height
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.bottomView.frame = bottomViewFrame
        })
        
    }
    
}
