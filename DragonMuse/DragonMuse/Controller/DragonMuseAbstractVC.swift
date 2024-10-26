//
//  AbstractVC.swift
//  Dragon Muse: Artistic Abode
//
//  Created by SHREE KRISHNA on 25/10/24.
//

import UIKit

class DragonMuseAbstractVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collViewMain: UICollectionView!
    
    var arrAbstract = ["A2","A3","A4","A5","A6","A7","A8","A9","A10","A11","A12","A13","A14","A15","A16"]
    var flowLayouts: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            _flowLayout.itemSize = CGSize(width: self.collViewMain.frame.size.width/2, height:320)
            
            _flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            _flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
            _flowLayout.minimumInteritemSpacing = 0.0
            _flowLayout.minimumLineSpacing = 0.0
        }
        
        return _flowLayout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        collViewMain.delegate = self
        collViewMain.dataSource = self
        collViewMain.register(UINib.init(nibName: "UploadCell", bundle: nil), forCellWithReuseIdentifier: "UploadCell")
        collViewMain.collectionViewLayout = self.flowLayouts
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrAbstract.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collViewMain.dequeueReusableCell(withReuseIdentifier: "UploadCell", for: indexPath) as! UploadCell
        cell.imgUpload.image = UIImage.init(named: arrAbstract[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController.init(title: "Dragon Muse: Artistic Abode", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction.init(title: "Share Image", style: .default, handler: { alertYES in
            
            self.shareImage (image: UIImage.init(named: self.arrAbstract[indexPath.row])!)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Download image", style: .default, handler: { alertYES in
            
            let alertDelete = UIAlertController.init(title: "Dragon Muse: Artistic Abode", message: "Are You Sure To Download Art Image?", preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction.init(title: "YES", style: .default, handler: { alertYES in
                UIImageWriteToSavedPhotosAlbum(UIImage.init(named: self.arrAbstract[indexPath.row])!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                
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
