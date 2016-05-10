//
//  ListViewController.swift
//  Earthquakes Sample App
//
//  Copyright © 2016 Ali Afghah. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityView: UIActivityIndicatorView!
    
    var earthquakesArray = [[String:AnyObject]]() // array of dictionary to contain retrieved data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prevent the table to show before loading data
        self.activityView.alpha = 1
        self.tableView.alpha = 0
        
        // connect to API
        Alamofire.request(.GET, "http://api.geonames.org/earthquakesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&username=m_mirhoseini").responseJSON { (responseData) -> Void in
            
            // if no errors occured while receiving data
            if((responseData.result.value) != nil) {
                let swiftyJSONData = JSON(responseData.result.value!)
                
                // add the received data to our object
                if let recievedData = swiftyJSONData["earthquakes"].arrayObject {
                    self.earthquakesArray = recievedData as! [[String:AnyObject]]
                }
                
                // load the table if there are items
                if self.earthquakesArray.count > 0 {
                    self.activityView.alpha = 0
                    self.tableView.alpha = 1
                    self.tableView.reloadData()
                    
                    // send the data to the mapview
                    let barViewControllers = self.tabBarController?.viewControllers
                    let MapVC = barViewControllers![1] as! MapViewController
                    MapVC.earthquakesArray = self.earthquakesArray
                }
            }
        }
        
        // registering custom cell
        let nib = UINib(nibName: "TableCellView", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "customCell")
        

    }

    // number of rows in the table should be equal to number of items
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earthquakesArray.count
    }
    
    // cell height
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : ListTableCell = self.tableView.dequeueReusableCellWithIdentifier("customCell") as! ListTableCell

        // get data from array dictionary using row index
        var earthquakeAtRow = earthquakesArray[indexPath.row]

        // populate the cells with the data
        // first with the ID
        cell.eqid.text = earthquakeAtRow["eqid"] as? String

        // then with the source, unsing only one flag here since the data only has one source
        cell.src.text = earthquakeAtRow["src"] as? String
        
        // the depth is a double - making sure it has only two decimal points
        cell.depth.text = String((earthquakeAtRow["depth"] as! Double * 100.0) / 100.0)

        // just like depth magnitude is a double
        cell.magnitude.text = String((earthquakeAtRow["magnitude"] as! Double * 100.0) / 100.0)

        // reformatting the date to a more readable one
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss'"
        let date = formatter.dateFromString(earthquakeAtRow["datetime"] as! String)
        let outputFormat = NSDateFormatter.dateFormatFromTemplate("MMMM, d yyyy  hh:mm a", options: 0, locale: NSLocale(localeIdentifier: "en-US"))
        formatter.dateFormat = outputFormat
        let finalDate = formatter.stringFromDate(date!)
        cell.date.text = finalDate
        
        // scale the magnitude image based on its number
        let magnitudeDouble = Double(earthquakeAtRow["magnitude"] as! Double)
        
        let scaleBasedOnMagnitude = CGFloat(magnitudeDouble / 14.0)
        cell.magImage.transform = CGAffineTransformMakeScale(scaleBasedOnMagnitude, scaleBasedOnMagnitude)
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

