//
//  Create SBF.swift
//  Snowball Fighting Club
//
//  Created by Shaurya Gupta on 2022-12-31.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseFirestore

struct Create_SBF: View {
    @State var location: String = ""
    @State var date: Date = Date.now
    @State var time: Date = Date.now
    @State var convertedDate:String = ""
    @State var convertedTime:String = ""
    @State var host: String = ""
    @State var homePage = HomePage()
    @State var dateFormatter = DateFormatter()
    let db = Firestore.firestore()
    var body: some View {
        ZStack {
            Text("Create a Snow Ball Fight Event")
                .font(.custom("Oswald", size: 40, relativeTo: .largeTitle))
                .fontWeight(.black)
                .padding(.bottom, 600)
            
            TextField("Location eg. Dewitt Park", text: $location)
                .textContentType(.emailAddress)
                .padding()
                .frame(width: 350, height: 52)
                .background(Color.black.opacity(0.08))
                .cornerRadius(10)
                .border(Color(.systemBlue), width: CGFloat(2))
                .padding(.bottom,350)
                .padding(.leading, -10)
            DatePicker("Date", selection: $date, displayedComponents: .date)
                .textContentType(.dateTime)
                .padding()
                .frame(width: 350, height: 52)
                .background(Color.black.opacity(0.08))
                .cornerRadius(10)
                .border(Color(.systemBlue), width: CGFloat(2))
                .padding(.bottom,150)
                .padding(.leading, -10)
            DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                .textContentType(.dateTime)
                .padding()
                .frame(width: 350, height: 52)
                .background(Color.black.opacity(0.08))
                .cornerRadius(10)
                .border(Color(.systemBlue), width: CGFloat(2))
                .padding(.bottom,-50)
                .padding(.leading, -10)
            Button {
                dateFormatter.dateFormat = "MMM d"
                convertedDate = dateFormatter.string(from: date)
                dateFormatter.dateFormat = "hh:mm"
                convertedTime = dateFormatter.string(from: time)
                
                if Auth.auth().currentUser?.uid != nil {
                    let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            host = document["name"] as! String
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
                
                db.collection("games").addDocument(data: ["location": location, "date": convertedDate, "time": convertedTime, "host": host])
                homePage.showPopover.toggle()
            } label: {
                Text("CREATE!")
                    .foregroundColor(.white)
                    .font(.custom("Oswald", size: 90, relativeTo: .largeTitle))
                    
                
            }
            .frame(width: 400, height: 200)
            .background(Color.blue)
            .padding(.top, 400)


        }
    }
}

struct Create_SBF_Previews: PreviewProvider {
    static var previews: some View {
        Create_SBF()
    }
}
