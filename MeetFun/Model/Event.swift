//
//  Event.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-07.
//

import Foundation
import Firebase

struct Event: Hashable{
    
    var time:Timestamp?
    var title,createdByUid,description,location,eventUid, createdByName:String?
    var latitude, longitude,numberOfPpl:Double?
    var attendedUsers:[String]?
    
    init(dictionary: [String:Any]) {
        self.time = dictionary["time"] as? Timestamp
        self.title = dictionary["title"] as? String
        self.createdByUid = dictionary["createdByUid"] as? String
        self.eventUid = dictionary["eventUid"] as? String
        self.description = dictionary["description"] as? String
        self.location = dictionary["location"] as? String
        self.latitude = dictionary["latitude"] as? Double
        self.longitude = dictionary["longitude"] as? Double
        self.numberOfPpl = dictionary["numberOfPpl"] as? Double
        self.attendedUsers = dictionary["attendedUsers"] as? [String]
        self.createdByName = dictionary["createdByName"] as? String
        
    }
}
