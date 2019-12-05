//
//  HomeViewController.swift
//  Project
//
//  Created by Nguyễn Trung on 11/28/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var checkinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkinButton.layer.cornerRadius = 5

        logoImageView.image = UIImage(named: "logo")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "scanPage") as! QRCodeViewController
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func checkinButton(_ sender: Any) {
        performSegue(withIdentifier: "scanPage", sender: self)
    }
    
    
}
