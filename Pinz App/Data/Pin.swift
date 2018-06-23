//
//  Pin.swift
//  Pinz App
//
//  Created by Matt Hickman on 6/21/18.
//  Copyright © 2018 Matt Hickman. All rights reserved.
//

import Foundation

class Pin {
    var title: String
    var description: String
    var location: Location
    
    init(title: String, description: String, location: Location) {
        self.title = title
        self.description = description
        self.location = location
    }
}
