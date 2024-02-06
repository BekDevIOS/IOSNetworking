//
//  ContentView.swift
//  IOSNetworking
//
//  Created by Utkirbek Mekhmonboev on 2/6/24.
//

import SwiftUI


struct ContentView: View {
    @State private var employees = [Data]()
    //@State private var posts = [Post]()
    var body: some View {
        NavigationView {
            List(employees, id: \.id){employee in
                VStack(alignment: .leading){
                    Text(employee.employee_name.uppercased())
                        .fontWeight(.bold)
                    Text("\(employee.employee_age)").padding(.top, 5)
                    Text("\(employee.employee_salary)").padding(.top, 5)
                }
            }
            .navigationTitle("Employees")
            .task {
                await fetchData()
            }
        }
    }
    func fetchData() async {
        //create url
        guard let url = URL(string: "https://dummy.restapiexample.com/api/v1/employees") else
        {
            print("Error")
            return
        }
        // fetch data from that url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode that data
            if let decodedResponse = try? JSONDecoder().decode(Mode.self, from: data){
                //posts = decodedResponse
                employees = decodedResponse.data
                
            }
        } catch  {
            print("bad news ... this data isn't vaild")
        }
        // decode that data
    }
}

#Preview {
    ContentView()
}
