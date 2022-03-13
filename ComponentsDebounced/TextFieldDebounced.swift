//
//  TimePicker.swift
//  MedTracker
//
//  Created by Fraser Macaulay on 5/3/2022.
//

import SwiftUI
import Combine

class SearchText: ObservableObject {
    
    @Published var text = ""
    @Published private(set) var debounced = ""
    
    init() {
        $text
            .debounce(for: 5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .assign(to: &$debounced)
    }
    
}

struct TextFieldDebounced: View {
    
    @StateObject var searchText = SearchText()
    
    //@State var currentTime = Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date())!
    
    var body: some View {
        TextField("Search plz", text: $searchText.text)
            .onReceive(searchText.$debounced) { query in
                print(query)
            }
    }
}
