//
//  ViewController.swift
//  photoLibrary
//
//  Created by 이진하 on 2020/04/29.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import SwiftPhotoGallery
import EmptyDataSet_Swift
import CoreData


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,SwiftPhotoGalleryDataSource,SwiftPhotoGalleryDelegate, EmptyDataSetSource ,EmptyDataSetDelegate,SaveImage{
 
 
    var Photos: [NSManagedObject] = []
    var index: Int = 0
    
    @IBAction func addPhoto(_ sender: Any) {
        performSegue(withIdentifier: "detail", sender: nil)
    }
    //SwiftPhotogGallery delegate , datasource
    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
        return self.Photos.count
    }
    
    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> UIImage? {

        return UIImage(data: self.Photos[forIndex].value(forKey: "photo") as! Data)
    }
    
    func galleryDidTapToClose(gallery: SwiftPhotoGallery) {
        self.index = gallery.currentPage
        dismiss(animated: true, completion: nil)
    }
    
    // UICollectionView DataSource, Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photoView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? CollectionViewCell else {return CollectionViewCell()}
        cell.photo.image = UIImage(data: self.Photos[indexPath.item].value(forKey: "photo") as! Data)
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.item
        
        let gallery = SwiftPhotoGallery(delegate: self, dataSource: self)
        gallery.backgroundColor = UIColor.black
        gallery.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
        gallery.currentPageIndicatorTintColor = UIColor(red: 0.0, green: 0.66, blue: 0.875, alpha: 1.0)
        gallery.modalPresentationStyle = .custom
        
        present(gallery, animated: true, completion: { () -> Void in
            gallery.currentPage = self.index
        })
        
    }
    
    
    //EmptyDataSet Delegate , DataSource
    var titleString: NSAttributedString? {
        var text:String? = "사진을 추가해주세요"
        var font:UIFont = UIFont.boldSystemFont(ofSize: 18)
        var textColor: UIColor? = UIColor.gray
        var attributes: [NSAttributedString.Key: Any] = [:]
        if font != nil { attributes[NSAttributedString.Key.font] = font}
        if textColor != nil { attributes[NSAttributedString.Key.foregroundColor] = textColor}
        return NSAttributedString.init(string: text!, attributes: attributes)
    }
    var buttonString: NSAttributedString? {
        var text:String? = "사진 추가하러가기"
        var font:UIFont = UIFont.boldSystemFont(ofSize: 18)
        var textColor: UIColor? = UIColor.purple
        var attributes: [NSAttributedString.Key: Any] = [:]
        if font != nil { attributes[NSAttributedString.Key.font] = font}
        if textColor != nil { attributes[NSAttributedString.Key.foregroundColor] = textColor}
        return NSAttributedString.init(string: text!, attributes: attributes)
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return titleString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        let image = UIImage(named: "농담곰")
        return image
    }
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        return buttonString
    }
    
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }

    func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
        performSegue(withIdentifier: "detail", sender: nil)
        
    }
    
    
    //saveImage Delegate
    func save(data saveData: Data) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Photo", in: managedContext)!
        
        let photo = NSManagedObject(entity: entity, insertInto: managedContext)
        photo.setValue(saveData ,forKey: "photo")
        
        do{
            try managedContext.save()
            self.Photos.append(photo)
        }catch let error as NSError{
            print("save error")
        }
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

    override func viewWillAppear(_ animated: Bool) {
        self.photoView.reloadData()
        print(Photos)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            let destination = segue.destination as! ViewController2
            destination.delegate = self
        }
    }

}

