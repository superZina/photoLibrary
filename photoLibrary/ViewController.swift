//
//  ViewController.swift
//  photoLibrary
//
//  Created by 이진하 on 2020/04/29.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import Photos
import SwiftPhotoGallery

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,SwiftPhotoGalleryDataSource,SwiftPhotoGalleryDelegate{
    let imageNames: [String] = ["농담곰","농담곰","농담곰"]
    var index: Int = 0
    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
        return self.imageNames.count
    }
    
    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> UIImage? {
        return UIImage(named: self.imageNames[forIndex])
    }
    
    func galleryDidTapToClose(gallery: SwiftPhotoGallery) {
        dismiss(animated: true) {
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photoView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? CollectionViewCell else {return CollectionViewCell()}
        cell.photo.image = UIImage(named: "농담곰")
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.item
        
        let gallery = SwiftPhotoGallery(delegate: self, dataSource: self)
        gallery.backgroundColor = UIColor.gray
        gallery.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
        gallery.currentPageIndicatorTintColor = UIColor.white
        gallery.hidePageControl = false
        
        present(gallery, animated: true, completion: { () -> Void in
            gallery.currentPage = self.index
        })
    }
    @IBOutlet weak var photoView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let photoCellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.photoView.register(photoCellNib, forCellWithReuseIdentifier: "photoCell")
        self.photoView.delegate = self
        self.photoView.dataSource = self
        self.photoView.reloadData()
    }


}

