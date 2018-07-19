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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = BMKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(mapView!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  mapView?.viewWillAppear()
      //  mapView?.delegate = self as! BMKMapViewDelegate // 此处记得不用的时候需要置nil，否则影响内存的释放
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
     //   mapView?.viewWillDisappear()
       // mapView?.delegate = nil // 不用时，置nil
    }  
}

