//
//  FavouriteViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/5/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {

    
    @IBOutlet weak var favouriteTable: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favourites"

        // Do any additional setup after loading the view.
    }

}

extension FavouriteViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        
        cell.productTitle.text = "Product Title \(indexPath.row+1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "productDetailSegue", sender: nil)
        
    }
    
}

