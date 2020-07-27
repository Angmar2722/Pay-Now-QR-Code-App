//
//  GenerateViewController.swift
//  Small Business QR Code
//
//  Created by Ansh on 21/7/20.
//  Copyright © 2020 Small Business QR Code. All rights reserved.
//

import UIKit

class GenerateViewController: UIViewController {
    
    
    //Dimensions of Device Screen
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    
    //Initializing Screen UI Components
    var makeTransactionAmountTextField : UITextField?
    var makeReferenceNumberTextField : UITextField?
    var makeExpiryDateTextField : UITextField?
    
    var makeExpiryDateDatePicker : UIDatePicker?
    var format_YYYY_DD_MM_Date : String?

    var makeQRCodeButton : UIButton?
    
    
    
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

        
        //Adds the Tap Gesture Where The User Can Tap Elsewhere On The Screen When The Date Picker Is Selected To De-Select The Date Picker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GenerateViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    
    //When The User Taps On The Specified Selector, The Editing Is Dismissed (In This Instance, The Editing Is For The Date Picker)
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer) {
        view.endEditing(true)
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
        print("The Make QR Code Button Corner Radius For This Phone Is \(makeQRCodeButton.layer.cornerRadius) For iPhone 11 It Is 25.0")
        
        makeQRCodeButton.backgroundColor = .systemBlue
        
        makeQRCodeButton.addTarget(self, action:#selector(self.generateQRCodeButtonClicked), for: .touchUpInside)
        return makeQRCodeButton
        
    }
    
    
    
    //The Action Which Occurs When The Generate QR Code Button Is Clicked
    @objc func generateQRCodeButtonClicked(sender:UIButton) {
        
        //Dismisses The Date Picker If the User Clicks On The Generate QR Button While The Date Picker Is Selected
        view.endEditing(true)
        
        
        
        if makeTransactionAmountTextField?.text != Optional("") && makeReferenceNumberTextField?.text != Optional("") {
            
            
            //Constats To Store The Transaction Amount As Well As The Reference Number
            let transactionAmount = (makeTransactionAmountTextField?.text)!
            let referenceNumber = (makeReferenceNumberTextField?.text)!
            
            
            //Calculating The Formatted Date (YYYYMMDD) For Use In The Pay Now QR String If The Expiry Date Text Field Is Or Is Not Empty
            if let unformattedDateString = makeExpiryDateTextField?.text {
                
                let unformattedDateFormatter = DateFormatter()
                unformattedDateFormatter.dateFormat = "dd/MM/yyyy"
                let unformattedDateButOfDateType = unformattedDateFormatter.date(from: unformattedDateString)
                
                let requiredDateFormat = DateFormatter()
                requiredDateFormat.dateFormat = "yyyyMMdd"
                
                //The Constant Below Stores The Default Date Value Where The Value Is 100 Years From the Time 'Now' In Seconds
                let defaultDateValueInSeconds = Date(timeIntervalSinceNow: 3155760000)
                
                //The Variable 'format_YYYY_DD_MM_Date' Has A Default Date Value Of 100 Years From 'Now' In Seconds
                format_YYYY_DD_MM_Date = requiredDateFormat.string(from: unformattedDateButOfDateType ?? defaultDateValueInSeconds)
                
                //The Constant Below Stores The Default Date Value Of 100 Years From 'Now' In The Required YYYYMMDD Format For The Pay Now QR String
                let defaultDateValueStringInRequiredDateFormat = requiredDateFormat.string(from: defaultDateValueInSeconds)
                
                //If The User Does Not Pick An Expiry Date, The Default Expiry Date Is Chosen Which is 100 Years From Now. The Line Below Converts The Date Variable To A String With A Value Of 100 Years From 'Now'
                if format_YYYY_DD_MM_Date == defaultDateValueStringInRequiredDateFormat {
                    format_YYYY_DD_MM_Date = defaultDateValueStringInRequiredDateFormat
                }
                
            }
            
            if makeTransactionAmountTextField?.text == Optional("") {
                print("Hi")
            }
            
            //Fetches The Final Pay Now QR Code String From The 'PayNowQRString' Model
            let payNowQRString = PayNowQRString(inputUEN: "201101550Z", inputExpiryDate: "\(format_YYYY_DD_MM_Date!)", inputTransactionAmount: "\(transactionAmount)", inputCompanyName: "Qryptal", inputReferenceNumber: "\(referenceNumber)")
            let finalPayNowQRString = payNowQRString.getFinalPayNowQRString()
            print(finalPayNowQRString)
            
            //Creates A Placeholder Image View To Send To The Generate QR Code Function
            let imageViewToHouseQRCode = UIImageView()
            imageViewToHouseQRCode.frame = CGRect(x: CGFloat( (40 / 414) * screenWidth), y: CGFloat( (420 / 896) * screenHeight), width: CGFloat( (334 / 414) * screenWidth), height: CGFloat( (334 / 896) * screenHeight))
            imageViewToHouseQRCode.backgroundColor = .systemRed
            
            //Calls The Generate QR Code Function To Generate The Actual QR Code And Stores The QR Code Image In The Specified Constant
            let qrCodeImage = generateQRCode(from: "\(finalPayNowQRString)", with: imageViewToHouseQRCode)
            
            //Creates The Actual Image View To Which The Generated QR Code Is Added To
            let actualImageView = UIImageView(image: qrCodeImage)
            actualImageView.frame = CGRect(x: CGFloat( (40 / 414) * screenWidth), y: CGFloat( (420 / 896) * screenHeight), width: CGFloat( (334 / 414) * screenWidth), height: CGFloat( (334 / 896) * screenHeight))
            // NOTE : The Width And Height Specified Above Should Be Equal So That The QR Code Is A Square
            view.addSubview(actualImageView)
            
               
        } else  {
            
            cannotGenerateQRWithoutInputAlert()
            
        }
        
        
        
    }
    
    
    //Function Which Generates The QR Code
    func generateQRCode(from string: String, with imageView: UIImageView) -> UIImage? {
        
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")

            guard let qrImage = filter.outputImage else {return nil}
            let scaleX = imageView.frame.size.width / qrImage.extent.size.width
            let scaleY = imageView.frame.size.height / qrImage.extent.size.height
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)

            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
        
    }
    
    
    //Function Which Presents An Alert When Called
    func cannotGenerateQRWithoutInputAlert() {
        
        let ac = UIAlertController(title: "Cannot Generate QR Code", message: "Please Make Sure That The Amount ($) And The Reference Number Field Is Filled In", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
        //Removes The Alert Automatically After A Deadline Of 15 Seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            ac.dismiss(animated: true, completion: nil)
            self.viewWillAppear(true)
        }
        
    }
    

}



//The Extension Which Allows The User To Click The Return Key On Their Keyboard To End Editing On The Text Fields

extension GenerateViewController : UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        makeTransactionAmountTextField?.endEditing(true)
        makeReferenceNumberTextField?.endEditing(true)
        makeExpiryDateTextField?.endEditing(true)
        return true
    }
    
}

