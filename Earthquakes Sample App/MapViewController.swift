//
//  MapViewController.swift
//  Earthquakes Sample App
//
//  Copyright © 2016 Ali Afghah. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var earthquakesArray : [[String:AnyObject]]!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // check if the data was loaded
        if earthquakesArray != nil {
            
            // the object for annotations
            var earthquakes = [Earthquake]()
            
            // for map view center we need these
            var allLatitudes = [Double]()
            var allLongitudes = [Double]()
            
            // check if the data contains any values
            if earthquakesArray.count > 0 {
            
                // populate the earthquakes object and the lat and lng arrays
                for index in 0...earthquakesArray.count - 1 {
                    var earthquakeArrayAtIndex = earthquakesArray[index]
                    earthquakes.append(
                        Earthquake(
                            title: "ID: " + String(earthquakeArrayAtIndex["eqid"]!),
                            magnitude: "Magnitude: " + String((Double(earthquakeArrayAtIndex["magnitude"] as! Double) * 10.0) / 10.0),
                            coordinate: CLLocationCoordinate2D(latitude: Double(earthquakeArrayAtIndex["lat"] as! Double), longitude: Double(earthquakeArrayAtIndex["lng"] as! Double))
                        )
                    )
                    
                    allLatitudes.append(Double(earthquakeArrayAtIndex["lat"] as! Double))
                    allLongitudes.append(Double(earthquakeArrayAtIndex["lng"] as! Double))
                }
            }
            
            // center map function
            let maxLat = allLatitudes.maxElement()
            let maxLng = allLongitudes.maxElement()
            
            let minLat = allLatitudes.minElement()
            let minLng = allLongitudes.minElement()
            
            let centerLat = (minLat! + maxLat!) / 2.0
            let centerLng = (minLng! + maxLng!) / 2.0
            
            let regionRadius: CLLocationDistance = 11100000
            
            func centerMapOnLocation(location: CLLocation) {
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 1.0, regionRadius * 1.0)
                mapView.setRegion(coordinateRegion, animated: true)
            }

            let initialLocation = CLLocation(latitude: centerLat, longitude: centerLng)
            centerMapOnLocation(initialLocation)
            
            // add annotations to the map view
            mapView.addAnnotations(earthquakes)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

