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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Adds The Make QR Code Button To The View
        let makeQRCodeButton = generateQRCodeButton()
        view.addSubview(makeQRCodeButton)
    }
    
    
    //Creates A Button Which When Clicked On Generates The QR Code
    func generateQRCodeButton() -> UIButton {
        
        let makeQRCodeButton = UIButton()
        
        //Button Title Text Features
        makeQRCodeButton.setTitle("Click To Make A QR Code", for: .normal)
        makeQRCodeButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (32 / 896) * screenHeight ))
        makeQRCodeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //Button Dimensions And Co-Ordinates
        makeQRCodeButton.frame = CGRect( x: CGFloat( (40 / 414) * screenWidth), y: CGFloat( (180 / 896) * screenHeight), width: CGFloat( (334 / 414) * screenWidth), height: CGFloat( (90 / 896) * screenHeight) )
        
        makeQRCodeButton.backgroundColor = .systemBlue
        
        makeQRCodeButton.addTarget(self, action:#selector(self.generateQRCodeButtonClicked), for: .touchUpInside)
        return makeQRCodeButton
        
    }
    
    
    //The Action Which Occurs When The Generate QR Code Button Is Clicked
    @objc func generateQRCodeButtonClicked(sender:UIButton) {
        
        
        
        
        //Creating The PayNow QR Code String
        
        let UEN = "201101550Z"
        let expiryDate = "20201127"
        let transactionAmount = "99999.99"
        let companyName = "Qryptal"
        let referenceNumber = "AnshulTest"
        
        //Payload Format Indicator String
        let payloadFormatIndicatorStringID = "00"
        let payloadFormatIndicatorStringValue = "01"
        let payloadFormatIndicatorStringCharLength = "0\(payloadFormatIndicatorStringValue.count)"
        let payloadFormatIndicatorString = "\(payloadFormatIndicatorStringID)\(payloadFormatIndicatorStringCharLength)\(payloadFormatIndicatorStringValue)"
        
        
        //Point Of Initiation Method
        let pointOfInitiationMethodStringID = "01"
        //For The Value, 11 = Static, 12 = Dynamic
        let pointOfInitiationMethodStringValue = "12"
        let pointOfInitiationMethodStringCharLength = "0\(pointOfInitiationMethodStringValue.count)"
        let pointOfInitiationMethodString = "\(pointOfInitiationMethodStringID)\(pointOfInitiationMethodStringCharLength)\(pointOfInitiationMethodStringValue)"
        
        
        //Merchant Account Info Template Sub-Category : Electronic Fund Transfer Service
        let electronicFundTransferServiceStringID = "00"
        let electronicFundTransferServiceStringValue = "SG.PAYNOW"
        let electronicFundTransferServiceStringCharLength = "0\(electronicFundTransferServiceStringValue.count)"
        let electronicFundTransferServiceString = "\(electronicFundTransferServiceStringID)\(electronicFundTransferServiceStringCharLength)\(electronicFundTransferServiceStringValue)"
        
        //Merchant Account Info Template Sub-Category : UEN Category Selected
        let categorySelectedStringID = "01"
        //For The Value 0 = Mobile, 1 = Unused, 2 = UEN
        let categorySelectedStringValue = "2"
        let categorySelectedStringCharLength = "0\(categorySelectedStringValue.count)"
        let categorySelectedString = "\(categorySelectedStringID)\(categorySelectedStringCharLength)\(categorySelectedStringValue)"
        
        //Merchant Account Info Template Sub-Category : UEN Value (Company Unique Entity Number)
        let uenValueStringID = "02"
        let uenValueStringValue = "\(UEN)"
        var uenValueStringCharLength = ""
        if uenValueStringValue.count >= 10 {
            uenValueStringCharLength = "\(uenValueStringValue.count)"
        } else if uenValueStringValue.count < 10 {
            uenValueStringCharLength = "0\(uenValueStringValue.count)"
        }
        let uenValueString = "\(uenValueStringID)\(uenValueStringCharLength)\(uenValueStringValue)"
        
        //Merchant Account Info Template Sub-Category : Payment Is Or Is Not Editable
        let isPaymentEditableStringID = "03"
        //For The Value 0 = Payment Not Editable, 1 = Payment Is Editable
        let isPaymentEditableStringValue = "0"
        let isPaymentEditableStringCharLength = "0\(isPaymentEditableStringValue.count)"
        let isPaymentEditableString = "\(isPaymentEditableStringID)\(isPaymentEditableStringCharLength)\(isPaymentEditableStringValue)"
        
        //Merchant Account Info Template Sub-Category : Expiry Date (YYYYDDMM Format)
        let expiryDateStringID = "04"
        let expiryDateStringValue = "\(expiryDate)"
        let expiryDateStringCharLength = "0\(expiryDateStringValue.count)"
        let expiryDateString = "\(expiryDateStringID)\(expiryDateStringCharLength)\(expiryDateStringValue)"
        
        //Merchant Account Info Template (ID-26)
        let merchantAccountInfoTemplateStringID = "26"
        let merchantAccountInfoTemplateStringCharLength = String(electronicFundTransferServiceString.count + categorySelectedString.count + uenValueString.count + isPaymentEditableString.count + expiryDateString.count)
        let merchantAccountInfoTemplateString = "\(merchantAccountInfoTemplateStringID)\(merchantAccountInfoTemplateStringCharLength)\(electronicFundTransferServiceString)\(categorySelectedString)\(uenValueString)\(isPaymentEditableString)\(expiryDateString)"
        
        
        //Merchant Category Code
        let merchantCategoryCodeStringID = "52"
        //The Value For The Merchant Category Code = 0000 If It Is Unused
        let merchantCategoryCodeStringValue = "0000"
        let merchantCategoryCodeStringCharLength = "0\(merchantCategoryCodeStringValue.count)"
        let merchantCategoryCodeString = "\(merchantCategoryCodeStringID)\(merchantCategoryCodeStringCharLength)\(merchantCategoryCodeStringValue)"
        
        
        //Currency Code
        let currencyCodeStringID = "53"
        //The Currency Code Of Singapore Is 702
        let currencyCodeStringValue = "702"
        let currencyCodeStringCharLength = "0\(currencyCodeStringValue.count)"
        let currencyCodeString = "\(currencyCodeStringID)\(currencyCodeStringCharLength)\(currencyCodeStringValue)"
        
        
        //The Transaction Amount In Dollars
        let transactionAmountStringID = "54"
        let transactionAmountStringValue = "\(transactionAmount)"
        var transactionAmountStringCharLength = ""
        if transactionAmountStringValue.count >= 10 {
            transactionAmountStringCharLength = "\(transactionAmountStringValue.count)"
        } else if transactionAmountStringValue.count < 10 {
            transactionAmountStringCharLength = "0\(transactionAmountStringValue.count)"
        }
        let transactionAmountString = "\(transactionAmountStringID)\(transactionAmountStringCharLength)\(transactionAmountStringValue)"
        
        
        //Country Code (2 Letters)
        let countryCodeStringID = "58"
        let countryCodeStringValue = "SG"
        let countryCodeStringCharLength = "0\(countryCodeStringValue.count)"
        let countryCodeString = "\(countryCodeStringID)\(countryCodeStringCharLength)\(countryCodeStringValue)"
        
        
        //Company Name
        let companyNameStringID = "59"
        let companyNameStringValue = "\(companyName)"
        var companyNameStringCharLength = ""
        if companyNameStringValue.count >= 10 {
            companyNameStringCharLength = "\(companyNameStringValue.count)"
        } else if companyNameStringValue.count < 10 {
            companyNameStringCharLength = "0\(companyNameStringValue.count)"
        }
        let companyNameString = "\(companyNameStringID)\(companyNameStringCharLength)\(companyNameStringValue)"
        
        
        //Merchant City
        let merchantCityStringID = "60"
        let merchantCityStringValue = "Singapore"
        var merchantCityStringCharLength = ""
        if merchantCityStringValue.count >= 10 {
            merchantCityStringCharLength = "\(merchantCityStringValue.count)"
        } else if merchantCityStringValue.count < 10 {
            merchantCityStringCharLength = "0\(merchantCityStringValue.count)"
        }
        let merchantCityString = "\(merchantCityStringID)\(merchantCityStringCharLength)\(merchantCityStringValue)"
        
        
        //Additional Data Fields Sub-Category : Actual Bill / Reference Number
        let referenceNumberStringID = "01"
        let referenceNumberStringValue = "\(referenceNumber)"
        var referenceNumberStringCharLength = ""
        if referenceNumberStringValue.count >= 10 {
            referenceNumberStringCharLength = "\(referenceNumberStringValue.count)"
        } else if referenceNumberStringValue.count < 10 {
            referenceNumberStringCharLength = "0\(referenceNumberStringValue.count)"
        }
        let referenceNumberString = "\(referenceNumberStringID)\(referenceNumberStringCharLength)\(referenceNumberStringValue)"
        
        //Additional Data Fields (ID 62)
        let additionalDataFieldsStringID = "62"
        let additionalDataFieldsStringCharLength = "\(referenceNumberString.count)"
        let additionalDataFieldsString = "\(additionalDataFieldsStringID)\(additionalDataFieldsStringCharLength)\(referenceNumberString)"
        
        
        //Checksum
        let checksumStringID = "63"
        let checksumStringCharLength = "04"
        let checksumString = "\(checksumStringID)\(checksumStringCharLength)"
        
        
        //PayNow QR Code String Without The CRC-16 Checksum
        let payNowQRCodeStringWithoutChecksumCRC16 = "\(payloadFormatIndicatorString)\(pointOfInitiationMethodString)\(merchantAccountInfoTemplateString)\(merchantCategoryCodeString)\(currencyCodeString)\(transactionAmountString)\(countryCodeString)\(companyNameString)\(merchantCityString)\(additionalDataFieldsString)\(checksumString)"
        
        
        //Calculating The CRC-16 / CCITT-FALSE Checksum
        func crc16CCITT_False(data: [UInt8],seed: UInt16 = 0x1d0f, final: UInt16 = 0xffff) -> UInt16{
            var crc = final
            data.forEach { (byte) in
                crc ^= UInt16(byte) << 8
                (0..<8).forEach({ _ in
                    if (crc & UInt16(0x8000)) != 0 {
                        crc = (crc << 1) ^ 0x1021
                    }
                    else {
                        crc = crc << 1
                    }
                    //crc = (crc & UInt16(0x8000)) != 0 ? (crc << 1) ^ 0x1021 : crc << 1
                })
            }
            //return UInt16(crc ^ final)
            return UInt16(crc & final)
        }
        
        let array: [UInt8] = Array(payNowQRCodeStringWithoutChecksumCRC16.utf8)

        let ocrc = crc16CCITT_False(data: array)
        let lowercase_Checksum_CRC16_String = String(ocrc, radix: 16)
        let checksum_CRC16_String = lowercase_Checksum_CRC16_String.uppercased()
        
        
        //Final Pay Now QR Code String With Checksum
        let finalPayNowQRString = "\(payNowQRCodeStringWithoutChecksumCRC16)\(checksum_CRC16_String)"
        
        
        
        
        //Creates A Placeholder Image View To Send To The Generate QR Code Function
        let imageViewToHouseQRCode = UIImageView()
        imageViewToHouseQRCode.frame = CGRect(x: 40, y: 300, width: 334, height: 334)
        imageViewToHouseQRCode.backgroundColor = .systemRed
        
        //Calls The Generate QR Code Function And Stores The QR Code Image In The Specified Constant
        let qrCodeImage = generateQRCode(from: "\(finalPayNowQRString)", with: imageViewToHouseQRCode)
        
        //Creates The Actual Image View To Which The Generated QR Code Is Added To
        let actualImageView = UIImageView(image: qrCodeImage)
        actualImageView.frame = CGRect(x: 40, y: 300, width: 334, height: 334)
        view.addSubview(actualImageView)
        
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
    

}

