//
//  Utils.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/7/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

class BaseViewController: UIViewController {
    
    
    func showErrorAlert(title: String, message: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "alertViewController") as AlertViewController
        
        vc.alertTitle = title
        vc.message = message
        
        let popup = PopupDialog(viewController: vc, buttonAlignment: .horizontal, transitionStyle: .bounceUp, tapGestureDismissal: true)

        vc.popUp = popup
        
        
        self.present(popup, animated: true, completion: nil)
    }
    
    
    var loadingVC = LoadingPartialViewController()
    var showingLoading = false
    
    func showLoading(){
        if(!showingLoading)
        {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                self.loadingVC = storyboard.instantiateViewController(withIdentifier: "LoadingPartial") as! LoadingPartialViewController
                self.loadingVC.modalPresentationStyle = .custom
                self.loadingVC.view.backgroundColor = UIColor.black
                self.present(self.loadingVC, animated: false, completion: nil)
            }
            self.showingLoading = true
        }
    }
    
    func hideLoading()
    {
        self.loadingVC.dismiss(animated: false, completion: nil)
        self.showingLoading = false
    }
    
}


