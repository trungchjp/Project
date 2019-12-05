//
//  ViewController.swift
//  Project
//
//  Created by Nguyễn Trung on 11/23/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField.placeholder = "Mã sinh viên"
        passTextField.placeholder = "Mật khẩu"
        userTextField.borderStyle = .none
//        userTextField.textAlignment = .center
//        passTextField.textAlignment = .center
        passTextField.borderStyle = .roundedRect
        passTextField.isSecureTextEntry = true
        loginButton.layer.cornerRadius = 5
        
        logoImageView.image = UIImage(named: "logo")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextToHome") as! HomeViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userTextField.underlined(.gray)
        passTextField.underlined(.gray)
    }

    @IBAction func loginButton(_ sender: Any) {
        if userTextField.text == "admin" {
            if passTextField.text == "123" {
                performSegue(withIdentifier: "nextToHome", sender: self)
            } else {
                notificationLabel.text = "Sai mật khẩu"
            }
        } else {
            notificationLabel.text = "Sai mã sinh viên "
        }
        
    }
    
}

extension UITextField {
    
    func underlined(_ color: UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1.0)
        bottomLine.backgroundColor = color.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
}

