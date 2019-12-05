//
//  QRCodeViewController.swift
//  Project
//
//  Created by Nguyễn Trung on 11/27/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        scanButton.layer.borderWidth = 1
        scanButton.layer.cornerRadius = 5
        scanButton.backgroundColor = UIColor.yellow
        
    }
    
    @IBAction func scanButton(_ sender: Any) {
        let vc = QRScanViewController()
        let navigation = UINavigationController(rootViewController: vc)
        self.present(navigation, animated: true, completion: nil)
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "nextToHome") as! HomeViewController
        self.present(mainVC, animated: true, completion: nil)
    }
    
}
