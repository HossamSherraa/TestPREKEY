//
//  ContentView.swift
//  TestPREKEY
//
//  Created by Hossam on 30/12/2020.
//

import SwiftUI

struct TestKeyData : Equatable {
    static func == (lhs: TestKeyData, rhs: TestKeyData) -> Bool {
        false
    }
    
    let i : Int
    let rect : CGFloat
}
struct TestKey : PreferenceKey {
 

    static var defaultValue: [TestKeyData] = []
    
    static func reduce(value: inout [TestKeyData], nextValue: () -> [TestKeyData]) {
        value.append(contentsOf: nextValue())
    }
    
    typealias Value = [TestKeyData]
    
    
}

struct TestView : View {
    @State var text : String = "RRR"
    var body: some View {
        VStack{
        ContentView()
        TextField.init("", text: $text)
            .frame(width: CGFloat(text.count) * 20, height: 100, alignment: .center)
            .textFieldStyle(RoundedBorderTextFieldStyle())}
            .preference(key: TestKey.self, value: [TestKeyData(i: 1, rect: CGFloat(text.count) * 10)])
            .transformPreference(TestKey.self) { (value) in
                value = [TestKeyData(i: 02, rect: .zero)]
            }
            
    }
}
struct ContentView: View {
   
    @State var  width : CGFloat = 40
    var body: some View {
        VStack{
           
            Color.blue
                .frame(width: width, height: 20, alignment: .center)
        }
        .onPreferenceChange(TestKey.self, perform: { value in
            print(value.count)
            withAnimation{
            self.width = value.first?.rect ?? 10
            }
        })
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
