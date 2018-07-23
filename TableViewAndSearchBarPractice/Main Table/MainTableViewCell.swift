//
//  MainTableViewCell.swift
//  TableViewAndSearchBarPractice
//
//  Created by Denis Markov on 7/23/18.
//  Copyright © 2018 Denis Markov. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var restaurantName: UILabel!
    
    @IBOutlet weak var restaurantAdress: UILabel!
    
    func initCell(_ image: String?, name: String?, adress: String?) {
        restaurantImage.image = UIImage(named: image ?? "Restaurant Images/restaurant1")
        restaurantImage.layer.cornerRadius = 8.0
        restaurantName.text = name ?? "Default restaurant name"
        restaurantAdress.text = adress ?? "Default restaurant adress"
    }
}
