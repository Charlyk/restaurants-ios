//
//  Restaurant.swift
//  Restaurants
//
//  Created by Ion Damaschin on 7/10/18.
//  Copyright © 2018 Ion Damaschin. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONeable {
    init(json: JSON)
}

class Groups: JSONeable {
    let groups: [Group]
    
    required init(json: JSON) {
        self.groups = json.parseArrayTo(object: Group.self)
    }
}

class Group: JSONeable {
    let groupType: String
    let groupName: String
    let items: [Restaurant]
    
    
    required init(json: JSON) {
        self.groupName = json["name"].stringValue
        self.groupType = json["type"].stringValue
        self.items = json["items"].parseArrayTo(object: Restaurant.self)
    }
 }

class Restaurant: JSONeable {
    let location: Location!
    let hours: RestaurantHours!
    let websiteUrl: String
    let name: String
    var photos: [Photo]
    
    required init(json: JSON) {
        self.location = Location(json: json["venue"]["location"])
        self.hours = RestaurantHours(json: json["venue"]["hours"])
        self.websiteUrl = json["venue"]["url"].stringValue
        self.name = json["venue"]["name"].stringValue
        
        self.photos = []
        
        if json["venue"]["photos"].exists() {
            for item in json["venue"]["photos"]["groups"].arrayValue {
                for photoItem in item["items"].arrayValue {
                    let newPhoto = Photo(json: photoItem)
                    self.photos.append(newPhoto)
                    }
                }
            }
        }
}

class Location: JSONeable {
    let address: String
    let lat: Double
    let lng: Double
    let distance: String
    let city: String
    
    required init(json: JSON) {
        self.address = json["address"].stringValue
        self.lat = json["lat"].doubleValue
        self.lng = json["lng"].doubleValue
        self.distance = json["distance"].stringValue
        self.city = json["city"].stringValue
    }
}

class RestaurantHours: JSONeable {
    let status: String
    let isOpen: Bool
    let isLocalHoliday: Bool
    
    required init(json: JSON) {
        self.status = json["status"].stringValue
        self.isOpen = json["isOpen"].boolValue
        self.isLocalHoliday = json["isLocalHoliday"].boolValue
    }
}

class Photo: JSONeable {
    let prefix: String
    let suffix: String
    let width: String
    let height: String
    
    required init(json: JSON) {
        self.prefix = json["prefix"].stringValue
        self.suffix = json["suffix"].stringValue
        self.width = json["width"].stringValue
        self.height = json["height"].stringValue
    }

}
