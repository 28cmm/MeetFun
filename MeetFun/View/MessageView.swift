//
//  Message.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-08.
//

import SwiftUI
import JGProgressHUD_SwiftUI

struct MessageView: View {
    @ObservedObject var vm = FireBase()
    @State var didDisapper = false
    @State var didAppear = true
    @EnvironmentObject var hudCoordinator: JGProgressHUDCoordinator
    
    init() {
        vm.fetchUserMessage()
    }
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button("Refresh"){
                    hudCoordinator.showHUD {
                        let hud = JGProgressHUD()
                        hud.textLabel.text = "Refreshing"
                        hud.dismiss(afterDelay: 1)
                        return hud
                    }
                    vm.fetchUserMessage()
                }
                .font(.system(size: 15, weight: .bold))
                .padding()
                .background(Color(#colorLiteral(red: 0.3513801396, green: 0.7654538751, blue: 0.1472723484, alpha: 1)))
                .foregroundColor(.white)
                .cornerRadius(10)
                .normalShadow()
                .padding(.horizontal)
            }
            Spacer()
            ScrollView(.vertical){
                ForEach(vm.messageUser,id:\.self){ user in
                    NavigationLink(destination: NavigationLazyView(MessageInnerView(messageUid: user.uid!, name: user.userName!))) {
                        MessageBox(user: user)
                    }
                }
            }
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        
        
    }
    
}

struct MessageBox: View{
    let user: User
    var body: some View{
        HStack{
            Text(user.userName!)
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .normalShadow()
                .padding()
            
            Spacer()
        }
    }
}

struct Message_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
