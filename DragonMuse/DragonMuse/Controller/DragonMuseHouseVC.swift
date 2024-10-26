//
//  HouseVC.swift
//  Dragon Muse: Artistic Abode
//
//  Created by Dragon Muse: Artistic Abode on 25/10/24.
//

import UIKit

class DragonMuseHouseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func Back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Drawing(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HouseVC") as! DragonMuseHouseVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Favorite(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadVC") as! DragonMuseUploadVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Abstract(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AbstractVC") as! DragonMuseAbstractVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Perfomance(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PerfomanceVC") as! DragonMusePerfomanceVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func PopArt(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopVC") as! DragonMusePopVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func MixedMedia(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MixedVC") as! DragonMuseMixedVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
