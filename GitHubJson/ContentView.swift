
import Alamofire
import SDWebImageSwiftUI
import SwiftUI
import SwiftyJSON

struct ContentView: View {
    
    @ObservedObject var obs = observer()
    
    var body: some View {
        NavigationView{
            List(obs.datas){ i in
                card(name: i.login, url: i.avatar_url)
           
            
            }.navigationBarTitle("GitHub Users")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class observer: ObservableObject{
    
    @Published var datas = [datatypes]()
    
    init(){
        
        AF.request("https://api.github.com/users").responseData{ (data) in
            
            let json = try! JSON(data: data.data!)
            
            for i in json{
                self.datas.append(datatypes(id: i.1["id"].intValue, login: i.1["login"].stringValue, avatar_url: i.1["avatar_url"].stringValue))
            }
        }
    }
    
}

struct datatypes: Identifiable{
    
    var id: Int
    var login: String
    var avatar_url: String
    

}

struct card: View{
    
    var name = ""
    var url = ""
    var html_url = ""
    
    var body: some View{
        HStack{
            
            AnimatedImage(url: URL(string: url)!).resizable().frame(width: 60, height: 60).clipShape(Circle()).shadow(radius: 20)
            VStack{
                Text(name).font(.title)
               
            }
            
        }
    }
}
