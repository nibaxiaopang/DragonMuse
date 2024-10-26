//
//  FirstVC.swift
//  Dragon Muse: Artistic Abode
//
//  Created by SHREE KRISHNA on 25/10/24.
//

import UIKit

class FirstVC: UIViewController, UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func Go(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HouseVC") as! HouseVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func More(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoreVC") as! MoreVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
