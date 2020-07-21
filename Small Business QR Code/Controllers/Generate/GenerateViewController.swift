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
                
        //Creates A Placeholder Image View To Send To The Generate QR Code Function
        let imageViewToHouseQRCode = UIImageView()
        imageViewToHouseQRCode.frame = CGRect(x: 40, y: 300, width: 334, height: 334)
        imageViewToHouseQRCode.backgroundColor = .systemRed
        
        //Calls The Generate QR Code Function And Stores The QR Code Image In The Specified Constant
        let qrCodeImage = generateQRCode(from: "Hello Papa", with: imageViewToHouseQRCode)
        
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

