//
//  Firebase.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-07.
//

import SwiftUI
import Firebase
import JGProgressHUD_SwiftUI

class FireBase:ObservableObject{
    static let shared = FireBase()
    @Published var events = [Event]()
    @Published var messages = [Message]()
    @Published var user:User?
    @Published var messageUser = [User]()
    
    @Published var isLoading = true
    let userId = Auth.auth().currentUser!.uid
    //@Published var resultEvents: Event
   
    @Published var isUpdated = true
    
    let firestore = Firestore.firestore()
    
    func addFirstMessage(message:[String:Any],sendToUid:String, completion:@escaping()->Void){
        var ref = firestore.collection(USER).document(userId).collection(MESSAGES).document(sendToUid)
        ref.getDocument { (snapShot, err) in
            if let err = err{
                debugPrint(err.localizedDescription)
            }else{
                if (snapShot?.exists) == true {
                    completion()
                }else{
                    let uselessData:[String:Any] = ["Please update this fire base" : Timestamp()]
                    ref.setData(uselessData)
                    ref = ref.collection(MESSAGE).document()
                    var data:[String:Any] = message
                    data["messageUid"] = ref.documentID
                    data["time"] = Timestamp()
                    data["sendUid"] = self.userId
                    data["receivedUid"] = sendToUid
                    self.isLoading = true
                    ref.setData(data){ (err) in
                        if let err = err{
                            self.isLoading = false
                            debugPrint("failed to send message, ",err.localizedDescription)
                            return
                        }
                        print("success add Meesage")
                        self.isLoading = false
                    }
                    
                    var ref2 = self.firestore.collection(USER).document(sendToUid).collection(MESSAGES).document(self.userId)
                    ref2.setData(uselessData)
                    ref2 = ref2.collection(MESSAGE).document()
                    var data2:[String:Any] = message
                    data2["messageUid"] = ref2.documentID
                    data2["sendByUid"] = sendToUid
                    data2["time"] = Timestamp()
                    data2["receivedByUid"] = self.userId
                    self.isLoading = true
                    ref2.setData(data2){ (err) in
                        if let err = err{
                            self.isLoading = false
                            debugPrint("failed to send message, ",err.localizedDescription)
                            return
                        }
                        print("success add Meesage2")
                        self.isLoading = false
                        completion()
                    }
                }
            }
        }
    }
    
    func addMessage(message:[String:Any],sendToUid:String, completion:@escaping()->Void){
        var ref = firestore.collection(USER).document(userId).collection(MESSAGES).document(sendToUid)
//        let uselessData:[String:Any] = ["Please update this fire base" : Timestamp()]
//        ref.setData(uselessData)
        ref = ref.collection(MESSAGE).document()
        var data:[String:Any] = message
        data["messageUid"] = ref.documentID
        data["time"] = Timestamp()
        data["sendUid"] = userId
        data["receivedUid"] = sendToUid
        isLoading = true
        ref.setData(data){ (err) in
            if let err = err{
                self.isLoading = false
                debugPrint("failed to send message, ",err.localizedDescription)
                return
            }
            print("success add Meesage")
            self.isLoading = false
        }
        
        var ref2 = firestore.collection(USER).document(sendToUid).collection(MESSAGES).document(userId)
//        ref2.setData(uselessData)
        ref2 = ref2.collection(MESSAGE).document()
        var data2:[String:Any] = message
        data2["messageUid"] = ref2.documentID
        data2["sendByUid"] = sendToUid
        data2["time"] = Timestamp()
        data2["receivedByUid"] = userId
        isLoading = true
        ref2.setData(data2){ (err) in
            if let err = err{
                self.isLoading = false
                debugPrint("failed to send message, ",err.localizedDescription)
                return
            }
            print("success add Meesage2")
            self.isLoading = false
            completion()
        }
    }
    
    func updateEvent(event:[String:Any],eventUid:String){
        let store = firestore.collection(GROUP).document(eventUid)
        store.updateData(event) { (err) in
            if let err = err{
                self.isUpdated = false
                debugPrint("there is a err updating: ",err.localizedDescription)
            }else{
                self.isUpdated = true
                print("success updatedEvent")
            }
        }
    }
    
    func addEvent(data:[String:Any]){
        let store = firestore.collection(GROUP).document()
        var data1:[String:Any] = data
        data1["eventUid"] = store.documentID
        isLoading = true
        store.setData(data1){ (err) in
            if let err = err{
                self.isLoading = false
                debugPrint("failed to setData, ",err.localizedDescription)
                return
            }
            print("success add event")
            self.isLoading = false
        }
    }
    
    func addUser(email:String, uid:String, name:String){
        let store = firestore.collection(USER).document(uid)
        store.setData([
            "uid":uid,
            "email":email,
            "timeCreated":Timestamp(date: Date()),
            "userName":name
            
        ]){ (err) in
            if let err = err{
                debugPrint("failed to setData, ",err.localizedDescription)
                return
            }
            print("success to add User")
            
        }
    }
    
    func fetchUserMessage(){
        Firestore.firestore().collection(USER).document(FireBase.shared.userId).collection(MESSAGES).getDocuments{ (snapShots, err) in
             if let err = err{
                 debugPrint(err.localizedDescription)
                 return
             }
//            print("data: is not ready, \(usersArray.count)")
//            print("# snapshots: \(snapShots?.documents.count) Users")
            snapShots?.documents.forEach({ (snapShot) in
                let useRef = Firestore.firestore().collection(USER).document(snapShot.documentID).getDocument(completion: { (snapShotzz, err) in
                    if let err = err{
                        debugPrint("this is a err ",err.localizedDescription)
                    }
                    let data = snapShotzz?.data()
                    let user = User(dictionary: data!)
                    print("\(user.userName) is ready ")
                    self.messageUser.append(user)
                })
                
            })

         }
    }
    
    func fetchCurrentUser(){
        let store = firestore.collection(USER).document(userId)
        store.getDocument { (snapShot, err) in
            if let err = err{
                debugPrint(err.localizedDescription)
                return
            }
            print("successfully fetch user")
            let data = snapShot?.data()
         //   completion(User(dictionary: data!))
            self.user = User(dictionary: data!)
        }
    }
    
    func fetchEvent(){
        let ref = firestore.collection(GROUP).whereField("time", isGreaterThan: Timestamp(date: Date()))
        .order(by: "time",descending: false).limit(to: 5)
        ref.getDocuments { (snapShots, err) in
            if let err = err{
                debugPrint("failed to fetchdata, ",err.localizedDescription)
                return
            }
            var resultEvents = [Event]()
            if ((snapShots?.isEmpty) != nil) {
                snapShots!.documents.forEach({ (snapShot) in
                    let data = snapShot.data()
                    let event = Event(dictionary: data)
                    resultEvents.append(event)
                })
                self.events = resultEvents
                print("there is #\(resultEvents.count) Events")
            }
        }
    }
}
