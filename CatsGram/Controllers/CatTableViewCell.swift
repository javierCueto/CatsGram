//
//  CatTableViewCell.swift
//  CatsGram
//
//  Created by José Javier Cueto Mejía on 18/04/20.
//  Copyright © 2020 Pozolx. All rights reserved.
//

import UIKit
import Firebase

class CatTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameEmail: UILabel!
    
    @IBOutlet weak var tableImageView: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var idPostLabel: UILabel!
    //var likeCount = 0
    
    @IBOutlet weak var likeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
      //  likeCount += 1
        //likeLabel.text = "\(likeCount)"
        
        let fireStoreDatabase = Firestore.firestore()
        if let likeCount = Int(likeLabel.text!) {
            let likeStore = ["like" : likeCount + 1] as [String : Any]
            fireStoreDatabase.collection("Posts").document(idPostLabel.text!).setData(likeStore, merge: true)
        }
        
        
        
    }
}
