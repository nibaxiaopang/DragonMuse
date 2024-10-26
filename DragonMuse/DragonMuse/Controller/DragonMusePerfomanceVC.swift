//
//  PerfomanceVC.swift
//  Dragon Muse: Artistic Abode
//
//  Created by SHREE KRISHNA on 25/10/24.
//

import UIKit

class DragonMusePerfomanceVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    var arrPerfomance = ["10","2","3","4","5","6","7","8","9","11","12","13","15","16"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib.init(nibName: "ArtCell", bundle: nil), forCellReuseIdentifier: "ArtCell")
        navigationController?.navigationBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPerfomance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "ArtCell") as! ArtCell
        cell.imgArt.image = UIImage.init(named: arrPerfomance[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController.init(title: "Dragon Muse: Artistic Abode", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction.init(title: "Share Image", style: .default, handler: { alertYES in
            
            self.shareImage(image: UIImage.init(named: self.arrPerfomance[indexPath.row])!)
            
        }))
        
        alert.addAction(UIAlertAction.init(title: "Download image", style: .default, handler: { alertYES in
            
            let alertDelete = UIAlertController.init(title: "Dragon Muse: Artistic Abode", message: "Are You Sure To Download Art Image?", preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction.init(title: "YES", style: .default, handler: { alertYES in
                UIImageWriteToSavedPhotosAlbum(UIImage.init(named: self.arrPerfomance[indexPath.row])!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                
            }))
            alertDelete.addAction(UIAlertAction.init(title: "NO", style: .cancel))
            self.present(alertDelete, animated: true)
            
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    func shareImage(image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: FUNCTIONS
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    @IBAction func Back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
