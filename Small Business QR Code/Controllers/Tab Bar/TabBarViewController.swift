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
        self.selectedIndex = 1
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
