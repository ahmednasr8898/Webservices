//
//  ViewController.swift
//  Webservices
//
//  Created by Ahmed Nasr on 10/13/20.
//
import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginOnClick(_ sender: UIButton) {
        
        guard let email = emailTxt.text , !email.isEmpty , let password = passwordTxt.text , !password.isEmpty else {
            return }
        
        let url = "https://elzohrytech.com/alamofire_demo/api/v1/login"
        let parameter = ["email": email, "password": password ]
        
        AF.request(url , method: .post , parameters: parameter , encoding: URLEncoding.default).responseJSON { (response) in
     
            switch(response.result){
            case .failure(let error):
                print("connecting with services is faild: \(error)")
            case .success(let value):
                //print("connecting with services is success \(value)")
                let json = JSON(value)
                if let status = json["status"].int{
                    if status == 1 {
                        print("Login Success")
                    }else{
                        print("Login Faild")
                    }
                }
            }
        }
    }
}
