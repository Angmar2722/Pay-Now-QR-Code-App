//
//  GenerateViewController.swift
//  Small Business QR Code
//
//  Created by Ansh on 21/7/20.
//  Copyright © 2020 Small Business QR Code. All rights reserved.
//

import UIKit

class GenerateViewController: UIViewController {
    
    //Initializing Other View Controller Objects
    var settingsViewController : SettingsViewController?
    
    //Initializing Accompanying Model Files
    let miscFunctions = MiscFunctions()
    
    //Dimensions of Device Screen
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let screenArea = UIScreen.main.bounds.width * UIScreen.main.bounds.height
    
    
    //Initializing Screen UI Components
    var makeTransactionAmountTextField : UITextField?
    var makeReferenceNumberTextField : UITextField?
    var makeExpiryDateTextField : UITextField?
    
    var makeExpiryDateDatePicker : UIDatePicker?

    var makeQRCodeButton : UIButton?
    var widthAndHeightOfQRCode : CGFloat?
    var actualImageView : UIImageView?
    var payNowLogoImageView : UIImageView?
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //Adds The Reference Number, Transaction Amount And Expiry Date Labels
        let makeTransactionAmountTextFieldLabel = generateTransactionAmountTextFieldLabel()
        let makeReferenceNumberTextFieldLabel = generateReferenceNumberTextFieldLabel()
        let makeExpiryDateTextFieldLabel = generateExpiryDateTextFieldLabel()
        
        view.addSubview(makeTransactionAmountTextFieldLabel)
        view.addSubview(makeReferenceNumberTextFieldLabel)
        view.addSubview(makeExpiryDateTextFieldLabel)
        
        
        //Adds The Reference Number, Transaction Amount And Expiry Date Text Fields To The View
        makeTransactionAmountTextField = generateTransactionAmountTextField()
        makeReferenceNumberTextField = generateReferenceNumberTextField()
        makeExpiryDateTextField = generateExpiryDateTextField()
        
        makeTransactionAmountTextField!.delegate = self
        makeReferenceNumberTextField!.delegate = self
        makeExpiryDateTextField!.delegate = self
        
        view.addSubview(makeTransactionAmountTextField!)
        view.addSubview(makeReferenceNumberTextField!)
        view.addSubview(makeExpiryDateTextField!)
        
        //Adds The Make QR Code Button To The View
        makeQRCodeButton = generateQRCodeButton()
        view.addSubview(makeQRCodeButton!)

        
        //Adds the Date Picker To The Expiry Date Text Field To Select The Expiry Date
        let expiryDateDatePicker = UIDatePicker()
        
        expiryDateDatePicker.datePickerMode = .date
        expiryDateDatePicker.addTarget(self, action: #selector(GenerateViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        makeExpiryDateTextField?.inputView = expiryDateDatePicker

        
        //Adds the Tap Gesture Where The User Can Tap Elsewhere On The Screen To Dismiss The Editor (Such As A Keyboard Or A Date Picker)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GenerateViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    
    
    
    //When The User Taps On The Screen, The Editor (Such As A Keyboard Or A Date Picker) Is Dismissed
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer) {
    
        //The If Statement Below Checks If The Text Entered In The Transaction Amount Text Field Is A Number And If It Is, It Automatically Adds 2 Decimal Places To The Number, Even If It Is An Integer Or Has 1 Decimal Place. If It Is Not A Number, The Keyboard Is Not Dismissed And The User Is Prompted To Enter A Number
        if makeTransactionAmountTextField?.isEditing == true &&  makeTransactionAmountTextField?.text != Optional("") {
            
            if let amount = Double((makeTransactionAmountTextField?.text)!) {
                
                //Since The Maximum Number Of Characters Allowed Under The Pay Now QR Code Format Is 13, The Lines Below Prevents the User From Inputting An Integer With 11-13 Characters And Then A .00 Is Added Which Gives 16 Characters Which is More Than The Maximum
                //The line below contains the number 1000000000000 which has 11 digits
                if amount < 10000000000 {
                    makeTransactionAmountTextField?.text = String(format: "%.2f", arguments: [amount])
                    view.endEditing(true)
                } else {
                    callAlert(title: "You Have Reached The Character Limit", message: "Please Stop Adding More Characters. The maximum number of characters allowed is 13 including the decimal point.", timeDeadline: 20)
                    view.endEditing(false)
                }
                
                
            } else {
            
                callAlert(title: "Amount Entered Is Not A Number", message: "The Transaction Amount Has To Be A Number Like 99.99 or 99", timeDeadline: 15)
                view.endEditing(false)
                
            }

        } else {
            //The Line Below Dismisses Editing For All Other Instances Excluding The Transaction Amount Text Field (So For The Expiry Date Or Reference Number Text Field etc.)
            view.endEditing(true)
        }
        
    }
    
    
    @objc func dateChanged(datePicker : UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        makeExpiryDateTextField?.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    
    
    func generateTransactionAmountTextFieldLabel() -> UILabel {
        
        let transactionAmountTextFieldLabel = UILabel()
        
        //Label Text Features
        transactionAmountTextFieldLabel.text = "Amount ($)"
        transactionAmountTextFieldLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (22 / 896) * screenHeight ))
        transactionAmountTextFieldLabel.textColor = UIColor.black
        transactionAmountTextFieldLabel.adjustsFontSizeToFitWidth = true
        
        //Label Text Field Dimensions And Co-Ordinates
        transactionAmountTextFieldLabel.frame = CGRect(x: CGFloat( (30 / 414) * screenWidth), y: CGFloat( (130 / 896) * screenHeight), width: CGFloat( (120 / 414) * screenWidth), height: CGFloat( (40 / 896) * screenHeight))
        
        //Label Text Field Background / Border Attributes
        transactionAmountTextFieldLabel.backgroundColor = UIColor.white
        
        return transactionAmountTextFieldLabel
        
    }
    
    func generateReferenceNumberTextFieldLabel() -> UILabel {
        
        let referenceNumberTextFieldLabel = UILabel()
        
        //Label Text Features
        referenceNumberTextFieldLabel.text = "Ref No"
        referenceNumberTextFieldLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (22 / 896) * screenHeight ))
        referenceNumberTextFieldLabel.textColor = UIColor.black
        referenceNumberTextFieldLabel.adjustsFontSizeToFitWidth = true
        
        //Label Text Field Dimensions And Co-Ordinates
        referenceNumberTextFieldLabel.frame = CGRect(x: CGFloat( (30 / 414) * screenWidth), y: CGFloat( (190 / 896) * screenHeight), width: CGFloat( (120 / 414) * screenWidth), height: CGFloat( (40 / 896) * screenHeight))
        
        //Label Text Field Background / Border Attributes
        referenceNumberTextFieldLabel.backgroundColor = UIColor.white
        
        return referenceNumberTextFieldLabel
        
    }
    
    func generateExpiryDateTextFieldLabel() -> UILabel {
        
        let expiryDateTextFieldLabel = UILabel()
        
        //Label Text Features
        expiryDateTextFieldLabel.text = "Exp Date"
        expiryDateTextFieldLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (22 / 896) * screenHeight ))
        expiryDateTextFieldLabel.textColor = UIColor.black
        expiryDateTextFieldLabel.adjustsFontSizeToFitWidth = true
        
        //Label Text Field Dimensions And Co-Ordinates
        expiryDateTextFieldLabel.frame = CGRect(x: CGFloat( (30 / 414) * screenWidth), y: CGFloat( (250 / 896) * screenHeight), width: CGFloat( (120 / 414) * screenWidth), height: CGFloat( (40 / 896) * screenHeight))
        
        //Label Text Field Background / Border Attributes
        expiryDateTextFieldLabel.backgroundColor = UIColor.white
        
        return expiryDateTextFieldLabel
        
    }
    
    
    func generateTransactionAmountTextField() -> UITextField {

        let transactionAmountTextField = UITextField()
        
        //Text Field Text Features
        transactionAmountTextField.placeholder = "E.g. 100.11"
        transactionAmountTextField.textAlignment = .center
        transactionAmountTextField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (22 / 896) * screenHeight ))
        transactionAmountTextField.textColor = UIColor.black
        transactionAmountTextField.adjustsFontSizeToFitWidth = true
        
        //Text Field Dimensions And Co-Ordinates
        transactionAmountTextField.frame = CGRect(x: CGFloat( (150 / 414) * screenWidth), y: CGFloat( (130 / 896) * screenHeight), width: CGFloat( (234 / 414) * screenWidth), height: CGFloat( (40 / 896) * screenHeight))
        
        //Text Field Background / Border Attributes
        transactionAmountTextField.layer.borderWidth = 2
        transactionAmountTextField.backgroundColor = UIColor.white
        
        //Keyboard Which When Toggled Only Shows Numbers And A Decimal Point
        transactionAmountTextField.keyboardType = .decimalPad
        
        return transactionAmountTextField
        
    }
    
    func generateReferenceNumberTextField() -> UITextField {

        let referenceNumberTextField = UITextField()
        
        //Text Field Text Features
        referenceNumberTextField.placeholder = "E.g. Mr. Lee Bill"
        referenceNumberTextField.textAlignment = .center
        referenceNumberTextField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (22 / 896) * screenHeight ))
        referenceNumberTextField.textColor = UIColor.black
        referenceNumberTextField.adjustsFontSizeToFitWidth = true
        
        //Text Field Dimensions And Co-Ordinates
        referenceNumberTextField.frame = CGRect(x: CGFloat( (150 / 414) * screenWidth), y: CGFloat( (190 / 896) * screenHeight), width: CGFloat( (234 / 414) * screenWidth), height: CGFloat( (40 / 896) * screenHeight))
        
        //Text Field Background / Border Attributes
        referenceNumberTextField.layer.borderWidth = 2
        referenceNumberTextField.backgroundColor = UIColor.white
        
        
        return referenceNumberTextField
        
    }
    
    func generateExpiryDateTextField() -> UITextField {

        let expiryDateTextField = UITextField()
        
        //Text Field Text Features
        expiryDateTextField.placeholder = "Pick Date (Optional)"
        expiryDateTextField.textAlignment = .center
        expiryDateTextField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (22 / 896) * screenHeight ))
        expiryDateTextField.textColor = UIColor.black
        expiryDateTextField.adjustsFontSizeToFitWidth = true
        
        //Text Field Dimensions And Co-Ordinates
        expiryDateTextField.frame = CGRect(x: CGFloat( (150 / 414) * screenWidth), y: CGFloat( (250 / 896) * screenHeight), width: CGFloat( (234 / 414) * screenWidth), height: CGFloat( (40 / 896) * screenHeight))
        
        //Text Field Background / Border Attributes
        expiryDateTextField.layer.borderWidth = 2
        expiryDateTextField.backgroundColor = UIColor.white
        
        
        return expiryDateTextField
        
    }
    
    
    //Creates A Button Which When Clicked On Generates The QR Code
    func generateQRCodeButton() -> UIButton {
        
        let makeQRCodeButton = UIButton()
        
        //Button Title Text Features
        makeQRCodeButton.setTitle("Generate QR ", for: .normal)
        makeQRCodeButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (32 / 896) * screenHeight ))
        makeQRCodeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //Button Dimensions And Co-Ordinates
        makeQRCodeButton.frame = CGRect( x: CGFloat( (40 / 414) * screenWidth), y: CGFloat( (330 / 896) * screenHeight), width: CGFloat( (334 / 414) * screenWidth), height: CGFloat( (60 / 896) * screenHeight) )
        
        //Button Frame Attributes
        makeQRCodeButton.layer.cornerRadius = CGFloat( (25 / 896) * screenHeight)

        
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
        
        //Fetches The Company Name & UEN From The Settings View Controller
        let companyNameString = UserDefaults.standard.string(forKey: "Company_Name_Text")
        let uenString = UserDefaults.standard.string(forKey: "UEN_Text")
        
        
        if companyNameString != Optional("") && uenString != Optional("") {
            
            
            if makeTransactionAmountTextField?.text != Optional("") && makeReferenceNumberTextField?.text != Optional("") {
                
                //Constats To Store The Transaction Amount As Well As The Reference Number
                let transactionAmount = (makeTransactionAmountTextField?.text)!
                let referenceNumber = (makeReferenceNumberTextField?.text)!
                
                
                //For Testing Purposes : Qryptal UEN Is 201101550Z
                //Fetches The Final Unwrapped Company Name & UEN String & Formatted Date
                let finalCompanyNameString = (companyNameString)!
                let finalUENString = (uenString)!
                
                var format_YYYY_DD_MM_Date : String
                if makeExpiryDateTextField?.text != Optional("") {
                    format_YYYY_DD_MM_Date = miscFunctions.getFormattedDate(dateText: makeExpiryDateTextField?.text)
                } else {
                    format_YYYY_DD_MM_Date = "0"
                }
                
                //Fetches The Final Pay Now QR Code String From The 'PayNowQRString' Model
                let payNowQRString = PayNowQRString(inputUEN: "\(finalUENString)", inputExpiryDate: "\(format_YYYY_DD_MM_Date)", inputTransactionAmount: "\(transactionAmount)", inputCompanyName: "\(finalCompanyNameString)", inputReferenceNumber: "\(referenceNumber)")
                let finalPayNowQRString = payNowQRString.getFinalPayNowQRString()
                print(finalPayNowQRString)
                
                //Calculating The Width And Height Of The QR Code As Well As The X Co-Ordinate Of The Image View
                widthAndHeightOfQRCode = (85/100) * (makeQRCodeButton?.frame.width)!
                let qrCodeXCordPadding = ( (makeQRCodeButton?.frame.width)! - widthAndHeightOfQRCode! ) / 2
                let imageViewXPos = (makeQRCodeButton?.frame.minX)! + qrCodeXCordPadding
                
                //Creates A Placeholder Image View To Send To The Generate QR Code Function
                let imageViewToHouseQRCode = UIImageView()
                imageViewToHouseQRCode.frame = CGRect(x: CGFloat( (imageViewXPos / 414) * screenWidth), y: CGFloat( (420 / 896) * screenHeight), width: widthAndHeightOfQRCode!, height: widthAndHeightOfQRCode! + CGFloat( (40 / 896) * screenHeight ))
                
                //Constants Storing 3 Images To Be Merged
                let qrCodeImage = miscFunctions.generateQRCode(from: "\(finalPayNowQRString)", with: imageViewToHouseQRCode)!
                let payNowLogo = #imageLiteral(resourceName: "Pay Now Logo")
                let extraInfoLabelImage = miscFunctions.getExtraInfoLabelImage(companyName: finalCompanyNameString, UEN: finalUENString, transactionAmount: transactionAmount, qrCodeWidthAndHeight: widthAndHeightOfQRCode!)
                
                let finalMergedImage = miscFunctions.getFinalMergedImage(imageViewWidth: imageViewToHouseQRCode.frame.width, imageViewHeight: imageViewToHouseQRCode.frame.height, qrCodeWidthAndHeight: widthAndHeightOfQRCode!, qrCodeImage: qrCodeImage, payNowLogoImage: payNowLogo, extraInfoLabelImage: extraInfoLabelImage)
                            
                //Creates The Actual Image View To Which The Merged Image Is Added To
                actualImageView = UIImageView(image: finalMergedImage)
                actualImageView!.frame = imageViewToHouseQRCode.frame
                view.addSubview(actualImageView!)
                
                   
            } else  {
                
                callAlert(title: "Cannot Generate QR Code", message: "Please Make Sure That The Amount ($) And The Reference Number Field Is Filled In", timeDeadline: 20)
                
            }
            
            
        } else {
            
            callAlert(title: "Cannot Generate QR Code", message: "Please Make Sure Than You Have Filled In Your Company Name And Its UEN In The Settings Page", timeDeadline: 20)
            
        }
        
        
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
        makeTransactionAmountTextField?.text = ""
        makeReferenceNumberTextField?.text = ""
        makeExpiryDateTextField?.text = ""
        self.actualImageView?.removeFromSuperview()
    }
    
    
    @IBAction func refreshIconPressed(_ sender: UIBarButtonItem) {
        makeTransactionAmountTextField?.text = ""
        makeReferenceNumberTextField?.text = ""
        makeExpiryDateTextField?.text = ""
        self.actualImageView?.removeFromSuperview()
    }
    
    
    @IBAction func copyPressed(_ sender: UIBarButtonItem) {
        UIPasteboard.general.image = actualImageView?.image
        callAlert(title: "QR Code Successfully Copied!", message: "", timeDeadline: 10)
    }
    
    
    @IBAction func shareIconPressed(_ sender: UIBarButtonItem) {
        let arrayOfImagesToShare = [actualImageView?.image]
        let ac = UIActivityViewController(activityItems: arrayOfImagesToShare as [Any], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    
}




extension GenerateViewController : UITextFieldDelegate {
    
    
    //Function Which Removes The Cursor & Keyboard When The User Presses Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        makeTransactionAmountTextField?.endEditing(true)
        makeReferenceNumberTextField?.endEditing(true)
        makeExpiryDateTextField?.endEditing(true)
        return true
    }
    
    
    //Function Which Stops The User From :
    // 1. Adding More Characters If They Exceed The Character Limit In The Text Field. An Alert Is Also Called To Prompt The User
    // 2. Entering More Than 2 Digits After The Decimal Point
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let text: NSString = textField.text! as NSString
        let resultString = text.replacingCharacters(in: range, with: string)


        //Check the specific textField
        if textField == makeTransactionAmountTextField {
            
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

        case makeTransactionAmountTextField:

            if let transactionAmountText = makeTransactionAmountTextField?.text {

                let currentTransactionAmountText = transactionAmountText + string

                if currentTransactionAmountText.count > 13 {
                    
                    callAlert(title: "You Have Reached The Character Limit", message: "Please Stop Adding More Characters. The maximum number of characters allowed is 13 including the decimal point.", timeDeadline: 20)
                    return false

                }

            }

        case makeReferenceNumberTextField:

            if let referenceNumberText = makeReferenceNumberTextField?.text {

                let currentReferenceNumberText = referenceNumberText + string

                if currentReferenceNumberText.count > 30 {
                    
                    callAlert(title: "You Have Reached The Character Limit", message: "Please Stop Adding More Characters. The maximum number allowed is 30", timeDeadline: 20)
                    return false
                    
                }

            }

        default:
            print("Anshul, Add A Better Default For This Switch Statement!")
        }

        return true

    }
    
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //The Line Below Makes Sure That 2 Decimal Places Are Added In The Transaction Amount Tax Field Even If The User Taps On Another Text Field To Exit The Transaction Text Field And Select The Other Text Field
        if let amount = Double((makeTransactionAmountTextField?.text)!) {
                if amount < 10000000000 {
                    makeTransactionAmountTextField?.text = String(format: "%.2f", arguments: [amount])
                }
        }
      
    }
    
    
    //Removes The QR Code Image When The User Begins Editing On A Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.actualImageView?.removeFromSuperview()
    }
    
    
    
}
