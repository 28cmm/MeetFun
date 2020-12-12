//
//  HomeDetailView.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-09.
//

import SwiftUI
import JGProgressHUD_SwiftUI

struct HomeDetailView:View{
    var event:Event
    var vm = FireBase()
    @State var isActive = false
    @EnvironmentObject var hudCoordinator: JGProgressHUDCoordinator
    
    var body: some View{
        VStack(alignment:.leading){
            Text(event.title ?? "No title")
                .padding()
                .font(.system(size:30, weight: .bold))
            Divider()
            Text("Location: \(event.location ?? "To Be Announced")")
                .padding()
                .normalText()
            Text("\(Int(event.numberOfPpl ?? 1)) people are going !")
                .padding(.horizontal)
                .padding(.bottom)
            ZStack(alignment: .topLeading){
                Spacer()
                    .frame(width:WIDTHSPACE*10, height: HEIGHTSPACE10*3)
                    .background(Color.discoverBackground)
                    .normalShadow()
                    .cornerRadius(HEIGHTSPACE)
                    .padding()
                VStack{
                    Text(event.description ?? "no description")
                        .normalText()
                        .multilineTextAlignment(.leading)
                        .padding()
                    Spacer()
                }
                
               
            }
            //.padding()
            Spacer()
            HStack{
                Spacer()
                Button("Join"){
                    if event.attendedUsers?.contains(FireBase.shared.userId) == true{
                        hudCoordinator.showHUD {
                            let hud = JGProgressHUD()
                            hud.textLabel.text = "You already Joined"
                            hud.dismiss(afterDelay: 1)
                            return hud
                        }
                    }else{
                        hudCoordinator.showHUD {
                            let hud = JGProgressHUD()
                            hud.textLabel.text = "Joining"
                            hud.dismiss(afterDelay: 1)
                            return hud
                        }
                        var updatedEvent = event.attendedUsers
                        updatedEvent?.append(vm.userId ?? "No Id")
                        let updatedNumppl = event.numberOfPpl
                        vm.updateEvent(event: ["attendedUsers":updatedEvent, "numberOfPpl":updatedNumppl!+1], eventUid: event.eventUid ?? "")
                    }
                    
                }
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
                .padding()
                .background(Color(#colorLiteral(red: 0.3513801396, green: 0.7654538751, blue: 0.1472723484, alpha: 1)))
                .cornerRadius(20)
                .normalShadow()
                
                Spacer()
            }
            
        }
        .padding()
        .navigationTitle(event.title ?? "No title")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            vm.addFirstMessage(message: ["message":"interested in your event"], sendToUid: event.createdByUid!) {
                self.isActive = true
            }
        }, label: {
            Image(systemName: "message.fill")
                           .renderingMode(.template)
                           .foregroundColor(.gray)
        }))
        NavigationLink(destination: NavigationLazyView(MessageInnerView(messageUid: event.createdByUid!, name: event.createdByName!)), isActive: $isActive){EmptyView()}
                                
                                
//                                Button(action: {NavigationLink}, label: {
//            Image(systemName: "message.fill")
//                .renderingMode(.template)
//                .foregroundColor(.gray)
//        })
        
//                                NavigationLink(destination: MessageInnerView(), label: {
//                                    Image(systemName: "message.fill")
//                                                    .renderingMode(.template)
//                                                    .foregroundColor(.gray)
//                                })
        

    }
}


