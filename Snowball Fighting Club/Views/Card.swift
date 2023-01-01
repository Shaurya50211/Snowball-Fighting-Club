//
//  Card.swift
//  Snowball Fighting Club
//
//  Created by Shaurya Gupta on 2022-12-31.
//

import SwiftUI
import FirebaseAuth

struct Card: View {
    @Binding var location: String
    @Binding var date: String
    @Binding var time: String
    @Binding var host: String
    @State var sendSMS = SendSMS()
    @State var border = 0
    @State var phoneNumb: String = ""
    @State var someText = "Remind Me"
    var body: some View {
            Section {
                VStack {
                    HStack {
                        Image(systemName: "location.fill")
                            .font(.title)
                        Text("\(location)")
                            .font(.custom("Oswald", size: 30, relativeTo: .title))
                            .lineLimit(100)
                        
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 130)
                    
                    Text("Hosted by: \(host)")
                        .padding(.top, -68)
                        .fontWeight(.black)
                    
                    HStack {
                        Image(systemName: "clock.fill")
                            .font(.title)
                        Text(time)
                            .font(.custom("Oswald", size: 27, relativeTo: .title2))
                    }
                    .padding(.top, -120)
                    .padding(.trailing, 120)
                    
                    HStack {
                        Image(systemName: "calendar")
                            .font(.title)
                        Text(date)
                            .font(.custom("Oswald", size: 27, relativeTo: .title2))
                    }
                    .padding(.top, -145)
                    .padding(.leading, 170)
                    
                    Button {
                        if phoneNumb == "" {
                            border = 2
                        } else {
                            sendSMS.doStuff(phoneNumber: phoneNumb, message: "❄️❄️❄️ GET READY ❄️❄️❄️!\nHello from the SBFC 👋, you have a victory waiting for you at \(location) 🏔️! Remember to come on time on \(date), \(time) ⏰.\nHost: \(host)")
                            someText = "✅"
                        }
                    } label: {
                        Text(someText)
                            .font(.custom("Oswald", size: 25))
                            
                    }
                    .padding(.top, -100)
                    TextField("Phone # (Include ext.)", text: $phoneNumb)
                        .textContentType(.telephoneNumber)
                        .padding()
                        .frame(width: 250, height: 52)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(10)
                        .border(Color(.systemRed), width: CGFloat(border))
                        .padding(.top, -80)
                        
                }

            }
            .frame(width: 300, height: 300)
        
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(
            location: .constant("Dewitt Park"),
            date: .constant("Dec 31"),
            time: .constant("10:00 AM"),
            host: .constant("Shaurya")
            )
    }
}
