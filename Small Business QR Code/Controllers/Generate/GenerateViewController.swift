//
//  GenerateViewController.swift
//  Small Business QR Code
//
//  Created by Ansh on 21/7/20.
//  Copyright © 2020 Small Business QR Code. All rights reserved.
//

import UIKit
import PayNowQRSwift

class GenerateViewController: UIViewController {
    
    //Initializing Other View Controller Objects
    var settingsViewController : SettingsViewController?
    
    
    //Dimensions of Device Screen
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let screenArea = UIScreen.main.bounds.width * UIScreen.main.bounds.height
    
    
    //Initializing Screen UI Components
    var transactionAmountTextFieldLabel : UILabel?
    var referenceNumberTextFieldLabel : UILabel?
    var expiryDateTextFieldLabel : UILabel?
    
    var transactionAmountTextField : UITextField?
    var referenceNumberTextField : UITextField?
    var expiryDateTextField : UITextField?
    
    var makeExpiryDateDatePicker : UIDatePicker?

    var makeQRCodeButton : UIButton?
    var widthAndHeightOfQRCode : CGFloat?
    var format_YYYY_DD_MM_Date : Date?
    var actualImageView : UIImageView?
    
    
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
        
        //Adds The Reference Number, Transaction Amount And Expiry Date Labels
        transactionAmountTextFieldLabel = ui_Elements.getTextFieldLabel(text: "Amount ($)", textAlignment: .natural, fontName: "AppleSDGothicNeo-Bold", fontSize: 22, textColor: .black, numberOfLines: 1, adjustsFontSizeToFitWidth: true, frameX: 30, frameY: 130, frameWidth: 120, frameHeight: 40, backgroundColor: .white, borderWidth: 0.0)
        referenceNumberTextFieldLabel = ui_Elements.getTextFieldLabel(text: "Ref No", textAlignment: .natural, fontName: "AppleSDGothicNeo-Bold", fontSize: 22, textColor: .black, numberOfLines: 1, adjustsFontSizeToFitWidth: true, frameX: 30, frameY: 190, frameWidth: 120, frameHeight: 40, backgroundColor: .white, borderWidth: 0.0)
        expiryDateTextFieldLabel = ui_Elements.getTextFieldLabel(text: "Exp Date", textAlignment: .natural, fontName: "AppleSDGothicNeo-Bold", fontSize: 22, textColor: .black, numberOfLines: 1, adjustsFontSizeToFitWidth: true, frameX: 30, frameY: 250, frameWidth: 120, frameHeight: 40, backgroundColor: .white, borderWidth: 0.0)
        
        view.addSubview(transactionAmountTextFieldLabel!)
        view.addSubview(referenceNumberTextFieldLabel!)
        view.addSubview(expiryDateTextFieldLabel!)
        
        
        //Adds The Reference Number, Transaction Amount And Expiry Date Text Fields To The View
        transactionAmountTextField = ui_Elements.getTextField(placeholderText: "E.g. 100.11", textAlignment: .center, fontName: "AppleSDGothicNeo-Bold", fontSize: 22, textColor: .black, adjustsFontSizeToFitWidth: true, frameX: 150, frameY: 130, frameWidth: 234, frameHeight: 40, cornerRadius: 20, borderWidth: 2, backgroundColor: .white, keyboardType: .decimalPad)
        
        referenceNumberTextField = ui_Elements.getTextField(placeholderText: "E.g. Mr. Lee Bill", textAlignment: .center, fontName: "AppleSDGothicNeo-Bold", fontSize: 22, textColor: .black, adjustsFontSizeToFitWidth: true, frameX: 150, frameY: 190, frameWidth: 234, frameHeight: 40, cornerRadius: 20, borderWidth: 2, backgroundColor: .white, keyboardType: .default)
        
        expiryDateTextField = ui_Elements.getTextField(placeholderText: "Pick Date (Optional)", textAlignment: .center, fontName: "AppleSDGothicNeo-Bold", fontSize: 22, textColor: .black, adjustsFontSizeToFitWidth: true, frameX: 150, frameY: 250, frameWidth: 234, frameHeight: 40, cornerRadius: 20, borderWidth: 2, backgroundColor: .white, keyboardType: .default)
        
        transactionAmountTextField!.delegate = self
        referenceNumberTextField!.delegate = self
        expiryDateTextField!.delegate = self
        
        view.addSubview(transactionAmountTextField!)
        view.addSubview(referenceNumberTextField!)
        view.addSubview(expiryDateTextField!)
        
        
        //Adds The Make QR Code Button To The View
        makeQRCodeButton = generateQRCodeButton()
        view.addSubview(makeQRCodeButton!)

        
        //Adds the Date Picker To The Expiry Date Text Field To Select The Expiry Date
        let expiryDateDatePicker = UIDatePicker()
        
        expiryDateDatePicker.datePickerMode = .date
        expiryDateDatePicker.addTarget(self, action: #selector(GenerateViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        expiryDateTextField?.inputView = expiryDateDatePicker

        
        //Adds the Tap Gesture Where The User Can Tap Elsewhere On The Screen To Dismiss The Editor (Such As A Keyboard Or A Date Picker)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GenerateViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    
    
    
    //Creates A Button Which When Clicked On Generates The QR Code
    func generateQRCodeButton() -> UIButton {
        
        let makeQRCodeButton = UIButton()
        
        //Button Title Text Features
        makeQRCodeButton.setTitle("Generate QR ", for: .normal)
        makeQRCodeButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (32 / 896) * screenHeight ))
        makeQRCodeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //Button Frame Attributes
        makeQRCodeButton.frame = CGRect( x: CGFloat( (40 / 414) * screenWidth), y: CGFloat( (330 / 896) * screenHeight), width: CGFloat( (334 / 414) * screenWidth), height: CGFloat( (60 / 896) * screenHeight) )
        makeQRCodeButton.layer.cornerRadius = CGFloat( (25 / 896) * screenHeight)
        
        //Button Background Attributes
        makeQRCodeButton.backgroundColor = .systemBlue
        
        makeQRCodeButton.addTarget(self, action:#selector(self.generateQRCodeButtonClicked), for: .touchUpInside)
        return makeQRCodeButton
        
    }
    
    
    //The Action Which Occurs When The Generate QR Code Button Is Clicked
    @objc func generateQRCodeButtonClicked(sender:UIButton) {
        
        //Dismisses The Date Picker If the User Clicks On The Generate QR Button While The Date Picker Is Selected
        view.endEditing(true)
        
        //Removes Any Existing Image When The Generate Button Is Pressed
        actualImageView?.image = nil
        
        //Fetches The Company Name, UEN & Whether Amount Is Editable Bool From The Settings View Controller
        let companyNameString = UserDefaults.standard.string(forKey: "Company_Name_Text")
        let uenString = UserDefaults.standard.string(forKey: "UEN_Text")
        var isEditableBool = UserDefaults.standard.bool(forKey: "isEditable")
        
        if companyNameString != Optional("") && uenString != Optional("") && companyNameString != nil && uenString != nil {
            
            
            if referenceNumberTextField?.text != Optional("") && referenceNumberTextField?.text != nil {
                
                //Constats To Store The Transaction Amount & Reference Number
                var transactionAmount : CGFloat
                if transactionAmountTextField?.text != Optional("") {
                    transactionAmount = CGFloat(Double((transactionAmountTextField?.text)!)!)
                } else {
                    //If Amount Is Left Unfilled, The Amount Is Set As $0.00 And The Amount Is Editable Regardless Of The Settings
                    transactionAmount = CGFloat(0.00)
                    isEditableBool = true
                }
                let referenceNumber = (referenceNumberTextField?.text)!
                

                //For Testing Purposes : Qryptal UEN Is 201101550Z
                //Fetches The Final Unwrapped Company Name & UEN String & Formatted Date
                let finalCompanyNameString = (companyNameString)!
                let finalUENString = (uenString)!
                
                //Fetches The Expiry Date If It Is Entered
                if expiryDateTextField?.text == Optional("") {
                    format_YYYY_DD_MM_Date = nil
                } else {
                    format_YYYY_DD_MM_Date = format_YYYY_DD_MM_Date!
                }
            
                
                //Calculating The Width And Height Of The QR Code As Well As The X Co-Ordinate Of The Image View
                widthAndHeightOfQRCode = (85/100) * (makeQRCodeButton?.frame.width)!
                let qrCodeXCordPadding = ( (makeQRCodeButton?.frame.width)! - widthAndHeightOfQRCode! ) / 2
                let imageViewXPos = (makeQRCodeButton?.frame.minX)! + qrCodeXCordPadding
                
                
                //Creates A Placeholder Image View To Send To The Generate QR Code Function
                let imageViewToHouseQRCode = UIImageView()
                imageViewToHouseQRCode.frame = CGRect(x: CGFloat( (imageViewXPos / 414) * screenWidth), y: CGFloat( (420 / 896) * screenHeight), width: widthAndHeightOfQRCode!, height: widthAndHeightOfQRCode! + CGFloat( (40 / 896) * screenHeight ))
                
                //Calculates The Bottom Text To Add To The Label Below The QR Code
                var bottomText : String
                
                let last4CharactersOfUEN = finalUENString.suffix(4)
                    //If Amount Is $0.00, The Extra Info Should Not Show The Amount
                if transactionAmount != CGFloat(0.00) {
                    bottomText = "\(finalCompanyNameString) (*\(last4CharactersOfUEN)) $\(transactionAmount)"
                } else {
                    bottomText = "\(finalCompanyNameString) (*\(last4CharactersOfUEN))"
                }
                
                
                let finalImage = payNowQRImage(_beneficiaryType: .UEN, _beneficiary: finalUENString, _beneficiaryName: finalCompanyNameString, amount: transactionAmount, reference: referenceNumber, amountIsEditable: isEditableBool, _expiryDate: format_YYYY_DD_MM_Date, qrWidthAndHeight: widthAndHeightOfQRCode!, bottomLabelText: bottomText)
                
                
                //Creates The Actual Image View To Which The Merged Image Is Added To
                actualImageView = UIImageView(image: finalImage)
                actualImageView!.frame = imageViewToHouseQRCode.frame
                view.addSubview(actualImageView!)
                
                   
            } else  {
                
                callAlert(title: "Cannot Generate QR Code", message: "Please Make Sure That The Reference Number Field Is Filled In", timeDeadline: 20)
                
            }
            
            
        } else {
            
            callAlert(title: "Cannot Generate QR Code", message: "Please Make Sure Than You Have Filled In Both Your Company Name And Its UEN In The Settings Page", timeDeadline: 20)
            
        }
        
        
    }
    
    
    //When The User Taps On The Screen, The Editor (Such As A Keyboard Or A Date Picker) Is Dismissed
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer) {
    
        view.endEditing(true)
        
    }
    
    
    @objc func dateChanged(datePicker : UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        expiryDateTextField?.text = dateFormatter.string(from: datePicker.date)
        format_YYYY_DD_MM_Date = datePicker.date
        
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
    
    
    @IBAction func resetPressed(_ sender: UIBarButtonItem) {
        transactionAmountTextField?.text = ""
        referenceNumberTextField?.text = ""
        expiryDateTextField?.text = ""
        self.actualImageView?.removeFromSuperview()
    }
    
    
    @IBAction func refreshIconPressed(_ sender: UIBarButtonItem) {
        transactionAmountTextField?.text = ""
        referenceNumberTextField?.text = ""
        expiryDateTextField?.text = ""
        self.actualImageView?.removeFromSuperview()
    }
    
    
    @IBAction func copyPressed(_ sender: UIBarButtonItem) {
        
        if actualImageView?.image != nil {
            UIPasteboard.general.image = actualImageView?.image
            callAlert(title: "QR Code Successfully Copied!", message: "", timeDeadline: 10)
        } else {
            callAlert(title: "Nothing To Copy!", message: "No QR Code Has Been Generated To Be Copied", timeDeadline: 20)
        }
        
    }
    
    
    @IBAction func shareIconPressed(_ sender: UIBarButtonItem) {
        
        if actualImageView?.image != nil {
            let arrayOfImagesToShare = [actualImageView?.image]
            let ac = UIActivityViewController(activityItems: arrayOfImagesToShare as [Any], applicationActivities: nil)
            present(ac, animated: true)
        } else {
            callAlert(title: "Nothing To Share!", message: "No QR Code Has Been Generated To Share", timeDeadline: 20)
        }
        
    }
    
    
}




extension GenerateViewController : UITextFieldDelegate {
    
    
    //Function Which Removes The Cursor & Keyboard When The User Presses Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        transactionAmountTextField?.endEditing(true)
        referenceNumberTextField?.endEditing(true)
        expiryDateTextField?.endEditing(true)
        return true
    }
    
    
    //Function Which Stops The User From :
    // 1. Adding More Characters If They Exceed The Character Limit In The Text Field. An Alert Is Also Called To Prompt The User
    // 2. Entering More Than 2 Digits After The Decimal Point
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let text: NSString = textField.text! as NSString
        let resultString = text.replacingCharacters(in: range, with: string)


        //Check the specific textField
        if textField == transactionAmountTextField {
            
            let textArray = resultString.components(separatedBy: ".")
            
            //Allow Only One "." (Decimal Point)
            if textArray.count > 2 {
                
                return false
                
            }
            
           if textArray.count == 2 {
            
                let lastString = textArray.last
                
                //Prevents The User From Exceeding 2 Digits After The Decimal Point
                if lastString!.count > 2 {
                   
                    return false
                    
                }
            
            }
            
        }

        switch textField {

        case transactionAmountTextField:

            if let transactionAmountText = transactionAmountTextField?.text {

                let currentTransactionAmountText = transactionAmountText + string

                if currentTransactionAmountText.count > 13 {
                    
                    callAlert(title: "You Have Reached The Character Limit", message: "Please Stop Adding More Characters. The maximum number of characters allowed is 13 including the decimal point.", timeDeadline: 20)
                    return false

                }

            }

        case referenceNumberTextField:

            if let referenceNumberText = referenceNumberTextField?.text {

                let currentReferenceNumberText = referenceNumberText + string

                if currentReferenceNumberText.count > 60 {
                    
                    callAlert(title: "You Have Reached The Character Limit", message: "Please Stop Adding More Characters. The maximum number allowed is 60", timeDeadline: 20)
                    return false
                    
                }

            }

        default:
            print("Anshul, Add A Better Default For This Switch Statement!")
        }

        return true

    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        //The If Statement Below Checks If The Text Entered In The Transaction Amount Text Field Is A Number And If It Is, It Automatically Adds 2 Decimal Places To The Number, Even If It Is An Integer Or Has 1 Decimal Place. If It Is Not A Number, The Keyboard Is Not Dismissed And The User Is Prompted To Enter A Number
        if transactionAmountTextField?.isEditing == true &&  transactionAmountTextField?.text != Optional("") {
            
            if let amount = Double((transactionAmountTextField?.text)!) {
                
                //Since The Maximum Number Of Characters Allowed Under The Pay Now QR Code Format Is 13, The Lines Below Prevents the User From Inputting An Integer With 11-13 Characters And Then A .00 Is Added Which Gives 16 Characters Which is More Than The Maximum
                //The line below contains the number 1000000000000 which has 11 digits
                if amount < 10000000000 {
                    transactionAmountTextField?.text = String(format: "%.2f", arguments: [amount])
                    return true
                } else {
                    callAlert(title: "You Have Reached The Character Limit", message: "Please Stop Adding More Characters. The maximum number of characters allowed before the decimal point is 10.", timeDeadline: 30)
                    return false
                }
                
                
            } else {
            
                callAlert(title: "Amount Entered Is Not A Number", message: "The Transaction Amount Has To Be A Number Like 99.99 or 99", timeDeadline: 15)
                return false
                
            }

        } else {
            //The Line Below Dismisses Editing For All Other Instances Excluding The Transaction Amount Text Field (So For The Expiry Date Or Reference Number Text Field etc.)
            return true
        }
                
    }
    
    
    //Removes The QR Code Image When The User Begins Editing On A Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.actualImageView?.removeFromSuperview()
    }
    
    
    
}
