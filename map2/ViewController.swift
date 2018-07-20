//
//  ViewController.swift
//  map2
//
//  Created by david on 2017/3/8.
//  Copyright © 2017年 david. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
var mapView: BMKMapView?
    var manager: LAXLocationManager = LAXLocationManager.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = BMKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        mapView?.showsUserLocation=true
        mapView?.addSubview(label)
        mapView?.addSubview(btnOp)
        self.view.addSubview(mapView!)
        // Do any additional setup after loading the view, typically from a nib.
        //设置起始中心点
        let center = CLLocationCoordinate2D(latitude: 31.272881101147327, longitude: 121.61539365113157)
        mapView?.centerCoordinate = center
        //设置区域
        let span = BMKCoordinateSpanMake(0.011929035022411938, 0.0078062748817018246)
        let region = BMKCoordinateRegionMake(center, span)
        mapView?.setRegion(region, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var btnOp: UIButton!
    @IBOutlet weak var label: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  mapView?.viewWillAppear()
      //  mapView?.delegate = self as! BMKMapViewDelegate // 此处记得不用的时候需要置nil，否则影响内存的释放
    }
    @IBAction func btnShow(_ sender: UIButton, forEvent event: UIEvent) {
        manager.getLocation(success: { (str) in
            self.label.text = str
        }) { (err) in
            self.label.text = err
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
     //   mapView?.viewWillDisappear()
       // mapView?.delegate = nil // 不用时，置nil
    }  
}

