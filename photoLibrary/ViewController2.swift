//
//  ViewController2.swift
//  photoLibrary
//
//  Created by 이진하 on 2020/05/07.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import Mantis

protocol  SaveImage: class {
    func save(data saveData: Data)
}

class ViewController2: UIViewController,UIImagePickerControllerDelegate, CropViewControllerDelegate, UINavigationControllerDelegate {
    
    weak var delegate: SaveImage?
    
    @IBOutlet weak var imageView: UIImageView!
    let picker = UIImagePickerController()
    
    @IBAction func addImage(_ sender: Any) {
        guard let image = self.imageView.image?.pngData() else {return}
        delegate?.save(data: image)
        print(image)
        //스위프트 정말 똑똑하군요
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var galleryButton: UIButton!
    
    @IBAction func galleryButton(_ sender: Any) {
        self.openLibrary()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.galleryButton.isHidden = true
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        galleryButton.isHidden = false
    }
    
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage) {
        imageView.image = cropped
        self.dismiss(animated: true, completion: nil)
    }
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: true,completion:  nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.imageView.image = selectedImage
        }
        self.dismiss(animated: true, completion: nil)
        
        let imageCropViewController = Mantis.cropViewController(image: self.imageView.image!)
        imageCropViewController.modalPresentationStyle = .fullScreen
        imageCropViewController.delegate = self
        self.present(imageCropViewController,animated: true,completion: nil)
        
    }
}
