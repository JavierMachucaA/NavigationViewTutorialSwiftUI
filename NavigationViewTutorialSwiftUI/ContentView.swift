//
//  ContentView.swift
//  NavigationViewTutorialSwiftUI
//
//  Created by Javier Ignacio Machuca Arredondo on 11-12-23.
//

import SwiftUI

struct CarBrand: Identifiable, Hashable {
    let name: String
    let id = NSUUID().uuidString
}

struct Car: Identifiable, Hashable {
    let id = NSUUID().uuidString
    let make: String
    let model: String
    let year: Int
    
    var description: String {
        return "\(year) \(make) \(model)"
    }
}

struct ContentView: View {
    let brands: [CarBrand] = [
        .init(name: "Ferrari"),
        .init(name: "Mercedes"),
        .init(name: "Lamborgini"),
        .init(name: "Aston Martin")
    ]
    
    let cars: [Car] = [
        .init(make: "Ferrari", model: "488", year: 2022),
        .init(make: "Mercedes", model: "AMG 63", year: 2019),
        .init(make: "Lamborgini", model: "Avcentador", year: 2023),
        .init(make: "Aston Martin", model: "Vantage", year: 2021)
    ]
    
    @State private var navigationPath = [CarBrand]()
    @State private var showFullStack = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                List {
                    Section("Manufacturerers") {
                        ForEach(brands) { brand in
                            NavigationLink(value: brand){
                                Text(brand.name)
                            }
                        }
                    }
                    
                    Section("Cars") {
                        ForEach(cars) { car in
                            NavigationLink(value: car){
                                Text(car.description)
                            }
                        }
                    }
                }
                .navigationDestination(for: CarBrand.self) { brand in
                    VStack {
                        viewBrand(brand)
                        
                        Button {
                            navigationPath = []
                        } label: {
                            Text("Go to Root")
                        }
                    }
                }
                .navigationDestination(for: Car.self) { car in
                    Color(.systemRed)
                }
                Button {
                    showFullStack.toggle()
                    
                    if showFullStack {
                        navigationPath = brands
                    } else {
                        navigationPath = [brands[0], brands[2], brands[1]]
                    }
                    
                } label: {
                    Text("View All")
                }

            }
        }
    }
    
    func viewBrand(_ brand: CarBrand) -> AnyView {
        switch brand.name {
        case "Ferrari":
            return AnyView(Color(.systemRed))
        case "Mercedes":
            return AnyView(Color(.systemPurple))
        case "Lamborgini":
            return AnyView(Color(.systemOrange))
        case "Aston Martin":
            return AnyView(Color(.systemGreen))
        default:
            return AnyView(Color(.systemGray5))
        }
    }
}

#Preview {
    ContentView()
}
