//
//  HomePage.swift
//  Snowball Fighting Club
//
//  Created by Shaurya Gupta on 2022-12-30.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct HomePage: View {
    let db = Firestore.firestore()
    @State var currentUser = Auth.auth().currentUser
    @State var dicData: [String: String]?
    @State var locations = [""]
    @State var contentView = ContentView()
    @State var dates = [""]
    @State var showPopover = false
    @State var times = [""]
    @State var hosts = [""]
    var body: some View {
        ZStack {
            if locations != [""] {
                if dates != [""] {
                    if times != [""] {
                        if hosts != [""] {
                            if hosts.count == locations.count && dates.count == times.count {
                                List {
                                    ForEach(0..<hosts.count) { index in
                                        Card(location: $locations[index], date: $dates[index], time: $times[index], host: $hosts[index])
                                    }
                                }
                                .listStyle(InsetGroupedListStyle())
                            } else {
                                Button {
                                    getEverything()
                                } label: {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                        .foregroundColor(.blue)
                                        .font(.largeTitle)
                                }
                            }
                        } else {
                            Button {
                                getEverything()
                            } label: {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .foregroundColor(.blue)
                                    .font(.largeTitle)
                            }
                        }
                    } else {
                        Button {
                            getEverything()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .foregroundColor(.blue)
                                .font(.largeTitle)
                        }
                    }
                } else {
                    Button {
                        getEverything()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .foregroundColor(.blue)
                            .font(.largeTitle)
                    }
                }
            } else {
                Button {
                    getEverything()
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .foregroundColor(.blue)
                        .font(.largeTitle)
                }
            }
            Button {
                self.showPopover.toggle()
            } label: {
                Circle()
                    .background(Color.blue)
                    .cornerRadius(75)
                    .frame(width: 80)
                    .overlay {
                        Image(systemName: "plus")
                            .font(.custom("Oswald", size: 47))
                            .foregroundColor(.white)
                    }
                    .shadow(radius: 15)
            }
            .padding(.top, 600)
            .padding(.leading, 270)
            .popover(isPresented: $showPopover) {
                Create_SBF()
            }
            
            Button {
                do {
                    try withAnimation(.easeOut) {
                        try Auth.auth().signOut()
                        contentView.isLoggedIn = false
                    }
                } catch {
                    print(error)
                }
            } label: {
                Circle()
                    .background(Color.blue)
                    .cornerRadius(75)
                    .frame(width: 80)
                    .overlay {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.custom("Oswald", size: 40))
                            .foregroundColor(.orange)
                    }
                    .shadow(radius: 15)
            }
            .padding(.top, 600)
            .padding(.trailing, 250)
        }

    }
    
    func getEverything() {
        db.collection("games")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        dicData = document.data() as? [String: String]
                        print(dicData!)
                        locations.append(dicData!["location"]!)
                        dates.append(dicData!["date"]!)
                        times.append(dicData!["time"]!)
                        hosts.append(dicData!["host"]!)
                    }
                }
//                print(locations)
//                print(dates)
//                print(times)
//                print(hosts)
            }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
