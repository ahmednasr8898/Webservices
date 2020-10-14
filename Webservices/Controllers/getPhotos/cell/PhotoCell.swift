//
//  PhotoCell.swift
//  Webservices
//
//  Created by Ahmed Nasr on 10/14/20.
//

import UIKit
import Alamofire
import Kingfisher

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myTiltleLbl: UILabel!
    
    
    var getPhoto: PhotoModel!{
        didSet{
            
            guard let photo = getPhoto else {
                return
            }
            
            //self.myImageView.image = UIImage(named: "image")
            
            //download photos using AlamofireImage
            /*AF.request(photo.url!).response { (response) in
                if let data = response.data , let image = UIImage(data: data){
                    self.myImageView.image = image
                }
            }*/
            
            //download photos using kingfisher
            self.myImageView.kf.indicatorType = .activity
            if let url = URL(string: photo.url!){            self.myImageView.kf.setImage(with: url)
            }
        }
    }
}
