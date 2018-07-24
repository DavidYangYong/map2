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
        mapView?.addSubview(txtViewShow)
        //获取textView的所有文本，转成可变的文本
        self.view.addSubview(mapView!)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var txtViewShow: UITextView!
    @IBOutlet weak var btnOp: UIButton!
    @IBOutlet weak var label: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        //地图中心点坐标
        let center = CLLocationCoordinate2D(latitude: 31.245087, longitude: 121.506656)
        //设置地图的显示范围（越小越精确）
        let span = BMKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        //设置地图最终显示区域
        let region = BMKCoordinateRegion(center: center, span: span)
        mapView?.region = region
        
        // 添加一个标记点(PointAnnotation）
        let annotation =  BMKPointAnnotation()
        var coor = CLLocationCoordinate2D()
        coor.latitude = 31.254087
        coor.longitude = 121.512656
        annotation.coordinate = coor
        annotation.title = "这里有只野生皮卡丘"
        mapView!.addAnnotation(annotation)
    }
    @IBAction func btnShow(_ sender: UIButton, forEvent event: UIEvent) {
        manager.getLocation(success: { (str) in
            self.label.text = str
            self.txtViewShow.text = str
        }) { (err) in
            
            self.label.text = err
        }
        //  reverseGeocode()
        //        LocationManager.shareManager.creatLocationManager().startLocation { (location, adress, error) in
        //            print("经度 \(location?.coordinate.longitude ?? 0.0)")
        //            print("纬度 \(location?.coordinate.latitude ?? 0.0)")
        //            print("地址\(adress ?? "")")
        //            print("error\(error ?? "没有错误")")
        //        }
    }
    
    //地理信息反编码
    func reverseGeocode(){
        let geocoder = CLGeocoder()
        let currentLocation = CLLocation(latitude: 37.33233141, longitude: -122.0312186)
        //  let currentLocation = CLLocation(latitude: 32.029171, longitude: 118.788231)
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            //强制转成简体中文
            let array = NSArray(object: "zh-hans")
            UserDefaults.standard.set(array, forKey: "AppleLanguages")
            //显示所有信息
            if error != nil {
                //print("错误：\(error.localizedDescription))")
                self.label.text = "错误：\(error!.localizedDescription))"
                return
            }
            
            if let p = placemarks?[0]{
                print("输出反编码信息:")
                print(p) //输出反编码信息
                var address = ""
                
                if let country = p.country {
                    address.append("国家：\(country)\n")
                }
                if let administrativeArea = p.administrativeArea {
                    address.append("省份：\(administrativeArea)\n")
                }
                if let subAdministrativeArea = p.subAdministrativeArea {
                    address.append("其他行政区域信息（自治区等）：\(subAdministrativeArea)\n")
                }
                if let locality = p.locality {
                    address.append("城市：\(locality)\n")
                }
                if let subLocality = p.subLocality {
                    address.append("区划：\(subLocality)\n")
                }
                if let thoroughfare = p.thoroughfare {
                    address.append("街道：\(thoroughfare)\n")
                }
                if let subThoroughfare = p.subThoroughfare {
                    address.append("门牌：\(subThoroughfare)\n")
                }
                if let name = p.name {
                    address.append("地名：\(name)\n")
                }
                if let isoCountryCode = p.isoCountryCode {
                    address.append("国家编码：\(isoCountryCode)\n")
                }
                if let postalCode = p.postalCode {
                    address.append("邮编：\(postalCode)\n")
                }
                if let areasOfInterest = p.areasOfInterest {
                    address.append("关联的或利益相关的地标：\(areasOfInterest)\n")
                }
                if let ocean = p.ocean {
                    address.append("海洋：\(ocean)\n")
                }
                if let inlandWater = p.inlandWater {
                    address.append("水源，湖泊：\(inlandWater)\n")
                }
                
                self.txtViewShow.text = address
            } else {
                print("No placemarks!")
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }  
}

