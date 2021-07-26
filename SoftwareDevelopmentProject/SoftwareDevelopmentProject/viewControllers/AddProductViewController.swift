//
//  AddProductViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/7/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit
import ImagePicker

class AddProductViewController: BaseViewController {
    
    let imagePickerController = ImagePickerController()
    
    var images = [UIImage]()
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var category: UITextField!
    
    @IBOutlet weak var productImageCollectionView: UICollectionView!
    
    let categoryPicker = UIPickerView()
    var selectedCategoryID : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 5
        
        categoryPicker.delegate = self
        category.inputView = categoryPicker
        setUpPickerViews()
        
        
        desc.layer.cornerRadius = 5.0
        desc.layer.borderWidth = 0.5
        desc.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        //        desc.contentInset = UIEdgeInsets.init(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
        desc.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Add Product"
    }
    
    
    func setUpPickerViews() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        
        toolBar.setItems([spaceButton,spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        category.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        self.category.resignFirstResponder()
    }
    
    
    @IBAction func addProductBtnAction(_ sender: Any) {
        
        guard let productTitle = titleText.text?.trimmingCharacters(in: .whitespaces) else { return }
        guard let desc = desc.text?.trimmingCharacters(in: .whitespaces) else { return }
        guard let price = price.text?.trimmingCharacters(in: .whitespaces) else { return }
        
        if (productTitle == "" || desc == "" || price == "" || selectedCategoryID == nil) {
            self.showErrorAlert(title: "Error", message: "All fields are required")
        }
        else if images.count == 0 {
            self.showErrorAlert(title: "Error", message: "Images are required")
        }
        else {
            //upload product
            
            let params = ["title": productTitle, "desc": desc, "category" : selectedCategoryID!, "price": Int(price) ?? 100, "location":"Fulda", "owner":Globals.sharedInstance.user!.id!] as [String : Any]
            
            var data = [Data]()
            for i in images {
                data.append(i.jpegData(compressionQuality: 0.5)!)
            }
            
            
            RestApiManager.sharedInstance.uploadMultipartData(vc: self, images: data, to: "products/", params: params, successCompletionHandler: { (data) in
                
                guard let data = data as? [String: Any] else { return }
                
                if (data["status"] as! String == "Failed") {
                    let title = data["status"] as! String
                    let message = data["message"] as? String ?? ""
                    self.showErrorAlert(title: title, message: message)
                }
                else {
                    self.navigationController?.popViewController(animated: true)
                }
                
            }) { (err) in
                print(err)
            }
            
        }
    }
}


extension AddProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count < 5 ? images.count+1 : images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! AddProductImageCollectionViewCell
        
        if indexPath.item < images.count {
            cell.image.image = images[indexPath.item]
        }
        else {
            cell.image.image = UIImage.init(named: "cameraIcon")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: 100.0, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
}


extension AddProductViewController: ImagePickerDelegate {
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        self.images = images
        self.productImageCollectionView.reloadData()
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        
    }
    
}


extension AddProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Globals.sharedInstance.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Globals.sharedInstance.categories[row].name!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedCategoryID = Globals.sharedInstance.categories[row].id!
        self.category.text = Globals.sharedInstance.categories[row].name!
    }
}

