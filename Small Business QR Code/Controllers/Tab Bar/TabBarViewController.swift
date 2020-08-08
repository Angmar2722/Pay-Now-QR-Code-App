//
//  TabBarViewController.swift
//  Small Business QR Code
//
//  Created by Ansh on 21/7/20.
//  Copyright © 2020 Small Business QR Code. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //The Line Below Shows The Default Screen When The App Is Launched (Settings Screen Has An index value of 0, Generate Screen Has An Index Value Of 1 And History Screen has an Index Value Of 2)
        //If The Settings Page Is Empty, The Launch Screen Is The Settings Page. If It Is Filled, The Launch Screen Is The Generate Page
        if UserDefaults.standard.string(forKey: "Company_Name_Text") != nil && UserDefaults.standard.string(forKey: "UEN_Text") != nil && UserDefaults.standard.string(forKey: "Company_Name_Text") != Optional("") && UserDefaults.standard.string(forKey: "UEN_Text") != Optional("") {
            self.selectedIndex = 1
        } else {
            self.selectedIndex = 0
        }
        
    }
    

}
