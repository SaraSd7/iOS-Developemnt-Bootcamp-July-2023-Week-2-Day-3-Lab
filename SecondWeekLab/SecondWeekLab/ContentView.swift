//
//  ContentView.swift
//  SecondWeekLab
//
//  Created by Sara Sd on 14/01/1445 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var showDetails = false
    @State private var showMessage = false
    @State private var message = ""
    @StateObject var dataModel = DataModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.showDetails.toggle()
                }) {
                    Text("Show Details")
                }
                .padding()
                
                if showDetails {
                    NavigationLink(destination: DetailView(receivedData:$message)) {
                        Text("Go to Detail View")
                    }
                }
                
                Button(action: {
                    self.showMessage.toggle()
                }) {
                    Text("Toggle State Variable")
                }
                .padding()
                
                if showMessage {
                    Text("State Variable is toggled")
                } else {
                    Text("State Variable is not toggled")
                }
                
                CustomView(text: $message)
                    .padding()
                
                Text(dataModel.data)
                    .padding()
                
                Button(action: {
                    self.dataModel.isDark.toggle()
                    self.dataModel.updateData()
                }) {
                    Text("Update Data")
                }
                .padding()
            }
            .background(self.dataModel.isDark ? Color.black : Color.white)
            .navigationBarTitle("Main View")
        }
    }
}

struct DetailView: View {
   @Binding var receivedData: String
    
    var body: some View {
        Text(receivedData)
            .navigationBarTitle("Detail View")
    }
}

struct CustomView: View {
    @Binding var text: String
    
    var body: some View {
        VStack {
            TextField("Enter Text", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                self.text = "Button is tapped"
            }) {
                Text("Tap Button")
            }
            .padding()
            Button(action: {
                self.text = "What Do You Want"
            }) {
                Text("Initial Data")
            }
            .padding()
        }
    }
}

class DataModel: ObservableObject {
    @Published var data = "Initial Data"
    @Published var isDark: Bool = false
    func updateData() {
        data = "Updated Data"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
