//
//  PayNowQRString.swift
//  Small Business QR Code
//
//  Created by Ansh on 25/7/20.
//  Copyright © 2020 Small Business QR Code. All rights reserved.
//


//This Struct Creates The Complete PayNow QR Code String


import Foundation


struct PayNowQRString {
    
    let UEN : String
    let expiryDate : String
    let transactionAmount : String
    let companyName : String
    let referenceNumber : String
    
    //The Default Value Of The Expiry Date Is December 31st, 2099 If The Expiry Date Is Not Selected
    init(inputUEN : String, inputExpiryDate : String, inputTransactionAmount : String, inputCompanyName : String, inputReferenceNumber : String) {
                
        UEN = inputUEN
        expiryDate = inputExpiryDate
        transactionAmount = inputTransactionAmount
        companyName = inputCompanyName
        referenceNumber = inputReferenceNumber
        
    }
        
    //Payload Format Indicator String
    let payloadFormatIndicatorStringID = "00"
    let payloadFormatIndicatorStringValue = "01"
    var payloadFormatIndicatorStringCharLength : String {
        return "0\(payloadFormatIndicatorStringValue.count)"
    }
    var payloadFormatIndicatorString : String {
        return "\(payloadFormatIndicatorStringID)\(payloadFormatIndicatorStringCharLength)\(payloadFormatIndicatorStringValue)"
    }
        
        
    //Point Of Initiation Method
    let pointOfInitiationMethodStringID = "01"
    //For The Value, 11 = Static, 12 = Dynamic
    let pointOfInitiationMethodStringValue = "12"
    var pointOfInitiationMethodStringCharLength : String {
        return "0\(pointOfInitiationMethodStringValue.count)"
    }
    var pointOfInitiationMethodString : String {
        return "\(pointOfInitiationMethodStringID)\(pointOfInitiationMethodStringCharLength)\(pointOfInitiationMethodStringValue)"
    }
        
        
    //Merchant Account Info Template Sub-Category : Electronic Fund Transfer Service
    let electronicFundTransferServiceStringID = "00"
    let electronicFundTransferServiceStringValue = "SG.PAYNOW"
    var electronicFundTransferServiceStringCharLength : String {
        return "0\(electronicFundTransferServiceStringValue.count)"
    }
    var electronicFundTransferServiceString : String {
        return "\(electronicFundTransferServiceStringID)\(electronicFundTransferServiceStringCharLength)\(electronicFundTransferServiceStringValue)"
    }
        
    //Merchant Account Info Template Sub-Category : UEN Category Selected
    let categorySelectedStringID = "01"
    //For The Value 0 = Mobile, 1 = Unused, 2 = UEN
    let categorySelectedStringValue = "2"
    var  categorySelectedStringCharLength : String {
        return "0\(categorySelectedStringValue.count)"
    }
    var categorySelectedString : String {
        return "\(categorySelectedStringID)\(categorySelectedStringCharLength)\(categorySelectedStringValue)"
    }
        
    //Merchant Account Info Template Sub-Category : UEN Value (Company Unique Entity Number)
    let uenValueStringID = "02"
    var uenValueStringValue : String {
        return "\(UEN)"
    }
    var uenValueStringCharLength : String {
        
        if uenValueStringValue.count >= 10 {
            return "\(uenValueStringValue.count)"
        } else if uenValueStringValue.count < 10 {
            return "0\(uenValueStringValue.count)"
        } else {
            return String("Failed To Return UEN")
        }
        
    }
    var uenValueString : String {
        return "\(uenValueStringID)\(uenValueStringCharLength)\(uenValueStringValue)"
    }
        
    //Merchant Account Info Template Sub-Category : Payment Is Or Is Not Editable
    let isPaymentEditableStringID = "03"
    //For The Value 0 = Payment Not Editable, 1 = Payment Is Editable
    let isPaymentEditableStringValue = "0"
    var isPaymentEditableStringCharLength : String {
        return "0\(isPaymentEditableStringValue.count)"
    }
    var isPaymentEditableString : String {
        return "\(isPaymentEditableStringID)\(isPaymentEditableStringCharLength)\(isPaymentEditableStringValue)"
    }
        
    //Merchant Account Info Template Sub-Category : Expiry Date (YYYYMMDD Format) (This Is An Optional Category)
    let expiryDateStringID = "04"
    var expiryDateStringValue : String {
        return "\(expiryDate)"
    }
    var expiryDateStringCharLength : String {
        return "0\(expiryDateStringValue.count)"
    }
    var expiryDateString : String {
        return "\(expiryDateStringID)\(expiryDateStringCharLength)\(expiryDateStringValue)"
    }
        
    //Merchant Account Info Template (ID-26)
    let merchantAccountInfoTemplateStringID = "26"
    var merchantAccountInfoTemplateStringCharLength : String {
        return String(electronicFundTransferServiceString.count + categorySelectedString.count + uenValueString.count + isPaymentEditableString.count + expiryDateString.count)
    }
    var merchantAccountInfoTemplateString : String {
        return "\(merchantAccountInfoTemplateStringID)\(merchantAccountInfoTemplateStringCharLength)\(electronicFundTransferServiceString)\(categorySelectedString)\(uenValueString)\(isPaymentEditableString)\(expiryDateString)"
    }
        
        
    //Merchant Category Code
    let merchantCategoryCodeStringID = "52"
    //The Value For The Merchant Category Code = 0000 If It Is Unused
    let merchantCategoryCodeStringValue = "0000"
    var merchantCategoryCodeStringCharLength : String {
        return "0\(merchantCategoryCodeStringValue.count)"
    }
    var merchantCategoryCodeString : String {
        return "\(merchantCategoryCodeStringID)\(merchantCategoryCodeStringCharLength)\(merchantCategoryCodeStringValue)"
    }
        
        
    //Currency Code
    let currencyCodeStringID = "53"
    //The Currency Code Of Singapore Is 702
    let currencyCodeStringValue = "702"
    var currencyCodeStringCharLength : String {
        return "0\(currencyCodeStringValue.count)"
    }
    var currencyCodeString : String {
        return "\(currencyCodeStringID)\(currencyCodeStringCharLength)\(currencyCodeStringValue)"
    }
        
        
    //The Transaction Amount In Dollars
    let transactionAmountStringID = "54"
    var transactionAmountStringValue : String {
        return "\(transactionAmount)"
    }
    var transactionAmountStringCharLength : String {
        
        if transactionAmountStringValue.count >= 10 {
            return  "\(transactionAmountStringValue.count)"
        } else if transactionAmountStringValue.count < 10 {
            return "0\(transactionAmountStringValue.count)"
        } else {
            return String("Failed To Return Transaction Amount")
        }
        
    }
    var transactionAmountString : String {
        return "\(transactionAmountStringID)\(transactionAmountStringCharLength)\(transactionAmountStringValue)"
    }
        
        
    //Country Code (2 Letters)
    let countryCodeStringID = "58"
    let countryCodeStringValue = "SG"
    var countryCodeStringCharLength : String {
        return "0\(countryCodeStringValue.count)"
    }
    var countryCodeString : String {
        return "\(countryCodeStringID)\(countryCodeStringCharLength)\(countryCodeStringValue)"
    }
        
        
    //Company Name
    let companyNameStringID = "59"
    var companyNameStringValue : String {
        return "\(companyName)"
    }
    var companyNameStringCharLength : String {
        
        if companyNameStringValue.count >= 10 {
            return "\(companyNameStringValue.count)"
        } else if companyNameStringValue.count < 10 {
            return "0\(companyNameStringValue.count)"
        } else {
            return String("Failed To Return Company Name")
        }
        
    }
    var companyNameString : String {
        return "\(companyNameStringID)\(companyNameStringCharLength)\(companyNameStringValue)"
    }
        
        
    //Merchant City
    let merchantCityStringID = "60"
    let merchantCityStringValue = "Singapore"
    var merchantCityStringCharLength : String {
        
        if merchantCityStringValue.count >= 10 {
            return "\(merchantCityStringValue.count)"
        } else if merchantCityStringValue.count < 10 {
            return "0\(merchantCityStringValue.count)"
        } else {
            return String("Failed To Return Merchant City")
        }
        
    }
    var merchantCityString : String {
        return "\(merchantCityStringID)\(merchantCityStringCharLength)\(merchantCityStringValue)"
    }
        
        
    //Additional Data Fields Sub-Category : Actual Bill / Reference Number
    let referenceNumberStringID = "01"
    var referenceNumberStringValue : String {
        return "\(referenceNumber)"
    }
    var referenceNumberStringCharLength : String {
        
        if referenceNumberStringValue.count >= 10 {
             return "\(referenceNumberStringValue.count)"
        } else if referenceNumberStringValue.count < 10 {
             return "0\(referenceNumberStringValue.count)"
        } else {
            return String("Failed To Return Reference Number")
        }
        
    }
    var referenceNumberString : String {
        return "\(referenceNumberStringID)\(referenceNumberStringCharLength)\(referenceNumberStringValue)"
    }
        
    //Additional Data Fields (ID 62)
    let additionalDataFieldsStringID = "62"
    var additionalDataFieldsStringCharLength : String {
        return "\(referenceNumberString.count)"
    }
    var additionalDataFieldsString : String {
        return "\(additionalDataFieldsStringID)\(additionalDataFieldsStringCharLength)\(referenceNumberString)"
    }
        
        
    //Checksum
    let checksumStringID = "63"
    let checksumStringCharLength = "04"
    var checksumString : String {
        return "\(checksumStringID)\(checksumStringCharLength)"
    }
        
        
    //PayNow QR Code String Without The CRC-16 Checksum
    var payNowQRCodeStringWithoutChecksumCRC16 : String {
        return "\(payloadFormatIndicatorString)\(pointOfInitiationMethodString)\(merchantAccountInfoTemplateString)\(merchantCategoryCodeString)\(currencyCodeString)\(transactionAmountString)\(countryCodeString)\(companyNameString)\(merchantCityString)\(additionalDataFieldsString)\(checksumString)"
    }
        
        
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
        
    var array : [UInt8] {
        return Array(payNowQRCodeStringWithoutChecksumCRC16.utf8)
    }

    var ocrc : UInt16 {
        return crc16CCITT_False(data: array)
    }
    var lowercase_Checksum_CRC16_String : String {
        return String(ocrc, radix: 16)
    }
    var checksum_CRC16_String : String {
        return lowercase_Checksum_CRC16_String.uppercased()
    }
        
        
    //Final Pay Now QR Code String With Checksum
    var finalPayNowQRString : String {
        return "\(payNowQRCodeStringWithoutChecksumCRC16)\(checksum_CRC16_String)"
    }
        
    func getFinalPayNowQRString() -> String {
        return finalPayNowQRString
    }
        
    
    
}
