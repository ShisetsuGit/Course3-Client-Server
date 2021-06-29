//
//  CollectionViewController.swift
//  UI_Project
//
//  Created by  Shisetsu on 12.12.2020.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var photoToFullScreen = [PhotoModel]()
    let DB = PhotoDatabaseService()
    var userID = String()
    
    var counts = 3
    var offset:CGFloat = 2.0
    
    
    override func viewDidLoad() {
        photoToFullScreen = self.DB.read(userID: self.userID)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
//            print(self.photoToFullScreen)
            self.collectionView.reloadData()
        }
        
        self.tabBarController?.tabBar.isHidden = false
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "friendPhoto")
        self.collectionView!.register(UINib(nibName: "PhotoFullViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoFullViewCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photos = photoToFullScreen[indexPath.row]
        imageCache(url: photos.url!) { image in
            let imageView = UIImageView(image: image)
            imageView.frame = self.view.frame
            imageView.backgroundColor = .black
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true

            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage))
            imageView.addGestureRecognizer(tap)

            self.view.addSubview(imageView)
            self.tabBarController?.tabBar.isHidden = true
            collectionView.isScrollEnabled = true
        }
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoToFullScreen.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoFullViewCell", for: indexPath) as! PhotoFullViewCell
        let photos = photoToFullScreen[indexPath.row]
        imageCache(url: photos.url!) { image in
            cell.photoView.image = image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let photoFrame = collectionView.frame
        let widthFrame = photoFrame.width / CGFloat(counts)
        let heightFrame = widthFrame
        let spacing = CGFloat((counts + 1)) * offset / CGFloat(counts)
        return CGSize(width: widthFrame - spacing, height: heightFrame - (offset*2))
    }

}
