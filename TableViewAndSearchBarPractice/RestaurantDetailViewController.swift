//
//  RestaurantDetailViewController.swift
//  TableViewAndSearchBarPractice
//
//  Created by Denis Markov on 7/23/18.
//  Copyright © 2018 Denis Markov. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    

    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var restaurantName: UILabel!
    
    @IBOutlet weak var restaurantAdress: UILabel!
    
    var restaurantDetails : RestaurantModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initOutlets()
    }
    
    func initOutlets() {
        restaurantImage.image = UIImage(named: restaurantDetails?.imageName ?? "Restaurant Images/restaurant1")
        restaurantImage.layer.cornerRadius = 8.0
        restaurantName.text = restaurantDetails?.header ?? "Default restaurant name"
        restaurantAdress.text = restaurantDetails?.adress ?? "Default restaurant adress"
    }
    

}
