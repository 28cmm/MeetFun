import SwiftUI
import JGProgressHUD_SwiftUI

struct TabBarView: View {
    @State var selectedTab = "house"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    init() {
        FireBase.shared.fetchCurrentUser()
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            TabView(selection: $selectedTab){
                NavigationLazyView(HomePageView())
                    .tag("house")
                
                NavigationLazyView(AddEventView())
                    .tag("plus.rectangle.fill")
                
                NavigationLazyView(MessageView())
                    .tag("message.fill")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            // for bottom overflow..
            HStack(spacing:0){
                ForEach(tabs, id:\.self){image in
                    TabButton(image: image, selectedTab: $selectedTab)
                    //equal spacing ..
                    if image != tabs.last{
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal,25)
            .padding(.vertical,5)
            .background(Color.white)
            .clipShape(Capsule())
            .normalShadow()
            .padding(.horizontal)
            //for smaller iphones ..
            //
            .padding(.bottom,edge!.bottom == 0 ? 20 : 0)
            
            
            //ignoring tabview leevation
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        //            .navigationTitle("")
        //            .navigationBarTitleDisplayMode(.inline)
        //            .navigationBarHidden(true)
        //        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}


//Custoum Button Style
var tabs = ["house","plus.rectangle.fill", "message.fill"]

struct TabButton: View {
    var image : String
    @Binding var selectedTab : String
    var body: some View{
        Button(action: {selectedTab = image}, label: {
            Image(systemName: image)
                .renderingMode(.template)
                .foregroundColor(selectedTab == image ? Color.black.opacity(0.8) : Color.black.opacity(0.4))
                .padding()
        })
    }
}



struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
