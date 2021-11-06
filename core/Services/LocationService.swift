//
//	LocationService.swift
//	core
//
//	Created by Doan Duy Phuong on 06/11/2021.
//	
//	

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func locationManagerDidFetchLocation(_ location: CLLocation)
    func locationServiceDidChangeAuthorization(status: CLAuthorizationStatus)
}

class LocationService: NSObject {
    
    static let shared: LocationService = {
       let manager = LocationService()
        manager.locationManager.delegate = manager
        return manager
    }()
    
    private var locationManager: CLLocationManager
    weak var delegate: LocationServiceDelegate?
    
    override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func startGettingLocation() {
        locationManager.startUpdatingLocation()
    }

    func requestLocationService() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation() -> CLLocation? {
        if let currentLocation = UserDefaults.standard.object(forKey: "currentLocation") as? [String: NSNumber],
           let lat = currentLocation["lat"],
           let long = currentLocation["long"]  {
            return CLLocation.init(latitude: CLLocationDegrees(truncating: lat), longitude: CLLocationDegrees(truncating: long))
        }
        return nil
    }
    
    func getCurrentAddressString() -> String? {
        if let currentAddresStr = UserDefaults.standard.object(forKey: "currentAddress") as? String , currentAddresStr.count > 0{
            return currentAddresStr
        }
        return nil
    }

    var locationServiceEnabled: Bool {
        return CLLocationManager.locationServicesEnabled()
    }

    var isReady: Bool {
        let status = CLLocationManager.authorizationStatus()
        guard CLLocationManager.locationServicesEnabled() else { return false }
        return status == .authorizedAlways || status == .authorizedWhenInUse
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            let location = locations[0]
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            let currentLocationInfo: [String:NSNumber] = ["lat":lat as NSNumber,
                                                          "long": long as NSNumber]
            locationManager.stopUpdatingLocation()
            UserDefaults.standard.set(currentLocationInfo,
                                      forKey: "currentLocation")
            UserDefaults.standard.synchronize()
            delegate?.locationManagerDidFetchLocation(locations[0])
            CLGeocoder().reverseGeocodeLocation(location) { (placeMarks, error) in
                if let placeMarks = placeMarks, placeMarks.count > 0 {
                    let placeMark = placeMarks[0]
                    var subThoroughfareStr: String = ""
                    var thoroughfareStr: String = ""
                    var subLocalityStr: String = ""
                    var subAdministrativeAreaStr: String = ""
                    var administrativeAreaStr: String = ""
                    var fullAddressStr: String = ""
                    if let subThoroughfare = placeMark.subThoroughfare, subThoroughfare.count > 0 {
                        subThoroughfareStr = subThoroughfare + ", "
                    }
                    if let thoroughfare = placeMark.thoroughfare, thoroughfare.count > 0 {
                        thoroughfareStr = thoroughfare + ", "
                    }
                    if let subLocality = placeMark.subLocality, subLocality.count > 0 {
                        subLocalityStr = subLocality + ", "
                    }
                    if let subAdministrativeArea = placeMark.subAdministrativeArea, subAdministrativeArea.count > 0 {
                        subAdministrativeAreaStr = subAdministrativeArea + ", "
                    }
                    if let administrativeArea = placeMark.administrativeArea, administrativeArea.count > 0 {
                        administrativeAreaStr = administrativeArea
                    }
                    fullAddressStr = subThoroughfareStr + thoroughfareStr + subLocalityStr + subAdministrativeAreaStr + administrativeAreaStr
                    UserDefaults.standard.set(fullAddressStr, forKey: "currentAddress")
                    UserDefaults.standard.synchronize()
                    debugPrint(">>>",fullAddressStr)
                }
            }
        }
        else {
            debugPrint("Get location fail")
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization")
        delegate?.locationServiceDidChangeAuthorization(status: status)
    }
}
