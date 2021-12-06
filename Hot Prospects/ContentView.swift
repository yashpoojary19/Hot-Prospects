//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Yash Poojary on 02/12/21.
//

import SwiftUI
import SamplePackage


struct ContentView: View { 
    
    var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            
            ProspectView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
                    
                }
            
            ProspectView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.circle")
                    Text("Uncontacted")
                    
                }
            
            
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("You")
                    
                }
        }
        .environmentObject(prospects)
        .onAppear {
                    if #available(iOS 15.0, *) {
                        let appearance = UITabBarAppearance()
                        UITabBar.appearance().scrollEdgeAppearance = appearance
                    }
                }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





//struct ContentView: View {
//
//
//    var body: some View {
//        VStack {
//            Button("Ask Permission") {
//
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        print("All set!")
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                        }
//                    }
//            }
//
//
//            Button("Send Notifications") {
//                let content = UNMutableNotificationContent()
//                content.title = "Feed the cat"
//                content.subtitle = "It looks hungry"
//                content.sound = UNNotificationSound.default
//
//                // show this notification five seconds from now
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//                // choose a random identifier
//                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                // add our notification request
//                UNUserNotificationCenter.current().add(request)
//            }
//        }
//    }
//}




//
//
//import SamplePackage
//import SwiftUI
//
//
//struct ContentView: View {
//
//    let possibleNumbers = Array(1...60)
//
//    var results: String {
//        let selected = possibleNumbers.random(7).sorted()
//        let strings = selected.map(String.init)
//        return strings.joined(separator: ", ")
//    }
//
//
//    var body: some View {
//        Text(results)
//    }
//}

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Button("Request Permission") {
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        print("All set")
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//
//             Button("Schedule Notification") {
//
//                let content = UNMutableNotificationContent()
//                content.title = "Feed the cats"
//                content.subtitle = "They seem hungry"
//                content.sound = UNNotificationSound.default
//
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                    UNUserNotificationCenter.current().add(request)
//
//                }
//            }
//        }
//    }


// struct ContentView: View {
//    @State private var color = Color.red
//
//    var body: some View {
//        VStack {
//            Text("Hello World")
//                .padding()
//                .background(color)
//
//            Text("Change Color")
//                .contextMenu {
//                    Button(action: {
//                        color = .green
//                    }) {
//                        Image(systemName: "star.fill    ")
//                        Text("Green")
//                    }
//
//                    Button(action: {
//                        color = .orange
//                    }) {
//                        Text("Orange")
//                    }
//
//                    Button(action: {
//                        color = .pink
//                    }) {
//                        Text("Pink")
//                    }
//                }
//
//        }
//    }
//}


// struct ContentView: View {
//    var body: some View {
//        Image("example")
//            .resizable()
//            .scaledToFit()
//            .frame(maxHeight: .infinity)
//            .edgesIgnoringSafeArea(.all)
//            .background(Color.black)
//
//    }
//}
//


//class DelayedUpdater: ObservableObject {
//    var value = 0 {
//        willSet {
//            objectWillChange.send()
//        }
//    }
//
//    init() {
//        for i in 1...5 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
//                self.value += 1
//            }
//        }
//    }
//}
//
//
//struct ContentView: View {
//    @ObservedObject var delayedUpdater = DelayedUpdater()
//
//
//    var body: some View {
//        Text("Value is \(delayedUpdater.value)")
//    }
//}



//
//enum NetworkError: Error {
//    case badURL, failed, unknown
//}
//
//struct ContentView: View {
//    var body: some View {
//        Text("Hello World")
//            .onAppear {
//                fetchData(url: "https://apple.com") { result in
//                switch result {
//                case .success(let str):
//                        print(str)
//                case .failure(let error):
//
//                switch error {
//                    case .badURL:
//                            print("Bad URL")
//                    case .failed:
//                            print("Failed")
//                    case .unknown:
//                            print("Unkown error")
//                        }
//                    }
//                }
//            }
//    }
//
//    func fetchData(url urlString: String, completion:  @escaping (Result<String, NetworkError>) -> Void) {
//
//        guard let url = URL(string: urlString) else {
//            completion(.failure(.badURL))
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                let stringData = String(decoding: data, as: UTF8.self)
//                completion(.success(stringData))
//            } else if error != nil {
//                completion(.failure(.failed))
//            } else {
//                completion(.failure(.unknown))
//            }
//        }.resume()
//
//
//    }
//}

//
//struct ContentView: View {
//
//    @State private var selectedTab = 0
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            Text("Tab 1")
//                .onTapGesture {
//                    selectedTab = 1
//                }
//                .tabItem {
//                    Text("One")
//                    Image(systemName: "star")
//                }
//
//
//            Text("Tab 2")
//                .tabItem {
//                    Text("Two")
//                    Image(systemName: "star")
//                }
//                .tag(1)
//        }
//        .onAppear {
//            if #available(iOS 15.0, *) {
//                let appearance = UITabBarAppearance()
//                UITabBar.appearance().scrollEdgeAppearance = appearance
//            }
//        }
//    }
//}

//class User: ObservableObject {
//    @Published var name = "Taylor Swift"
//}
//
//
//struct EditView: View {
//    @EnvironmentObject var user: User
//
//    var body: some View {
//        TextField("Name", text: $user.name)
//    }
//}
//
//struct DisplayView: View {
//    @EnvironmentObject var user: User
//
//    var body: some View {
//        Text(user.name)
//    }
//}
//
//struct ContentView: View {
//    let user = User()
//
//
//    var body: some View {
//        VStack {
//            EditView().environmentObject(user)
//            DisplayView().environmentObject(user)
//        }
//    }
//}
