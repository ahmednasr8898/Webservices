//
//  PhotoViewController.swift
//  Webservices
//
//  Created by Ahmed Nasr on 10/14/20.
//
import UIKit
import Alamofire

class PhotoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var arrOfphoto = [PhotoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }
    
    @IBAction func getPhotoOnClick(_ sender: UIBarButtonItem) {
        
        let url = "https://jsonplaceholder.typicode.com/photos"
        
        AF.request(url , method:  .get , encoding: URLEncoding.default).responseJSON { (response) in
 
            switch response.result{
            case .failure(let error):
                print("connection with server is faild \(error)")
            case .success(let value):
                print("connection with server is success \(value)")
                
                if let json = response.value as? [[String: Any]]{
     
                    for item in json{
                        
                        let title = item["title"] as? String
                        let image = item["url"] as? String
                        
                        let model = PhotoModel.init(title: title, url: image)
                     
                        self.arrOfphoto.append(model)
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
}


extension PhotoViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfphoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        cell.myTiltleLbl.text = arrOfphoto[indexPath.row].title
        cell.getPhoto = arrOfphoto[indexPath.row]
        
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.33 , height:  self.view.frame.width * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
}
