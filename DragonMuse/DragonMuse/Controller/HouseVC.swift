//
//  HouseVC.swift
//  Dragon Muse: Artistic Abode
//
//  Created by SHREE KRISHNA on 25/10/24.
//

import UIKit

class HouseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func Back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Drawing(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HouseVC") as! HouseVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Favorite(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadVC") as! UploadVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Abstract(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AbstractVC") as! AbstractVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Perfomance(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PerfomanceVC") as! PerfomanceVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func PopArt(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopVC") as! PopVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func MixedMedia(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MixedVC") as! MixedVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
