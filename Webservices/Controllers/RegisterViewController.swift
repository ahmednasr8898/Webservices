//
//  RegisterViewController.swift
//  Webservices
//
//  Created by Ahmed Nasr on 10/13/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var re_passwordtxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerOnClick(_ sender: UIButton) {
        
        guard let name = nameTxt.text , !name.isEmpty , let email = emailTxt.text , !email.isEmpty , let password = passwordTxt.text , !password.isEmpty , let re_password = re_passwordtxt.text , !re_password.isEmpty else {
            return
        }
        
        let url = "https://elzohrytech.com/alamofire_demo/api/v1/register"
        let parameter = [
        
            "name": name,
            "email": email,
            "password": password,
            "password_confirmation": re_password
        ]
        
        AF.request(url , method: .post , parameters: parameter , encoding: URLEncoding.default)
            .responseJSON { (response) in
                
                switch response.result{
                
                case .failure(let error):
                    print("Connection with server is Faild \(error)")
        
                case .success(let value):
                    print("connection with server is success \(value)")
                    
                    let json = JSON(value)
                    if let _ = json["user"]["api_token"].string{
                        
                        print("register success")
                    }else{
                        print("register faild")
                }
            }
        }
    }
}
