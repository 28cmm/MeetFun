//
//  ContentView.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-07.
//

import SwiftUI
import Firebase
import JGProgressHUD_SwiftUI

struct HomePageView: View {
    //FireBase.shared.addEvent()
    @ObservedObject private var vm = FireBase()
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    @EnvironmentObject var hudCoordinator: JGProgressHUDCoordinator
    init(){
        self.vm.fetchEvent()
        //self.vm.fetchUser()
        
    }
    var body: some View {
        VStack{
            let events = vm.events
            //top selection
            HStack{
                Spacer()
                Image("m1")
                    .normalImage()
                    .foregroundColor(Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
                    .frame(width:HEIGHTSPACE*4, height:HEIGHTSPACE*4)
                Button("Refresh"){
                    hudCoordinator.showHUD {
                        let hud = JGProgressHUD()
                        hud.textLabel.text = "Refreshing"
                        hud.dismiss(afterDelay: 1)
                        return hud
                    }
                    vm.fetchEvent()
                }
                .font(.system(size: 15, weight: .bold))
                .padding()
                .background(Color(#colorLiteral(red: 0.3513801396, green: 0.7654538751, blue: 0.1472723484, alpha: 1)))
                .foregroundColor(.white)
                .cornerRadius(10)
                .normalShadow()
                .padding(.horizontal)
            }
            //box for view
            ScrollView(showsIndicators:false){
                ForEach(events, id:\.self){ event in
                    NavigationLink(destination: NavigationLazyView(HomeDetailView(event: event)), label: {
                        HomeBox(event: event)
                    })
                }
                .padding(.bottom,edge!.bottom + HEIGHTSPACE10)
            }
           
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        
        
    }
    
}

struct HomeBox: View{
    let vm = FireBase()
    let event: Event
    @State var user:User?
    init(event:Event) {
        self.event = event
    }

    var body: some View{
        VStack(alignment: .leading){
            HStack{
               
                // let i = event.time.map{formatter.string(from: $0)}
                let dateString = event.time!.dateValue()
                let result = toDateString(date: dateString)
                // print(result)
                Text("Happening \(result)")
                    .normalText()
                Spacer()
            }
            .padding(.vertical)
            Text(event.title!)
                .normalText()
            HStack{
                let num = String(format: "%.0f", event.numberOfPpl!)
                Text("\(num) going")
                    .padding(.trailing)
                Text("Hosted by \(event.createdByName ?? "N/A")")
            }
            .normalText()  
        }
        .padding()
        .background(Color.white)
        .cornerRadius(5)
        .normalShadow()
        .padding()
        
    }
}

//convert date formate
func toDateString(date:Date) -> String
{
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "MMM d"
    //            "E, d MMM yyyy HH:mm:ss Z"
    return inputFormatter.string(from: date)
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
