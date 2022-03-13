//
//  InLineWheelPicker.swift
//  ComponentsDebounced
//
//  Created by Fraser Macaulay on 6/3/2022.
//

import SwiftUI

struct InLineWheelPicker: View {
    
    @State var currentTime = Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date()) ?? Date()
    @State private var notificationOn = false
    @State private var isDatePickerOn = false
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Image(systemName: "platter.filled.top.iphone").foregroundColor(.accentColor)
                    Toggle("Expiry Notifications", isOn: $notificationOn)
                }
                // add update icon
                HStack {
                    Text("Time")
                    Spacer()
                    
                    Button("\(currentTime.formatted(date: .omitted, time: .shortened))") {
                        withAnimation {
                            isDatePickerOn.toggle()
                            
                            //this is where you trigger update of notifications
                            if !isDatePickerOn {
                                print("save here!!")
                            }
                                
                        }
                        
        
                    }
                    
                }
                if isDatePickerOn {
                    DatePicker("Notification Time", selection: $currentTime, displayedComponents: [.hourAndMinute])
                        .datePickerStyle(.wheel)
                }
                Text("test")
                
                
                
                
            } header: {
                Text("Notifications")
            }
        }
    }
}

