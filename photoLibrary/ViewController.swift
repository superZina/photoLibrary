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
import EmptyDataSet_Swift

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,SwiftPhotoGalleryDataSource,SwiftPhotoGalleryDelegate, EmptyDataSetSource ,EmptyDataSetDelegate{
    let imageNames: [String] = []
    var index: Int = 0
    
    //SwiftPhotogGallery delegate , datasource
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
    
    // UICollectionView DataSource, Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photoView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? CollectionViewCell else {return CollectionViewCell()}
        cell.photo.image = UIImage(named: self.imageNames[indexPath.row])
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.item
        
        let gallery = SwiftPhotoGallery(delegate: self, dataSource: self)
        gallery.backgroundColor = UIColor.black
        gallery.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
        gallery.currentPageIndicatorTintColor = UIColor(red: 0.0, green: 0.66, blue: 0.875, alpha: 1.0)
        gallery.hidePageControl = false
        gallery.modalPresentationStyle = .custom
        
        present(gallery, animated: true, completion: { () -> Void in
            gallery.currentPage = self.index
        })
    }
    
    //EmptyDataSet Delegate , DataSource
    var titleString: NSAttributedString? {
        var text:String? = "사진을 추가해주세요"
        var font:UIFont = UIFont.boldSystemFont(ofSize: 18)
        var textColor: UIColor? = UIColor.blue
        var attributes: [NSAttributedString.Key: Any] = [:]
        if font != nil { attributes[NSAttributedString.Key.font] = font}
        if textColor != nil { attributes[NSAttributedString.Key.foregroundColor] = textColor}
        return NSAttributedString.init(string: text!, attributes: attributes)
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return titleString
    }
    
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    
    @IBOutlet weak var photoView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let photoCellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.photoView.register(photoCellNib, forCellWithReuseIdentifier: "photoCell")
        self.photoView.delegate = self
        self.photoView.dataSource = self
        self.photoView.emptyDataSetSource = self
        self.photoView.emptyDataSetDelegate = self
        self.photoView.reloadData()
        self.photoView.reloadEmptyDataSet()
    }


}

