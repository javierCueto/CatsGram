//
//  CellHome.swift
//  CatsGram
//
//  Created by José Javier Cueto Mejía on 18/04/20.
//  Copyright © 2020 Pozolx. All rights reserved.
//

import UIKit

class CellHome: UITableViewCell {

    @IBOutlet weak var userNameEmail: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    //let id = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func likeButtonClicked(_ sender: Any) {
    }
    

}
