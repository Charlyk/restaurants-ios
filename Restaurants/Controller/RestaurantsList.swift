//
//  RestaurantsList.swift
//  Restaurants
//
//  Created by Ion Damaschin on 7/10/18.
//  Copyright © 2018 Ion Damaschin. All rights reserved.
//

import UIKit
import Kingfisher
import Cartography
import CoreLocation

private let restaurantReuseIdentifier = "RestaurantCell"

class RestaurantsList: UIViewController, CLLocationManagerDelegate {

    let leftView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    var groups: [Group] = []
    var restaurants: [Restaurant] = []
    
    var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyan
        self.setupView()
        self.setupLocation()
    }
    
    @objc func getUserLocation(_ sender: UIButton) {
        self.locationManager.startUpdatingLocation()
    }
    
    func fetchData(lat: Double, lng: Double) {
        APIManager.mainData(lat: lat, lng: lng) { (groups, errorMessage) in
            if let data = groups {

                for group in data {
                    self.restaurants.append(contentsOf: group.items)
                }
                self.collectionView.reloadData()
            } else {
                print(errorMessage)
            }
        }
    }
    
    func setupView() {
        let subviews = [self.leftView]
        subviews.forEach { (view) in self.view.addSubview(view) }
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = true
        collectionView.backgroundColor = UIColor.clear
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 40
        self.view.addSubview(collectionView)

        constrain(leftView, collectionView, self.view) { (leftView, collection, container) in
            leftView.top == container.top
            leftView.bottom == container.bottom
            leftView.leading == container.leading
            leftView.width == 0.6 * container.width
        }
        
        collectionView.register(RestaurantCell.self, forCellWithReuseIdentifier: restaurantReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupLocation() {
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let lat = locationManager.location?.coordinate.latitude
            let lng = locationManager.location?.coordinate.longitude
            self.fetchData(lat: lat!, lng: lng!)
        }
    }
    
 }

extension RestaurantsList: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: restaurantReuseIdentifier, for: indexPath) as! RestaurantCell
        
        let restaurant = self.restaurants[indexPath.item]
        cell.restaurantName.text = restaurant.name
        cell.restaurantDistance.text = "\(restaurant.location.distance) m."
        cell.websiteUrl.text = restaurant.websiteUrl
        print(restaurant.photos[0].suffix)
        if  restaurant.photos[0].suffix.count != 0{
            let imageUrl = "\(restaurant.photos[0].prefix)400x400\(restaurant.photos[0].suffix)"
            print(imageUrl)
            let imageResource = ImageResource(downloadURL: URL(string: imageUrl)!, cacheKey: imageUrl)
            cell.restaurantPhoto.kf.setImage(with: imageResource)
        }
        
        if restaurant.hours.isOpen {
            cell.statusRestaurant.text = "Status: Open now"
        } else {
            cell.statusRestaurant.text = "Status: Closed now"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: 150)
    }
    
 }
