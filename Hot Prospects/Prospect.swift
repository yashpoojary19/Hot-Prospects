//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Yash Poojary on 03/12/21.
//

import SwiftUI



class Prospect: Codable, Identifiable, Comparable {
   
    
   
    var id = UUID()
    var name = "Anon"
    var emailID = ""
    var created = Date()
    
    fileprivate(set) var contacted = false
    
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.id == rhs.id
    }
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    static let key = "SavedData"
    
    
    init() {
        people = []
    }
    
    
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.contacted.toggle()
        saveData()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        saveData()
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
  
    
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("savedata.txt")
            let data = try JSONEncoder().encode(people)
            try data.write(to: filename, options: [.atomic, .completeFileProtection])
            print("Able to save data")
        } catch {
            print("Unable to save data")
        }
        
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("savedata.txt")
        
        do {
            let data = try Data(contentsOf: filename)
            people = try JSONDecoder().decode([Prospect].self, from: data)
            print("Able to load data")
        } catch {
            print("Unable to load data")
        }
    }

    
}



