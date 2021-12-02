//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Yash Poojary on 02/12/21.
//

import SwiftUI


//non blocking functions


enum NetworkError: Error {
    case badURL, requestFailed, unknown
}






struct ContentView: View {
    var body: some View {
        Text("Hello World!")
            .onAppear {
                fetchData(from: "https://apple.com") { result in
                    switch result {
                    case .success(let str):
                        print(str)
                        case .failure(let error):
                        
                        switch error {
                            
                        case .badURL:
                            print("Bad URL")
                                    
                        case .requestFailed:
                            print("Network Problems")
                               
                        case .unknown:
                            print("Unkown Error")
                                }
                            }
                        }
                    }
                }
    
func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
    guard let url = URL(string: urlString) else {
        completion(.failure(.badURL))
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        DispatchQueue.main.async {
            if let data = data {
                let stringData = String(decoding: data, as: UTF8.self)
                completion(.success(stringData))
            } else if error != nil {
                completion(.failure(.requestFailed))
            } else {
                completion(.failure(.unknown))
            }
        }
    }
    .resume()
    
    
        DispatchQueue.main.async {
            completion(.failure(.badURL))
        }
            
    }
    
        }


    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



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
