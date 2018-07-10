//
//  RestaurantCell.swift
//  Restaurants
//
//  Created by Ion Damaschin on 7/10/18.
//  Copyright © 2018 Ion Damaschin. All rights reserved.
//

import UIKit
import Cartography

class RestaurantCell: UICollectionViewCell {
    
    let restaurantName: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let restaurantPhoto: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let restaurantDistance: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.textAlignment = .right
        return label
    }()
    
    let openClose: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let websiteUrl: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    let imageContainer: UIView = {
       let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let mainView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    let statusRestaurant: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createCellLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCellLayout() {
        self.addSubview(mainView)
        self.addSubview(restaurantName)
        self.addSubview(imageContainer)
        self.addSubview(restaurantDistance)
        self.addSubview(websiteUrl)
        self.imageContainer.addSubview(restaurantPhoto)
        self.addSubview(statusRestaurant)
        
        constrain(mainView, restaurantName, imageContainer, restaurantDistance, websiteUrl,statusRestaurant, self) { (mainView, name, imageContainer, distance, websiteUrl,statusRestaurant, cell) in
            mainView.top == cell.top
            mainView.trailing == cell.trailing
            mainView.bottom == cell.bottom
            mainView.leading == cell.leading + 20
            
            name.top == cell.top + 10
            name.trailing == cell.trailing - 5
            name.centerX == mainView.centerX
            
            imageContainer.height == 70
            imageContainer.width == 70
            imageContainer.centerY == cell.centerY
            imageContainer.leading == mainView.leading - 20
            
            distance.bottom == mainView.bottom - 5
            distance.trailing == mainView.trailing - 7
            
            websiteUrl.trailing == distance.leading
            websiteUrl.centerY == distance.centerY
            websiteUrl.leading == imageContainer.trailing
            websiteUrl.bottom == mainView.bottom - 5
            
            statusRestaurant.leading == imageContainer.trailing + 10
            statusRestaurant.centerY == imageContainer.centerY
            
        }
        
        constrain(imageContainer, restaurantPhoto) { (container, image) in
            image.leading == container.leading
            image.trailing == container.trailing
            image.top == container.top
            image.bottom == container.bottom
        }
    }

}
