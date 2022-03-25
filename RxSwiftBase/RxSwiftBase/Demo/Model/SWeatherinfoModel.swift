//
//  SWeatherinfoModel.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/25.
//

import Foundation
import SwiftyJSON

class SWeatherinfoModel: SMappable {
    var weatherinfo: SWeatherinfo?

    required init(json: JSON) {
        weatherinfo = SWeatherinfo(json: json["weatherinfo"])
    }
}

class SWeatherinfo: SMappable {
    var AP: String?
    var city: String?
    var cityid: String?
    var isRadar: String?
    var njd: String?
    var Radar: String?
    var SD: String?
    var sm: String?
    var temp: String?
    var time: String?
    var WD: String?
    var WS: String?
    var WSE: String?

    required init(json: JSON) {
        AP = json["AP"].stringValue
        city = json["city"].stringValue
        cityid = json["cityid"].stringValue
        isRadar = json["isRadar"].stringValue
        njd = json["njd"].stringValue
        Radar = json["Radar"].stringValue
        SD = json["SD"].stringValue
        sm = json["sm"].stringValue
        temp = json["temp"].stringValue
        time = json["time"].stringValue
        WD = json["WD"].stringValue
        WS = json["WS"].stringValue
        WSE = json["WSE"].stringValue
    }
}
