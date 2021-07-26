//
//  FilterViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/7/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit
import RangeSeekSlider
import PopupDialog

class FilterViewController: UIViewController {

    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var sortByTextField: UITextField!
    @IBOutlet weak var priceRange: RangeSeekSlider!
    
    var popUp: PopupDialog?
    var hostController : ProductListingViewController?
    
    let categoryPicker = UIPickerView()
    let sortPicker = UIPickerView()
    
    let sortItems = ["Highest Price", "Lowest Price","Date Added","Name"]
    
    var selectedCategoryID : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryPicker.delegate = self
        sortPicker.delegate = self
        
        categoryPicker.tag = 1
        sortPicker.tag = 2
        
        categoryTextField.inputView = categoryPicker
        sortByTextField.inputView = sortPicker
        
        setUpPickerViews()
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
        
        categoryTextField.inputAccessoryView = toolBar
        sortByTextField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        self.categoryTextField.resignFirstResponder()
        self.sortByTextField.resignFirstResponder()
    }
    
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        popUp!.dismiss()
    }
    
    @IBAction func applyBtnAction(_ sender: Any) {
        
        popUp!.dismiss()
    }
    
    
}


extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 1 ? Globals.sharedInstance.categories.count : sortItems.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView.tag == 1 ? Globals.sharedInstance.categories[row].name! : sortItems[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView.tag == 1 {
            selectedCategoryID = Globals.sharedInstance.categories[row].id!
            categoryTextField.text = Globals.sharedInstance.categories[row].name!
        }
        else {
            sortByTextField.text = sortItems[row]
        }
        
    }

}
