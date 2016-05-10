//
//  Earthquaks.swift
//  Earthquakes Sample App
//
//  Copyright © 2016 Ali Afghah. All rights reserved.
//

import Foundation
import MapKit

// the object to be used on annotations
class Earthquake: NSObject, MKAnnotation {
    let title: String?
    let magnitude: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, magnitude: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.magnitude = magnitude
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return magnitude
    }

}
