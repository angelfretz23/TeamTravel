//
//  LocalLocationTableViewCell.swift
//  TeamTravel
//
//  Created by Justin Carver on 11/3/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import UIKit
import MapKit

class LocalLocationTableViewCell: UITableViewCell {

    @IBOutlet var locationName: UILabel!
    @IBOutlet var locationDistance: UILabel!
    @IBOutlet var typeImageView: UIImageView!
    
    func updateCellWithLocation(location: Location, and distance: Int) {
        locationName.text = location.locationName
        locationDistance.text = "Type: \(location.type) \nDistance: \(distance) meters"
        switch location.type {
        case LocationType.Landmarks:
            break
        case LocationType.Museums:
            break
        case LocationType.Parks:
            break
        }
    }
}
