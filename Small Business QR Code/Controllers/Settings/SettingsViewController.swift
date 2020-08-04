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
    var makeCompanyNameTextField : UITextField?
    var makeUENTextField : UITextField?

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //Adds The Settings, Reference Number, Transaction Amount And Expiry Date Labels
        let makeSettingsTextLabel = generateSettingsTextLabel()
        let makeCompanyNameTextFieldLabel = generateCompanyNameTextFieldLabel()
        let makeUENTextFieldLabel = generateUENTextFieldLabel()
        
        view.addSubview(makeSettingsTextLabel)
        view.addSubview(makeCompanyNameTextFieldLabel)
        view.addSubview(makeUENTextFieldLabel)
        
        
        //Adds The Reference Number, Transaction Amount And Expiry Date Text Fields To The View
        makeCompanyNameTextField = generateCompanyNameTextField()
        makeUENTextField = generateUENTextField()
        
        makeCompanyNameTextField!.delegate = self
        makeUENTextField!.delegate = self
        
        view.addSubview(makeCompanyNameTextField!)
        view.addSubview(makeUENTextField!)
        
        //Adds the Tap Gesture Where The User Can Tap Elsewhere On The Screen To Dismiss The Editor (Such As A Keyboard Or A Date Picker)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        
        //Adding Stored Company Name & UEN Properties If Entered When The App Is Loaded
        if let companyNameText = UserDefaults.standard.string(forKey: "Company_Name_Text") {
            makeCompanyNameTextField?.text = companyNameText
        }
        
        if let uenText = UserDefaults.standard.string(forKey: "UEN_Text") {
            makeUENTextField?.text = uenText
        }
        
        
    }
    
    
    
    
    //When The User Taps On The Screen
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer) {
        
        //Stores The UEN & Company Name In User Defaults
        UserDefaults.standard.set(makeCompanyNameTextField?.text, forKey: "Company_Name_Text")
        UserDefaults.standard.set(makeUENTextField?.text, forKey: "UEN_Text")
        //The Editor (Such As A Keyboard) Is Dismissed
        view.endEditing(true)
        
    }
    
    
    func generateSettingsTextLabel() -> UILabel {
        
        let settingsTextLabel = UILabel()

        //Label Text Features
        settingsTextLabel.text = "Settings"
        settingsTextLabel.textAlignment = .center
        settingsTextLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (55 / 896) * screenHeight ))
        settingsTextLabel.textColor = UIColor.black
        settingsTextLabel.numberOfLines = 0
        settingsTextLabel.adjustsFontSizeToFitWidth = true
        
        //Label Text Field Dimensions And Co-Ordinates
        settingsTextLabel.frame = CGRect(x: CGFloat( (0 / 414) * screenWidth), y: CGFloat( (80 / 896) * screenHeight), width: CGFloat( (414 / 414) * screenWidth), height: CGFloat( (80 / 896) * screenHeight))
        
        //Label Text Field Background / Border Attributes
        settingsTextLabel.layer.borderWidth = 0
        settingsTextLabel.backgroundColor = UIColor.white
        
        return settingsTextLabel
        
    }
    
    
    func generateCompanyNameTextFieldLabel() -> UILabel {
        
        let companyNameTextFieldLabel = UILabel()
        
        //Label Text Features
        companyNameTextFieldLabel.text = "Company Name"
        companyNameTextFieldLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (33 / 896) * screenHeight ))
        companyNameTextFieldLabel.textColor = UIColor.black
        companyNameTextFieldLabel.numberOfLines = 0
        companyNameTextFieldLabel.adjustsFontSizeToFitWidth = true
        
        //Label Text Field Dimensions And Co-Ordinates
        companyNameTextFieldLabel.frame = CGRect(x: CGFloat( (20 / 414) * screenWidth), y: CGFloat( (225 / 896) * screenHeight), width: CGFloat( (140 / 414) * screenWidth), height: CGFloat( (80 / 896) * screenHeight))
        
        //Label Text Field Background / Border Attributes
        companyNameTextFieldLabel.layer.borderWidth = 0
        companyNameTextFieldLabel.backgroundColor = UIColor.white
        
        return companyNameTextFieldLabel
        
    }
    
    
    func generateUENTextFieldLabel() -> UILabel {
        
        let uenTextFieldLabel = UILabel()
        
        //Label Text Features
        uenTextFieldLabel.text = "UEN"
        uenTextFieldLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (33 / 896) * screenHeight ))
        uenTextFieldLabel.textColor = UIColor.black
        uenTextFieldLabel.adjustsFontSizeToFitWidth = true
        
        //Label Text Field Dimensions And Co-Ordinates
        uenTextFieldLabel.frame = CGRect(x: CGFloat( (20 / 414) * screenWidth), y: CGFloat( (370 / 896) * screenHeight), width: CGFloat( (140 / 414) * screenWidth), height: CGFloat( (60 / 896) * screenHeight))
        
        //Label Text Field Background / Border Attributes
        uenTextFieldLabel.layer.borderWidth = 0
        uenTextFieldLabel.backgroundColor = UIColor.white
        
        return uenTextFieldLabel
        
    }
    
    
    func generateCompanyNameTextField() -> UITextField {

        let companyNameTextField = UITextField()
        
        //Text Field Text Features
        companyNameTextField.placeholder = "E.g. Qryptal"
        companyNameTextField.textAlignment = .center
        companyNameTextField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (33 / 896) * screenHeight ))
        companyNameTextField.textColor = UIColor.black
        companyNameTextField.adjustsFontSizeToFitWidth = true
        
        //Text Field Dimensions And Co-Ordinates
        companyNameTextField.frame = CGRect(x: CGFloat( (170 / 414) * screenWidth), y: CGFloat( (230 / 896) * screenHeight), width: CGFloat( (234 / 414) * screenWidth), height: CGFloat( (60 / 896) * screenHeight))
        
        //Text Field Background / Border Attributes
        companyNameTextField.layer.borderWidth = 2
        companyNameTextField.backgroundColor = UIColor.white
        
        return companyNameTextField
        
    }
    
    func generateUENTextField() -> UITextField {

        let uenTextField = UITextField()
        
        //Text Field Text Features
        uenTextField.placeholder = "E.g. 53222036J"
        uenTextField.textAlignment = .center
        uenTextField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (33 / 896) * screenHeight ))
        uenTextField.textColor = UIColor.black
        uenTextField.adjustsFontSizeToFitWidth = true
        
        //Text Field Dimensions And Co-Ordinates
        uenTextField.frame = CGRect(x: CGFloat( (170 / 414) * screenWidth), y: CGFloat( (370 / 896) * screenHeight), width: CGFloat( (234 / 414) * screenWidth), height: CGFloat( (60 / 896) * screenHeight))
        
        //Text Field Background / Border Attributes
        uenTextField.layer.borderWidth = 2
        uenTextField.backgroundColor = UIColor.white
        
        
        return uenTextField
        
    }
    
    
    //Alert Which Is Called When The User Has Exceeded The Reference Number Character Limit
    func cannotExceedCompanyNameCharacterLimit() {
        
        let ac = UIAlertController(title: "You Have Reached The Character Limit", message: "Please Stop Adding More Characters. The maximum number allowed is 15", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
        //Removes The Alert Automatically After A Deadline Of 20 Seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            ac.dismiss(animated: true, completion: nil)
            self.viewWillAppear(true)
        }
        
    }
    
    //Alert Which Is Called When The User Has Exceeded The Transaction Amount Character Limit
    func cannotExceedUENCharacterLimit() {
        
        let ac = UIAlertController(title: "You Have Reached The Character Limit", message: "A Company's UEN Can Only Be 9 Or 10 Digits Long.", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
        //Removes The Alert Automatically After A Deadline Of 20 Seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            ac.dismiss(animated: true, completion: nil)
            self.viewWillAppear(true)
        }
        
    }
   

}


extension SettingsViewController : UITextFieldDelegate {
    
    
    //Function Which Is Called When The User Presses Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Removes The Cursor & Keyboard When The User Presses Return
        makeCompanyNameTextField?.endEditing(true)
        makeUENTextField?.endEditing(true)
        
        //Stores The UEN & Company Name In User Defaults
        UserDefaults.standard.set(makeCompanyNameTextField?.text, forKey: "Company_Name_Text")
        UserDefaults.standard.set(makeUENTextField?.text, forKey: "UEN_Text")
        
        return true
        
    }
    
    
    //Function Which Stops The User From Adding More Characters If They Exceed The Character Limit In The Text Field. An Alert Is Also Called To Prompt The User
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        

        switch textField {

        case makeCompanyNameTextField:

            if let companyNameText = makeCompanyNameTextField?.text {

                let currentCompanyNameText = companyNameText + string

                if currentCompanyNameText.count > 15 {

                    cannotExceedCompanyNameCharacterLimit()
                    return false

                }

            }

        case makeUENTextField:

            if let uenText = makeUENTextField?.text {

                let currentUENText = uenText + string

                if currentUENText.count > 10 {
                    cannotExceedUENCharacterLimit()
                    return false
                }

            }

        default:
            print("Anshul, Add A Better Default For This Switch Statement!")
        }

        return true

    }
   
    
    
}

