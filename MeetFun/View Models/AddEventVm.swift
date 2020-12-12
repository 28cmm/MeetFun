//
//  AddEventVm.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-08.
//

import Foundation
import Firebase

class AddEventVm: ObservableObject{
    var description:String = ""
    var location:String = ""
    var tittle:String = ""
    var time:Date = Date()
    @Published var pushActive = false
    
    func addEvent(completion:@escaping()->Void){
        
        let event:[String:Any] =  [
            "time":Timestamp(date: time),
            "title": self.tittle,
            "createdByUid":Auth.auth().currentUser?.uid,
            "description":self.description,
            "location":self.location,
            "numberOfPpl":1,
            "attendedUsers":[Auth.auth().currentUser?.uid],
            "createdByName":FireBase.shared.user?.userName]
        FireBase.shared.addEvent(data: event)
    
    }
}

