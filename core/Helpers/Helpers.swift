//
//  Helpers.swift
//  core
//
//  Created by Doan Duy Phuong on 28/09/2021.
//

import Foundation
import UIKit
import MapKit

final class Helpers {
    class func screenSize() -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    class func setAppLauched() {
        UserDefaults.standard.setValue(true, forKey: "isLauchedApp")
        UserDefaults.standard.synchronize()
    }
    
    static var isLauchedApp: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLauchedApp")
        }
    }

    class func openGoogleMapsFor(lat: Double, lng: Double, address: String) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:
                                            "comgooglemaps://?q=\(address.convertToQueryFormat())&center=\(lat),\(lng)&zoom=14&views=traffic")!,
                                      options: [:],
                                      completionHandler: nil)
        } else {
            let regionDistance: CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(lat, lng)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = address
            mapItem.openInMaps(launchOptions: options)
        }
    }
}
