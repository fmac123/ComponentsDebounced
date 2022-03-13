//
//  DatePickerDebounced.swift
//  testest
//
//  Created by Fraser Macaulay on 5/3/2022.
//

import SwiftUI

class TimeSelected: ObservableObject {
    
//    @Published var currentTime = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
//    @State var currentTime = Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date())!
    @Published var currentTime = Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date()) ?? Date()
    @Published private(set) var debounced = Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date()) ?? Date()
    
    init() {
        $currentTime
            .dropFirst()
            .debounce(for: 10, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .assign(to: &$debounced)
    }
    
}

//prints out the first two time init
struct DatePickerDebounced: View {
    
    @StateObject var timeSelected = TimeSelected()
    
    var body: some View {
        
        Form {
            HStack {
                Image(systemName: "clock").foregroundColor(.accentColor)
                Text("Notification Time")
                Spacer()
                
                DatePicker("Notification Time", selection: $timeSelected.currentTime, displayedComponents: [.hourAndMinute])
                    .labelsHidden()
                    .onReceive(timeSelected.$debounced.dropFirst()) { time in
                        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
                        print(dateComponents)
                    }
            }
            

        }
        
    }

}
