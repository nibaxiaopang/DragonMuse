//
//  MoreVC.swift
//  Dragon Muse: Artistic Abode
//
//  Created by SHREE KRISHNA on 25/10/24.
//

import UIKit
import StoreKit

class MoreVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func Back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Privacy(_ sender: Any) {
        guard let url = URL(string: "https://www.privacypolicies.com/live/72438b31-1117-48b9-8174-8584ea9e6a2b") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func Rate(_ sender: Any) {
        
        SKStoreReviewController.requestReview()
        
    }
    
    @IBAction func Share(_ sender: Any) {
        let objectsToShare = ["Dragon Muse: Artistic Abode"]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        activityVC.popoverPresentationController?.sourceRect = CGRect(x: 100, y: 200, width: 300, height: 300)
        self.present(activityVC, animated: true, completion: nil)
    }
    
}
