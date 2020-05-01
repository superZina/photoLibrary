//
//  ViewController.swift
//  photoLibrary
//
//  Created by 이진하 on 2020/04/29.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photoView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? CollectionViewCell else {return CollectionViewCell()}
        cell.photo.image = UIImage(named: "농담곰")
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: nil)
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

