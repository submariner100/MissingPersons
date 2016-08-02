//
//  PersonCell.swift
//  MissingPersons
//
//  Created by Macbook on 28/07/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {

  @IBOutlet weak var personImage: UIImageView!
  
  var person: Person!
  
  
  func configureCell(person: Person) {
    self.person = person
    if let url = NSURL(string: "\(baseURL)\(person.personImageUrl!)") {
        downloadImage(url)
    }
  }
  
  func downloadImage(url: NSURL) {
    getDataFromUrl(url) { (data, response, error) in
      dispatch_async(dispatch_get_main_queue()) { () -> Void in
        guard let data = data where error == nil else { return }
        self.personImage.image = UIImage(data: data)
        self.person.personImage = self.personImage.image
        
        
        
      }
    }
    
  }
  
  func getDataFromUrl(url: NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)) {
    
    NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
        completion(data: data, response: response, error: error)
    }.resume()
    
  }
  func setSelected() {
    personImage.layer.borderWidth = 2.0
    personImage.layer.backgroundColor = UIColor.yellowColor().CGColor
    
    self.person.downloadFaceId()
    
  }
}
