//
//  ProspectView.swift
//  Hot Prospects
//
//  Created by Yash Poojary on 03/12/21.
//
import SwiftUI
import CodeScanner
import UserNotifications


struct ProspectView: View {
    
    enum FilterType {
       case none, contacted, uncontacted
    }
    
    var filter: FilterType
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var showActionSheet = false
    
    var filteredList: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter {
                $0.contacted
            }
        case .uncontacted:
            return prospects.people.filter {
                !$0.contacted
            }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted"
        case .uncontacted:
            return "Uncontacted"
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(filteredList) { prospect in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(prospect.name)
                                    .font(.headline)
                                Text(prospect.emailID)
                                    .foregroundColor(Color.secondary)
                            }
                            Spacer()
                            
                            if prospect.contacted {
                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                            }
                        }
                      
                        .contextMenu {
                            Button(prospect.contacted ? "Mark Uncontacted": "Mark Contacted") {
                                prospects.toggle(prospect)
                            }
                            if !prospect.contacted {
                                Button("Remind Me") {
                                    addNotification(for: prospect)
                                }
                            }
                        }
                         
                        
                    }
                }
            }
            .onAppear {
                prospects.loadData()
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Divya\nkhush@yash.com", completion: handleScan)
            }
             
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                           isShowingScanner = true
                        }) {
                           Image(systemName: "qrcode.viewfinder")
                        }
                    }
                
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Sort") {
                            showActionSheet = true
                        }
                        .actionSheet(isPresented: $showActionSheet) {
                            ActionSheet(title: Text("Sort the entries"), buttons: [
                                .default(Text("By name")) {
                                    prospects.people.sort()
                                },
                                .default(Text("By most recent")) {
                                    prospects.people.sort(by: {
                                        $0.created > $1.created
                                    })
                                }
                                
                            ])
                            
                        }
                    }
                }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else {
                return
            }
            
            let person = Prospect()
            person.name = details[0]
            person.emailID = details[1]
            
            prospects.add(person)
            
        case .failure(let error):
            print(error.localizedDescription)
            
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailID
            content.sound = UNNotificationSound.default
            
           
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.badge, .alert, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Doh")
                    }
                }
            }
        }
        
    }
}
//
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//
//
//
//    func saveData() {
//        do {
//            let filename = getDocumentsDirectory().appendingPathComponent("savedata.txt")
//            let data = try JSONEncoder().encode(prospects.people)
//            try data.write(to: filename, options: [.atomic, .completeFileProtection])
//        } catch {
//            print("Unable to save data")
//        }
//
//    }
//
//    func loadData() {
//        let filename = getDocumentsDirectory().appendingPathComponent("savedata.txt")
//
//        do {
//            let data = try Data(contentsOf: filename)
//            prospects.people = try JSONDecoder().decode([Prospect].self, from: data)
//
//        } catch {
//            print("Unable to load data")
//        }
//    }




struct ProspectView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectView(filter: .none)
    }
}
