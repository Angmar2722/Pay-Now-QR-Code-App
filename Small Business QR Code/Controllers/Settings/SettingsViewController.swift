//
//  SettingsViewController.swift
//  Small Business QR Code
//
//  Created by Ansh on 21/7/20.
//  Copyright © 2020 Small Business QR Code. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    //Dimensions of Device Screen
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let screenArea = UIScreen.main.bounds.width * UIScreen.main.bounds.height
    
    //Initializing Screen UI Components
    var settingsTextLabel : UILabel?
    var nameTextFieldLabel : UILabel?
    var uenMobileTextFieldLabel : UILabel?
    var amountIsEditableLabel : UILabel?
    var amountIsEditableInfoLabel : UILabel?
    
    var nameTextField : UITextField?
    var uenMobileNumberTextField : UITextField?
    
    var uenMobileUISegmentedControl : UISegmentedControl?
    
    
    //Initializing Screen Mode Variables
    var isInDarkMode : Bool?
    var isInLightMode : Bool?
    //Monitors If The Screen Mode Changed (Light & Dark Mode)
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
            
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            isInDarkMode = true
            isInLightMode = false
            viewDidLoad()
        } else {
            isInLightMode = true
            isInDarkMode = false
            viewDidLoad()
        }

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Initializing Accompanying Model Files && Screen Mode (Dark Or Light)
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            isInDarkMode = true
            isInLightMode = false
        } else if UIScreen.main.traitCollection.userInterfaceStyle == .light {
            isInLightMode = true
            isInDarkMode = false
        }
        let ui_Elements = UI_Elements(darkMode: isInDarkMode!, lightMode: isInLightMode!)
        
        //Adds The Settings, Reference Number, Transaction Amount And Expiry Date Labels
        settingsTextLabel = ui_Elements.getLabel(text: "Settings", textAlignment: .center, fontName: "AppleSDGothicNeo-Bold", fontSize: 55, textColor: .black, numberOfLines: 0, adjustsFontSizeToFitWidth: true, frameX: 0, frameY: 80, frameWidth: 414, frameHeight: 80, backgroundColor: .white, borderWidth: 0.0)
        
        nameTextFieldLabel = ui_Elements.getLabel(text: "Company Name", textAlignment: .natural, fontName: "AppleSDGothicNeo-Bold", fontSize: 33, textColor: .black, numberOfLines: 0, adjustsFontSizeToFitWidth: true, frameX: 20, frameY: 225, frameWidth: 140, frameHeight: 80, backgroundColor: .white, borderWidth: 0.0)
        
        uenMobileTextFieldLabel = ui_Elements.getLabel(text: "UEN", textAlignment: .natural, fontName: "AppleSDGothicNeo-Bold", fontSize: 33, textColor: .black, numberOfLines: 0, adjustsFontSizeToFitWidth: true, frameX: 20, frameY: 365, frameWidth: 140, frameHeight: 80, backgroundColor: .white, borderWidth: 0.0)
        
        amountIsEditableLabel = ui_Elements.getLabel(text: "Amount Is Editable", textAlignment: .natural, fontName: "AppleSDGothicNeo-Bold", fontSize: 25, textColor: .black, numberOfLines: 0, adjustsFontSizeToFitWidth: true, frameX: 90, frameY: 570, frameWidth: 140, frameHeight: 80, backgroundColor: .white, borderWidth: 0.0)
        
        //amountIsEditableInfoLabel = ui_Elements.getLabel(text: "Please carefully enter your organisation details so that payments reach your account.", textAlignment: .center, fontName: "San Francisco", fontSize: 20, textColor: .black, numberOfLines: 0, adjustsFontSizeToFitWidth: true, frameX: 20, frameY: 640, frameWidth: 374, frameHeight: 60, backgroundColor: .white, borderWidth: 1)
        
        view.addSubview(settingsTextLabel!)
        view.addSubview(nameTextFieldLabel!)
        view.addSubview(uenMobileTextFieldLabel!)
        view.addSubview(amountIsEditableLabel!)
        //view.addSubview(amountIsEditableInfoLabel!)
        
        //Adds The Reference Number, Transaction Amount And Expiry Date Text Fields To The View
        nameTextField = ui_Elements.getTextField(placeholderText: "E.g. Matsol", textAlignment: .center, fontName: "AppleSDGothicNeo-Bold", fontSize: 33, textColor: .black, adjustsFontSizeToFitWidth: true, frameX: 170, frameY: 230, frameWidth: 234, frameHeight: 60, cornerRadius: 25, borderWidth: 2, backgroundColor: .white, keyboardType: .default)
        
        uenMobileNumberTextField = ui_Elements.getTextField(placeholderText: "E.g. 201536938K", textAlignment: .center, fontName: "AppleSDGothicNeo-Bold", fontSize: 33, textColor: .black, adjustsFontSizeToFitWidth: true, frameX: 170, frameY: 370, frameWidth: 234, frameHeight: 60, cornerRadius: 25, borderWidth: 2, backgroundColor: .white, keyboardType: .default)
        
        nameTextField!.delegate = self
        uenMobileNumberTextField!.delegate = self
        
        view.addSubview(nameTextField!)
        view.addSubview(uenMobileNumberTextField!)
        
        //Adds The Amount Is Editable Switch Button To The View
        let amountIsEditableUISwitch = generateUISwtich()
        view.addSubview(amountIsEditableUISwitch)
        
        //Adds The UI Segmented Control To The View
        uenMobileUISegmentedControl = generateUISegmentedControl()
        view.addSubview(uenMobileUISegmentedControl!)
        
        //Adds the Tap Gesture Where The User Can Tap Elsewhere On The Screen To Dismiss The Editor (Such As A Keyboard Or A Date Picker)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        
        //Checks The Last Set State Of The UI Switch To Load
        if UserDefaults.standard.bool(forKey: "isEditable") == true {
            amountIsEditableUISwitch.isOn = true
        } else {
            amountIsEditableUISwitch.isOn = false
        }
        
       
        //Checks The Last Set State Of The UI Segmented Control To Load
        if UserDefaults.standard.integer(forKey: "uenMobileSelectedIndexForSegmentedControl") == 0 {
            
            uenMobileTextFieldLabel?.text = "UEN"
            uenMobileNumberTextField?.placeholder = "E.g. 201536938K"
            nameTextFieldLabel?.text = "Company Name"
            nameTextField?.placeholder = "E.g. Matsol"
            uenMobileUISegmentedControl?.selectedSegmentIndex = 0
            
            //Adds The Stored Company Name / UEN If Entered When The App Is Loaded
            if let companyNameText = UserDefaults.standard.string(forKey: "Company_Name_Text") {
                nameTextField?.text = companyNameText
            }
            if let uenText = UserDefaults.standard.string(forKey: "UEN_Text") {
                uenMobileNumberTextField?.text = uenText
            }
            
        } else if UserDefaults.standard.integer(forKey: "uenMobileSelectedIndexForSegmentedControl") == 1 {
            
            uenMobileTextFieldLabel?.text = "Mobile Number"
            uenMobileNumberTextField?.placeholder = "E.g. 43517856"
            uenMobileNumberTextField?.keyboardType = .numberPad
            nameTextFieldLabel?.text = "Name"
            nameTextField?.placeholder = "John Lee"
            uenMobileUISegmentedControl?.selectedSegmentIndex = 1
            
            //Adds The Stored Name / Mobile Number If Entered When The App Is Loaded
            if let peronNameText = UserDefaults.standard.string(forKey: "Mobile_Name_Text") {
                nameTextField?.text = peronNameText
            }
            if let mobileText = UserDefaults.standard.string(forKey: "Mobile_Text") {
                uenMobileNumberTextField?.text = mobileText
            }
            
        } else {
            UserDefaults.standard.set(0, forKey: "uenMobileSelectedIndexForSegmentedControl")
            uenMobileUISegmentedControl?.selectedSegmentIndex = 0
        }
        
    }
    
    
    //Creates A UI Switch Button Which Allows The Amount To Be Or Not Be Editable
    func generateUISwtich() -> UISwitch {
        
        let uiSwitch = UISwitch()
        
        //UI Switch Frame Attributes
        uiSwitch.frame = CGRect(x: CGFloat( (230 / 414) * screenWidth), y: CGFloat( (590 / 896) * screenHeight), width: 0, height: 0)
        //NOTE : As Evident Above, The Width And Height Of A UI Switch Is Not Customisable Without CGAffineTransform As Shown Below
        //uiSwitch.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        uiSwitch.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        return uiSwitch
        
    }
    
    
    //The Action Which Occurs When The UI Switch Is Clicked
    @objc func switchValueDidChange(_ sender: UISwitch) {
        
        if (sender.isOn == true) {
            UserDefaults.standard.set(true, forKey: "isEditable")
        } else {
            UserDefaults.standard.set(false, forKey: "isEditable")
        }
        
    }
    
    
    //Creates A Segmented Control Which Allows The User To Select Either A UEN Or Mobile Number
    func generateUISegmentedControl() -> UISegmentedControl {
        
        let uiSegmentedControl_ = UISegmentedControl()
        
        //UI Segmented Control Frame Attributes
        uiSegmentedControl_.insertSegment(withTitle: "UEN", at: 0, animated: true)
        uiSegmentedControl_.insertSegment(withTitle: "Mobile Number", at: 1, animated: true)
        uiSegmentedControl_.frame = CGRect(x: CGFloat( (57 / 414) * screenWidth), y: CGFloat( (490 / 896) * screenHeight), width: CGFloat( (300 / 414) * screenWidth), height: CGFloat( (40 / 896) * screenHeight))
        
        //UI Segmented Control Color Features
        uiSegmentedControl_.selectedSegmentTintColor = UIColor.systemBlue
        uiSegmentedControl_.backgroundColor = UIColor.systemPink
                
        uiSegmentedControl_.addTarget(self, action: #selector(SettingsViewController.segmentedControlChanged(_:)), for: .valueChanged)
        return uiSegmentedControl_
        
    }
    
    
    //The Action Which Occurs When The UI Segmented Control Is Clicked
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        
        if uenMobileUISegmentedControl!.selectedSegmentIndex == 0 {
            
            uenMobileTextFieldLabel?.text = "UEN"
            uenMobileNumberTextField?.placeholder = "E.g. 201536938K"
            nameTextFieldLabel?.text = "Company Name"
            nameTextField?.placeholder = "E.g. Matsol"
            UserDefaults.standard.set(0, forKey: "uenMobileSelectedIndexForSegmentedControl")
            
            //Adds The Stored Company Name / UEN If Entered
            if let companyName = UserDefaults.standard.string(forKey: "Company_Name_Text") {
                nameTextField?.text = companyName
            } else {
                nameTextField?.text = ""
            }
            if let uenText = UserDefaults.standard.string(forKey: "UEN_Text") {
                uenMobileNumberTextField?.text = uenText
            } else {
                uenMobileNumberTextField?.text = ""
            }
    
            
        } else if uenMobileUISegmentedControl!.selectedSegmentIndex == 1 {
            
            uenMobileTextFieldLabel?.text = "Mobile Number"
            uenMobileNumberTextField?.placeholder = "E.g. 43517856"
            uenMobileNumberTextField?.keyboardType = .numberPad
            nameTextFieldLabel?.text = "Name"
            nameTextField?.placeholder = "John Lee"
            UserDefaults.standard.set(1, forKey: "uenMobileSelectedIndexForSegmentedControl")
            
            //Adds The Stored Name / Mobile Number If Entered
            if let mobileName = UserDefaults.standard.string(forKey: "Mobile_Name_Text") {
                nameTextField?.text = mobileName
            } else {
                nameTextField?.text = ""
            }
            if let mobileText = UserDefaults.standard.string(forKey: "Mobile_Text") {
                uenMobileNumberTextField?.text = mobileText
            } else {
                uenMobileNumberTextField?.text = ""
            }
            
            
        }
        
    }
    
    
    //The Action Which Occurs When The User Taps On The Screen
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer) {
        
        //Stores The (Mobile Number / UEN) & (Company / Person's Name) In User Defaults
        if uenMobileUISegmentedControl!.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(nameTextField?.text, forKey: "Company_Name_Text")
            UserDefaults.standard.set(uenMobileNumberTextField?.text, forKey: "UEN_Text")
        } else if uenMobileUISegmentedControl!.selectedSegmentIndex == 1 {
            UserDefaults.standard.set(nameTextField?.text, forKey: "Mobile_Name_Text")
            UserDefaults.standard.set(uenMobileNumberTextField?.text, forKey: "Mobile_Text")
        }
        
        //The Editor (Such As A Keyboard) Is Dismissed
        view.endEditing(true)
        
    }
    
    
    func callAlert(title : String, message : String, timeDeadline : Double) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
        //Removes The Alert Automatically After A Deadline Of The Specified Seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + timeDeadline) {
            ac.dismiss(animated: true, completion: nil)
            self.viewWillAppear(true)
        }
        
    }


}



extension SettingsViewController : UITextFieldDelegate {
    
    
    //Function Which Is Called When The User Presses Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Removes The Cursor & Keyboard When The User Presses Return
        nameTextField?.endEditing(true)
        uenMobileNumberTextField?.endEditing(true)
    
        //Stores The (Mobile Number / UEN) & (Company / Person's Name) In User Defaults
        if uenMobileUISegmentedControl?.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(nameTextField?.text, forKey: "Company_Name_Text")
            UserDefaults.standard.set(uenMobileNumberTextField?.text, forKey: "UEN_Text")
        } else if uenMobileUISegmentedControl?.selectedSegmentIndex == 1 {
            UserDefaults.standard.set(nameTextField?.text, forKey: "Mobile_Name_Text")
            UserDefaults.standard.set(uenMobileNumberTextField?.text, forKey: "Mobile_Text")
        }
        
        return true
        
    }
    
    
    //Function Which Stops The User From Adding More Characters If They Exceed The Character Limit In The Text Field. An Alert Is Also Called To Prompt The User
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        

        switch textField {

        case nameTextField:

            if let companyPersonNameText = nameTextField?.text {

                let currentCompanyPersonNameText = companyPersonNameText + string

                if currentCompanyPersonNameText.count > 15 {

                    callAlert(title: "You Have Reached The Character Limit", message: "Please Stop Adding More Characters. The maximum number allowed is 15", timeDeadline: 20)
                    return false

                }

            }

        case uenMobileNumberTextField:
            
            if uenMobileUISegmentedControl?.selectedSegmentIndex == 0 {
                
                if let uenText = uenMobileNumberTextField?.text {

                    let currentUENText = uenText + string

                    if currentUENText.count > 10 {
                        
                        callAlert(title: "You Have Reached The Character Limit", message: "A Company's UEN Can Only Be 9 Or 10 Digits Long.", timeDeadline: 20)
                        return false
                        
                    }

                }
                
            } else if uenMobileUISegmentedControl?.selectedSegmentIndex == 1{
                
                if let mobileText = uenMobileNumberTextField?.text {

                    let currentMobileText = mobileText + string

                    if currentMobileText.count > 8 {
                        
                        callAlert(title: "You Have Reached The Character Limit", message: "A Mobile Number Can Only Be 8 Digits Long", timeDeadline: 20)
                        return false
                        
                    }

                }
                
            }

        default:
            print("Anshul, Add A Better Default For This Switch Statement!")
        }

        return true

    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if uenMobileNumberTextField?.isEditing == true &&  uenMobileNumberTextField?.text != Optional("") {
            
            if uenMobileUISegmentedControl?.selectedSegmentIndex == 1 {
                
                if let uenMobileText = Int((uenMobileNumberTextField?.text)!) {
                    
                    let uenMobileString = String(uenMobileText)
                    
                    if uenMobileString.count == 8 {
                        
                        return true
                        
                    } else {
                        
                        UserDefaults.standard.set(Optional(""), forKey: "Mobile_Text")
                        callAlert(title: "The Mobile Number Has To Be 8 Digits Long", message: "", timeDeadline: 30)
                        return false
                        
                    }
                    
                } else {
                    
                    UserDefaults.standard.set(Optional(""), forKey: "Mobile_Text")
                    callAlert(title: "Amount Entered Is Not A Mobile Number.", message: "The Mobile Number Can Only Contain Numerical Digits.", timeDeadline: 20)
                    return false
                    
                }
                
            } else if uenMobileUISegmentedControl?.selectedSegmentIndex == 0 {
                
                if uenMobileNumberTextField?.text?.count != 9 && uenMobileNumberTextField?.text?.count != 10 {
                    
                    UserDefaults.standard.set(Optional(""), forKey: "UEN_Text")
                    callAlert(title: "The UEN Has To Be 9 Or 10 Digits Long", message: "", timeDeadline: 30)
                    return false
                    
                } else {
                    return true
                }
                
            } else {
                
                return true
                
            }
            
        } else {
            return true
        }
        
    }
    
        
}
    

