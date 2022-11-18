//
//  ProfileTableViewController.swift
//  Listener
//
//  Created by Dongpeng Dai on 2022/7/28.
//

import UIKit
import CoreLocation
import MapKit

class ProfileTableViewController: UITableViewController, CLLocationManagerDelegate {

    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.iconImage.layer.cornerRadius = 60
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let app = UIApplication.shared.delegate as! AppDelegate
        if let user = app.user{
            userEmail.text = user.email
            userName.text = user.name
        }
    }
    
    //CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            renderMap(location: location)
            self.manager.stopUpdatingLocation()
        }
    }
    
    func renderMap(location: CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    self.locationLabel.text = placemark.locality ?? "Not Found"
                }
            }
        }
    }

    @IBAction func logout(_ sender: Any) {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.isLogin = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: LogoutNoti), object: nil)
    }
}
