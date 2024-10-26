//
//  FirstVC.swift
//  Dragon Muse: Artistic Abode
//
//  Created by Dragon Muse: Artistic Abode on 25/10/24.
//

import UIKit

class DragonMuseFirstVC: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var atView: UIActivityIndicatorView!
    
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var gotoBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        self.atView.hidesWhenStopped = true
        self.atView.stopAnimating()
        self.dmLoadADsData()
    }
    
    @IBAction func Go(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HouseVC") as! DragonMuseHouseVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func More(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoreVC") as! DragonMuseMoreVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func dmLoadADsData() {
        guard self.dmNeedShowAds() else {
            return
        }
        
        self.moreBtn.isHidden = true
        self.gotoBtn.isHidden = true
        self.atView.startAnimating()
        if DragonMuseReachManager.shared().isReachable {
            dmReqAdsLocalData()
        } else {
            DragonMuseReachManager.shared().setReachabilityStatusChange { status in
                if DragonMuseReachManager.shared().isReachable {
                    self.dmReqAdsLocalData()
                    DragonMuseReachManager.shared().stopMonitoring()
                }
            }
            DragonMuseReachManager.shared().startMonitoring()
        }
    }
    
    private func dmReqAdsLocalData() {
        dmLocalAdsData { dataDic in
            if let dataDic = dataDic {
                self.dmConfigAdsData(pulseDataDic: dataDic)
            } else {
                self.atView.stopAnimating()
                self.moreBtn.isHidden = false
                self.gotoBtn.isHidden = false
            }
        }
    }
    
    private func dmConfigAdsData(pulseDataDic: [String: Any]?) {
        if let aDic = pulseDataDic {
            let adsData: [String: Any]? = aDic["jsonObject"] as? Dictionary
            if let adsData = adsData {
                if let adsUr = adsData["data"] as? String, !adsUr.isEmpty {
                    UserDefaults.standard.set(adsData, forKey: "DragonMuseDatas")
                    dmShowAdViewC(adsUr)
                    return
                }
            }
        }
        self.moreBtn.isHidden = false
        self.gotoBtn.isHidden = false
        self.atView.stopAnimating()
    }
    
    private func dmLocalAdsData(completion: @escaping ([String: Any]?) -> Void) {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            completion(nil)
            return
        }
        
        let url = URL(string: "https://open.wildf\(self.dmMainHostUrl())/open/postDMLocalAdsData")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = [
            "appModelName": UIDevice.current.model,
            "appKey": "176a1d60a4fd439fa0a8e320bd8c24d7",
            "appPackageId": bundleId,
            "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Failed to serialize JSON:", error)
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Request error:", error ?? "Unknown error")
                    completion(nil)
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let resDic = jsonResponse as? [String: Any] {
                        let dictionary: [String: Any]? = resDic["data"] as? Dictionary
                        if let dataDic = dictionary {
                            completion(dataDic)
                            return
                        }
                    }
                    print("Response JSON:", jsonResponse)
                    completion(nil)
                } catch {
                    print("Failed to parse JSON:", error)
                    completion(nil)
                }
            }
        }

        task.resume()
    }
}
