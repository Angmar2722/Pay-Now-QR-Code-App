//
//  MiscFunctions.swift
//  Small Business QR Code
//
//  Created by Ansh on 5/8/20.
//  Copyright © 2020 Small Business QR Code. All rights reserved.
//

import UIKit


struct MiscFunctions {
    
    
    
    //Dimensions of Device Screen
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let screenArea = UIScreen.main.bounds.width * UIScreen.main.bounds.height
    
    
    
    //Function Which Returns The Correct Formatted Date For The Pay Now QR String (YYYYMMDD)
    func getFormattedDate(dateText : String?) -> String {
                
        let unformattedDateString = (dateText)!
        let unformattedDateFormatter = DateFormatter()
        unformattedDateFormatter.dateFormat = "dd/MM/yyyy"
        let unformattedDateButOfDateType = unformattedDateFormatter.date(from: unformattedDateString)
        
        let requiredDateFormat = DateFormatter()
        requiredDateFormat.dateFormat = "yyyyMMdd"
        
        let formattedDate = requiredDateFormat.string(from: unformattedDateButOfDateType!)
            
        return formattedDate
        
    }
    
    
    //Function Which Generates The QR Code
    func generateQRCode(from string: String, with imageView: UIImageView) -> UIImage? {
        
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            
            guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
            
            filter.setValue(data, forKey: "inputMessage")
            
            filter.setValue("H", forKey: "inputCorrectionLevel")
            colorFilter.setValue(filter.outputImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1") // Background white
            colorFilter.setValue(CIColor(red: 124.0/256, green: 26.0/256, blue: 120.0/256, alpha: 1), forKey: "inputColor0") // Foreground (QR Code) Pay Now Purple Color

    
            guard let qrImage = colorFilter.outputImage else {return nil}
            let scaleX = imageView.frame.size.width / qrImage.extent.size.width
            let scaleY = imageView.frame.size.height / qrImage.extent.size.height
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
            
            if let output = colorFilter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
            
        }
        
        return nil
        
    }
    
    
    //This Function Returns An Image Which Displays Information Below The QR Code
    func getExtraInfoLabelImage(companyName : String, UEN : String, transactionAmount : String, qrCodeWidthAndHeight : CGFloat) -> UIImage {
        
        let extraInfoLabel = UILabel()
        
        let last4CharactersOfUEN = UEN.suffix(4)
        
        //If Amount Is $0.00, The Extra Info Should Not Show The Amount
        if transactionAmount != "0.00" {
            extraInfoLabel.text = "\(companyName) (*\(last4CharactersOfUEN)) $\(transactionAmount)"
        } else {
            extraInfoLabel.text = "\(companyName) (\(last4CharactersOfUEN))"
        }
        
        extraInfoLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (22 / 896) * screenHeight ))
        extraInfoLabel.textColor = UIColor.white
        extraInfoLabel.textAlignment = .center
        extraInfoLabel.adjustsFontSizeToFitWidth = true
        
        extraInfoLabel.frame = CGRect(x: 0, y: qrCodeWidthAndHeight + CGFloat( (5 / 896) * screenHeight ), width: qrCodeWidthAndHeight, height: CGFloat( (30 / 896) * screenHeight ))
        
        let payNowLogoPurpleColor = CIColor(red: 124.0/256, green: 26.0/256, blue: 120.0/256, alpha: 1)
        extraInfoLabel.backgroundColor = UIColor(ciColor: payNowLogoPurpleColor)
        
        
        UIGraphicsBeginImageContextWithOptions(extraInfoLabel.bounds.size, false, 0)
        extraInfoLabel.drawHierarchy(in: extraInfoLabel.bounds, afterScreenUpdates: true)
        let labelImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return labelImage!
        
    }
    
    
    //This Function Returns The Final QR Code Image (Containing The QR Code, Logo And Extra Information)
    func getFinalMergedImage(imageViewWidth : CGFloat, imageViewHeight : CGFloat, qrCodeWidthAndHeight : CGFloat, qrCodeImage : UIImage, payNowLogoImage : UIImage, extraInfoLabelImage : UIImage) -> UIImage {
        
        
        //The Base Image Is The Image View And Its Dimensions
        let bottomImageSize = CGSize(width: imageViewWidth, height: imageViewHeight)
        
        UIGraphicsBeginImageContext(bottomImageSize)
        
        //Draws The QR Code In A CG Rect
        qrCodeImage.draw(in: CGRect(x: 0, y: 0, width: qrCodeWidthAndHeight, height: qrCodeWidthAndHeight))
        
        
        //Draws The Pay Now Logo In A CG Rect
        let iPhone11WidthANdHeightOfQRCode = CGFloat(283.9)
        let xCord = (qrCodeWidthAndHeight / 2) - ( CGFloat( (111.5 / iPhone11WidthANdHeightOfQRCode) * qrCodeWidthAndHeight) / 2 )
        let yCord = (qrCodeWidthAndHeight / 2) - ( CGFloat( (80 / iPhone11WidthANdHeightOfQRCode) * qrCodeWidthAndHeight) / 2 )
        
        payNowLogoImage.draw(in: CGRect(x: xCord, y: yCord, width: CGFloat( (111.5 / 414) * screenWidth), height: CGFloat( (80 / 896) * screenHeight) ) )
        
        
        //Adds The Label To The Bottom Of The QR Code Containing The Company Name, UEN, Transaction Amount
        extraInfoLabelImage.draw(in: CGRect(x: 0, y: qrCodeWidthAndHeight + 5, width: qrCodeWidthAndHeight, height: 30))
        
        
        //Stores The Newly Merged Image In A Constant
        let finalMergedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        
        UIGraphicsEndImageContext()
        
        return finalMergedImage
        
    }
    
    
}
