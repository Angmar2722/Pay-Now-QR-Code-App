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
    var companyNameTextFieldLabel : UILabel?
    var uenTextFieldLabel : UILabel?
    var amountIsEditableLabel : UILabel?
    var amountIsEditableInfoLabel : UILabel?
    
    var companyNameTextField : UITextField?
    var uenTextField : UITextField?
    
    
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
        settingsTextLabel = ui_Elements.getTextFieldLabel(text: "Settings", textAlignment: .center, fontName: "AppleSDGothicNeo-Bold", fontSize: 55, textColor: .black, numberOfLines: 0, adjustsFontSizeToFitWidth: true, frameX: 0, frameY: 80, frameWidth: 414, frameHeight: 80, backgroundColor: .white, borderWidth: 0.0)
        
        companyNameTextFieldLabel = ui_Elements.getTextFieldLabel(text: "Company Name", textAlignment: .natural, fontName: "AppleSDGothicNeo-Bold", fontSize: 33, textColor: .black, numberOfLines: 0, adjustsFontSizeToFitWidth: true, frameX: 20, frameY: 225, frameWidth: 140, frameHeight: 80, backgroundColor: .white, borderWidth: 0.0)
        
        uenTextFieldLabel = ui_Elements.getTextFieldLabel(text: "UEN", textAlignment: .natural, fontName: "AppleSDGothicNeo-Bold", fontSize: 33, textColor: .black, numberOfLines: 1, adjustsFontSizeToFitWidth: true, frameX: 20, frameY: 370, frameWidth: 140, frameHeight: 60, backgroundColor: .white, borderWidth: 0.0)
        
        amountIsEditableLabel = ui_Elements.getTextFieldLabel(text: "Amount Is Editable", textAlignment: .natural, fontName: "AppleSDGothicNeo-Bold", fontSize: 33, textColor: .black, numberOfLines: 0, adjustsFontSizeToFitWidth: true, frameX: 20, frameY: 490, frameWidth: 140, frameHeight: 80, backgroundColor: .white, borderWidth: 0.0)
        
        amountIsEditableInfoLabel = ui_Elements.getTextFieldLabel(text: "Please carefully enter your organisation details so that payments reach your account.", textAlignment: .center, fontName: "San Francisco", fontSize: 20, textColor: .black, numberOfLines: 0, adjustsFontSizeToFitWidth: true, frameX: 20, frameY: 640, frameWidth: 374, frameHeight: 60, backgroundColor: .white, borderWidth: 1)
        
        view.addSubview(settingsTextLabel!)
        view.addSubview(companyNameTextFieldLabel!)
        view.addSubview(uenTextFieldLabel!)
        view.addSubview(amountIsEditableLabel!)
        view.addSubview(amountIsEditableInfoLabel!)
        
        //Adds The Reference Number, Transaction Amount And Expiry Date Text Fields To The View
        companyNameTextField = ui_Elements.getTextField(placeholderText: "E.g. Matsol", textAlignment: .center, fontName: "AppleSDGothicNeo-Bold", fontSize: 33, textColor: .black, adjustsFontSizeToFitWidth: true, frameX: 170, frameY: 230, frameWidth: 234, frameHeight: 60, cornerRadius: 25, borderWidth: 2, backgroundColor: .white, keyboardType: .default)
        
        uenTextField = ui_Elements.getTextField(placeholderText: "E.g. 201536938K", textAlignment: .center, fontName: "AppleSDGothicNeo-Bold", fontSize: 33, textColor: .black, adjustsFontSizeToFitWidth: true, frameX: 170, frameY: 370, frameWidth: 234, frameHeight: 60, cornerRadius: 25, borderWidth: 2, backgroundColor: .white, keyboardType: .default)
        
        companyNameTextField!.delegate = self
        uenTextField!.delegate = self
        
        view.addSubview(companyNameTextField!)
        view.addSubview(uenTextField!)
        
        //Adds The Amount Is Editable Switch Button To The View
        let amountIsEditableUISwitch = generateUISwtich()
        view.addSubview(amountIsEditableUISwitch)
        
        //Adds the Tap Gesture Where The User Can Tap Elsewhere On The Screen To Dismiss The Editor (Such As A Keyboard Or A Date Picker)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        
        //Adding Stored Company Name & UEN Properties If Entered When The App Is Loaded
        if let companyNameText = UserDefaults.standard.string(forKey: "Company_Name_Text") {
            companyNameTextField?.text = companyNameText
        }
        
        if let uenText = UserDefaults.standard.string(forKey: "UEN_Text") {
            uenTextField?.text = uenText
        }
        
        
        //Checks The Last Set State Of The UI Switch To Load
        if UserDefaults.standard.bool(forKey: "isEditable") == true {
            amountIsEditableUISwitch.isOn = true
        } else {
            amountIsEditableUISwitch.isOn = false
        }
        
        
    }
    
    
    //Creates A UI Switch Button Which Allows The Amount To Be Or Not Be Editable
    func generateUISwtich() -> UISwitch {
        
        let uiSwitch = UISwitch()
        
        //UI Switch Frame Attributes
        uiSwitch.frame = CGRect(x: CGFloat( (170 / 414) * screenWidth), y: CGFloat( (510 / 896) * screenHeight), width: 0, height: 0)
        //NOTE : As Evident Above, The Width And Height Of A UI Switch Is Not Customisable Without CGAffineTransform As Shown Below
        uiSwitch.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
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
    
    
    //The Action Which Occurs When The User Taps On The Screen
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer) {
        
        //Stores The UEN & Company Name In User Defaults
        UserDefaults.standard.set(companyNameTextField?.text, forKey: "Company_Name_Text")
        UserDefaults.standard.set(uenTextField?.text, forKey: "UEN_Text")
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
        companyNameTextField?.endEditing(true)
        uenTextField?.endEditing(true)
        
        //Stores The UEN & Company Name In User Defaults
        UserDefaults.standard.set(companyNameTextField?.text, forKey: "Company_Name_Text")
        UserDefaults.standard.set(uenTextField?.text, forKey: "UEN_Text")
        
        return true
        
    }
    
    
    //Function Which Stops The User From Adding More Characters If They Exceed The Character Limit In The Text Field. An Alert Is Also Called To Prompt The User
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        

        switch textField {

        case companyNameTextField:

            if let companyNameText = companyNameTextField?.text {

                let currentCompanyNameText = companyNameText + string

                if currentCompanyNameText.count > 15 {

                    callAlert(title: "You Have Reached The Character Limit", message: "Please Stop Adding More Characters. The maximum number allowed is 15", timeDeadline: 20)
                    return false

                }

            }

        case uenTextField:

            if let uenText = uenTextField?.text {

                let currentUENText = uenText + string

                if currentUENText.count > 10 {
                    
                    callAlert(title: "You Have Reached The Character Limit", message: "A Company's UEN Can Only Be 9 Or 10 Digits Long.", timeDeadline: 20)
                    return false
                    
                }

            }

        default:
            print("Anshul, Add A Better Default For This Switch Statement!")
        }

        return true

    }
   
    
    
}

