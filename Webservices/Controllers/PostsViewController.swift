//
//  PostsViewController.swift
//  Webservices
//
//  Created by Ahmed Nasr on 10/13/20.
//
import UIKit
import Alamofire
import SwiftyJSON

class PostsViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var arrOfPosts = [PostsModel]()
    var arrOfComments = [Comments]()
    var arrOfUsers = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        tableView.separatorInset = .zero
        tableView.contentInset = .zero
        
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)

        //POSTS API
        /*cell.textLabel?.text = arrOfPosts[indexPath.row].title
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.lineBreakMode = .byWordWrapping
        cell.textLabel!.font = UIFont.systemFont(ofSize: 14.0)*/
        
        
        //COMMENTS API
        /*cell.textLabel?.text = arrOfComments[indexPath.row].name
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17.0)
        cell.textLabel?.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
       
        cell.detailTextLabel?.text = arrOfComments[indexPath.row].email
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cell.detailTextLabel?.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)*/
        
        //USERS API
        cell.textLabel?.text = arrOfUsers[indexPath.row].companyName
        cell.detailTextLabel?.text = arrOfUsers[indexPath.row].catchPhrase
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @IBAction func getPostsOnClick(_ sender: Any) {
        
        //getPosts()
        //getComments()
        getUsers()
    }
}

extension PostsViewController{
    func getPosts(){
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        AF.request(url , method: .get , encoding: URLEncoding.default).responseJSON { (response) in
            
            switch response.result{
            case .failure(let error):
                print("Connecting with server is falid:\(error)")
            case .success(let value):
                print("conneting with server is success: \(value)")
                
                if let json = response.value as? [[String : Any]]{
                    
                    for user in json{
                    
                        let body = user["body"] as? String
                        let title = user["title"] as? String
                    
                        let post = PostsModel.init(title: title, body: body)
                        self.arrOfPosts.append(post)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

extension PostsViewController{
    func getComments(){
        
        let url = "https://jsonplaceholder.typicode.com/comments"

        AF.request(url , method: .get , encoding: URLEncoding.default).responseJSON { (response) in
                
                switch response.result{
                case .failure(let error):
                    print("Connection with server is falid \(error)")
                    
                case .success(let value):
                    print("connection with server is success \(value)")
                    
                    if let json = response.value as? [[String: Any]]{
                    
                    for comment in json {
                        
                        let name = comment["name"] as? String
                        let email = comment["email"] as? String
                        
                        let model = Comments.init(postId: nil, id: nil, name: name, email: email, body: nil)
                        self.arrOfComments.append(model)
                        self.tableView.reloadData()
                    
                    }
                }
            }
        }
    }
}

extension PostsViewController{
    func getUsers(){
        let url = "https://jsonplaceholder.typicode.com/users"
        
        AF.request(url , method: .get , encoding: URLEncoding.default).responseJSON { (response) in
        
                switch response.result{
                
                case .failure(let error):
                    print("connection with server is falid \(error)")
                case .success(let value):
                    print("connection with server is success \(value)")
                
                    if let json = response.value as? [[String: Any]]{
                       
                    for user in json{
                        
                        let userName = user["username"] as? String
                        let email = user["email"] as? String
                        
                        
                        guard  let address = user["address"] as? [String: Any] else { return }
                        let street = address["street"] as? String
                        let city = address["city"] as? String
       
                        guard let geo = address["geo"] as? [String: Any] else{ return }
                        let lat = geo["lat"] as? String
                        let lng = geo["lng"] as? String
                        
                        let phone = user["phone"] as? String
                        let website = user["website"] as? String
                        
                        guard let company = user["company"] as? [String: Any] else{ return }
                        let companyName = company["name"] as? String
                        let ctachPhrase = company["catchPhrase"] as? String
                        
                        let model = UserModel.init(id: nil, name: nil, username: userName, email: email, street: street, suite: nil, city: city, zipcode: nil, lat: lat, lng: lng, phone: phone, website: website, companyName: companyName, catchPhrase: ctachPhrase, bs: nil)
                        
                            self.arrOfUsers.append(model)
                            self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
   
