//
//  UploadVC.swift
//  Dragon Muse: Artistic Abode
//
//  Created by SHREE KRISHNA on 25/10/24.
//

import UIKit

class UploadVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collViewMain: UICollectionView!
    @IBOutlet weak var viewNoData: UIView!
    var arrImage = NSMutableArray()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
        
        collViewMain.delegate = self
        collViewMain.dataSource = self
        collViewMain.register(UINib.init(nibName: "UploadCell", bundle: nil), forCellWithReuseIdentifier: "UploadCell")
        collViewMain.collectionViewLayout = self.flowLayouts
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.refreshData()
    }
    
    func refreshData() {
        arrImage = getAppScene()?.getFavoriteArtData() ?? NSMutableArray()
        
        if arrImage.count == 0 {
            self.collViewMain.isHidden = true
            self.viewNoData.isHidden = false
        } else {
            self.collViewMain.isHidden = false
            self.viewNoData.isHidden = true
            self.collViewMain.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collViewMain.dequeueReusableCell(withReuseIdentifier: "UploadCell", for: indexPath) as! UploadCell
        cell.imgUpload.image = (arrImage[indexPath.row] as! UIImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController.init(title: "Dragon Muse: Artistic Abode", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction.init(title: "Share Image", style: .default, handler: { alertYES in
            
            self.shareImage(image: (self.arrImage[indexPath.row] as! UIImage))
            
        }))
        
        alert.addAction(UIAlertAction.init(title: "Delete Image", style: .destructive, handler: { alertYES in
            
            let alertDelete = UIAlertController.init(title: "Dragon Muse: Artistic Abode", message: "Are You Sure To Delete Image?", preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction.init(title: "YES", style: .default, handler: { alertYES in
                self.arrImage.removeObject(at: indexPath.row)
                self.getAppScene()?.saveFavoriteArtData(array: self.arrImage)
                DispatchQueue.main.async {
                    self.refreshData()
                }
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
    
    private func showImageAlert() {
        
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    //MARK:- UIImagePickerViewDelegate.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) { [weak self] in
            
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            //Setting image to your image view
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let arrData = self?.getAppScene()?.getFavoriteArtData() ?? NSMutableArray()
            arrData.add(image)
            
            self?.getAppScene()?.saveFavoriteArtData(array: arrData)
            self?.refreshData()
        }
    }
    @IBAction func Back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Upload(_ sender: Any) {
        showImageAlert()
    }
    
}
