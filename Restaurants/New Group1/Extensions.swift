//
//  Extensions.swift
//  Restaurants
//
//  Created by Ion Damaschin on 7/10/18.
//  Copyright © 2018 Ion Damaschin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension JSON {
    func parseArrayTo<Element: JSONeable>(object: Element.Type) -> [Element] {
        var elements: [Element] = []
        for (_, object) in self {
            let element = Element(json: object)
            elements.append(element)
        }
        return elements
    }
}
