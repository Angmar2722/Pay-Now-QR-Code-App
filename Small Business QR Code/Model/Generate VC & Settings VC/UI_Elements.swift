//
//  UI_Elements.swift
//  Small Business QR Code
//
//  Created by Ansh on 7/8/20.
//  Copyright © 2020 Small Business QR Code. All rights reserved.
//

import UIKit

//This Struct Provides Functions For Generating User Interface Elements Which Are : Text Fields, Labels

struct UI_Elements {
    
    let screenIsInDarkMode : Bool?
    let screenIsInLightMode : Bool?
    
    //Dimensions of Device Screen
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let screenArea = UIScreen.main.bounds.width * UIScreen.main.bounds.height
    
    
    init(darkMode : Bool, lightMode : Bool) {
        screenIsInDarkMode = darkMode
        screenIsInLightMode = lightMode
    }
    
    
    //Function Which Returns A Text Field Label
    func getLabel(text : String, textAlignment : NSTextAlignment, fontName : String, fontSize : CGFloat, textColor : UIColor, numberOfLines : Int, adjustsFontSizeToFitWidth : Bool, frameX : CGFloat, frameY : CGFloat, frameWidth : CGFloat, frameHeight : CGFloat, backgroundColor : UIColor, borderWidth : CGFloat) -> UILabel {
        
        let label = UILabel()
        
        //Label Text Features
        label.text = text
        label.textAlignment = textAlignment
        label.font = UIFont(name: fontName, size: CGFloat( (fontSize / 896) * screenHeight ))
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        
        //Text Field Label Frame Attributes
        label.frame = CGRect(x: CGFloat( (frameX / 414) * screenWidth), y: CGFloat( (frameY / 896) * screenHeight), width: CGFloat( (frameWidth / 414) * screenWidth), height: CGFloat( (frameHeight / 896) * screenHeight))
        
        //Text Field Label Background / Border Attributes
        label.backgroundColor = backgroundColor
        label.layer.borderWidth = borderWidth
        
        //Text Field Label Design If The Screen Is In Dark Or Light Mode
        if screenIsInDarkMode == true && screenIsInLightMode == false {
            
            label.textColor = .yellow
            label.backgroundColor = .black
            label.layer.borderWidth = 0.0
            
        } else if screenIsInLightMode == true && screenIsInDarkMode == false {
            
            label.textColor = textColor
            label.backgroundColor = backgroundColor
            
        }
        
        return label
        
    }
    
    
    
    //Function Which Returns A Text Field
    func getTextField(placeholderText : String, textAlignment : NSTextAlignment, fontName : String, fontSize : CGFloat, textColor : UIColor, adjustsFontSizeToFitWidth : Bool, frameX : CGFloat, frameY : CGFloat, frameWidth : CGFloat, frameHeight : CGFloat, cornerRadius : CGFloat, borderWidth : CGFloat, backgroundColor : UIColor, keyboardType : UIKeyboardType) -> UITextField {
        
        let textField = UITextField()
        
        //Text Field Text Features
        textField.placeholder = placeholderText
        textField.textAlignment = textAlignment
        textField.font = UIFont(name: fontName, size: CGFloat( (fontSize / 896) * screenHeight ))
        textField.textColor = textColor
        textField.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        
        //Text Field Frame Attributes
        textField.frame = CGRect(x: CGFloat( (frameX / 414) * screenWidth), y: CGFloat( (frameY / 896) * screenHeight), width: CGFloat( (frameWidth / 414) * screenWidth), height: CGFloat( (frameHeight / 896) * screenHeight))
        textField.layer.cornerRadius = CGFloat( (cornerRadius / 896) * screenHeight)
        
        //Text Field Background / Border Attributes
        textField.layer.borderWidth = borderWidth
        textField.backgroundColor = backgroundColor
        
        //Keyboard Features
        textField.keyboardType = keyboardType
        
        //Text Field Design If The Screen Is In Dark Or Light Mode
        if screenIsInDarkMode == true && screenIsInLightMode == false {
            
            //Changes The Opacity Of The Placeholder Text
            textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.withAlphaComponent(1)])
            //Removes Border Width
            textField.layer.borderWidth = 0.0
            
        } else if screenIsInLightMode == true && screenIsInDarkMode == false {
            
            textField.placeholder = placeholderText
            
        }
        
        return textField
        
    }
    
    
}


