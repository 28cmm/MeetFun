//
//  MessageInnerView.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-10.
//

import SwiftUI
import Firebase
import JGProgressHUD_SwiftUI
struct MessageInnerView: View {
    @State var messages = [Message]()
    var myMessageUid:String!
    @State var didShow = false
    @State var messageListener:ListenerRegistration!
    @State var text = ""
    @EnvironmentObject var hudCoordinator: JGProgressHUDCoordinator
    var chatName = ""
    var valueCount:Int = 0
    init(messageUid:String, name:String) {
        myMessageUid = messageUid
        valueCount = messages.count
        chatName = name
        
    }
   
    var body: some View {
        VStack{
            //text for view
            ScrollView(.vertical, showsIndicators:false){
                ScrollViewReader{ value in
                    ForEach(messages, id:\.self){ message in
                        if message.sendUid == FireBase.shared.userId{
                            HStack{
                                Spacer()
                                Text(message.message!)
                                    .padding()
                                    .background(Color(#colorLiteral(red: 0.6295449138, green: 0.9130322337, blue: 0.4842677116, alpha: 1)))
                                    .padding()
                                
                            }
                        }else{
                            HStack{
                                Text(message.message!)
                                    .padding()
                                    .background(Color.discoverBackground)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
        
                }
   
            }
            Spacer()
            VStack{
                Spacer()
                    .frame(width:UIScreen.main.bounds.width,height: 1)
                    .background(Color.discoverBackground)
                HStack(alignment:.center){
                    TextField("Send...", text: $text)
                        .padding()
                        .background(Color.discoverBackground)
                        .padding()
                    Button("Send"){
                        if !text.isEmpty{
                            hudCoordinator.showHUD {
                                let hud = JGProgressHUD()
                                hud.textLabel.text = "Sending"
                                hud.dismiss(afterDelay: 1)
                                return hud
                            }
                            FireBase.shared.addMessage(message: ["message":text], sendToUid: myMessageUid) {
                                
                            }
                        }
                        
                    }
                    .font(.system(size:15, weight:.bold))
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(#colorLiteral(red: 0.3513801396, green: 0.7654538751, blue: 0.1472723484, alpha: 1)))
                }
            }
           
           
        }
        .background(Color.white)
        .navigationTitle("\(chatName)")
//        .edgesIgnoringSafeArea(.all)
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear{
            getMesssge()
            //            fetchMessage(otherGuysUid: myEvent.createdByUid!)
            
        }.onDisappear{
            messageListener.remove()
            //            self.didDisapper = true
        }
    }
    
    func getMesssge(){
        messageListener = Firestore.firestore().collection(USER).document(FireBase.shared.userId).collection(MESSAGES).document(myMessageUid).collection(MESSAGE).order(by: "time", descending: false).addSnapshotListener { (snapShot, err) in
            if let err = err{
                debugPrint(err.localizedDescription)
                return
            }
            var resultMesage = [Message]()
            snapShot?.documents.forEach({ (snapShot) in
                let data = snapShot.data()
                let message = Message(dictionary: data)
                resultMesage.append(message)
            })
            print("successful fetched message once")
            self.messages = resultMesage
        }
    }
    
}

