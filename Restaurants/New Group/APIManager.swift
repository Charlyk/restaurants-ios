//
//  APIManager.swift
//  Restaurants
//
//  Created by Ion Damaschin on 7/10/18.
//  Copyright © 2018 Ion Damaschin. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class APIManager {
    
    static func mainData(lat: Double, lng: Double ,handler: @escaping (_ data: [Group]?, _ errorMessage: String?) -> Void) {
        let baseUrl = "https://api.foursquare.com/v2/venues/explore?ll=\(lat),\(lng)&section=food&venuePhotos=1&oauth_token=NKRP0KY5ZDZIBMCU3TZS4BMP4ZMIQZBQPLBTCPXSIGPWFJ1L&v=20160629"
//        let baseUrl = "https://api.foursquare.com/v2/venues/explore?ll=47.016756,28.836708&section=food&venuePhotos=1&oauth_token=NKRP0KY5ZDZIBMCU3TZS4BMP4ZMIQZBQPLBTCPXSIGPWFJ1L&v=20160629"
        Alamofire.request(baseUrl.removingPercentEncoding!, method: .get).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var groups: [Group] = []
                for group in json["response"]["groups"].arrayValue {
                    let newGroup = Group(json: group)
                    groups.append(newGroup)
                }
                handler(groups, nil)
            case .failure(let error):
                print("error")
                handler(nil, error.localizedDescription)
            }
        }
    }
    
    
//    https://api.foursquare.com/v2/venues/explore?ll=47.016756,28.836708&section=food&venuePhotos=1&oauth_token=NKRP0KY5ZDZIBMCU3TZS4BMP4ZMIQZBQPLBTCPXSIGPWFJ1L&v=20160629
    
}
