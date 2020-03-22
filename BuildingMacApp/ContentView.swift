//
//  ContentView.swift
//  BuildingMacApp
//
//  Created by Ramill Ibragimov on 22.03.2020.
//  Copyright © 2020 Ramill Ibragimov. All rights reserved.
//

import SwiftUI

struct Question {
    let text: String
    let actualAnswer: String
    var userAnswer = ""
    
    init() {
        let left = Int.random(in: 1...10)
        let right = Int.random(in: 1...10)
        
        text = "\(left) + \(right) = "
        actualAnswer = "\(left + right)"
    }
}

struct QuestionRow: View {
    var question: Question
    
    var body: some View {
        HStack {
            Text(question.text)
                .padding([.top, .bottom, .leading])
            
            ZStack {
                Text(" ")
                    .padding()
                    .frame(width: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                    )
                
                Text(question.userAnswer)
            }
        }
        .font(.system(size: 48, weight: .regular, design: .monospaced))
        .foregroundColor(.white)
    }
}

struct ContentView: View {
    @State private var questions = [Question]()
    
    var body: some View {
        ZStack {
            ForEach(0..<questions.count, id: \.self) { index in
                QuestionRow(question: self.questions[index])
                    .offset(x: 0, y: CGFloat(index) * 100)
            }
        }
        .frame(width: 1000, height: 600)
        .onAppear(perform: createQuestions)
        .onReceive(NotificationCenter.default.publisher(for: .enterNumber)) { note in
            guard let number = note.object as? Int else { return }
            print(number)
        }
        .onReceive(NotificationCenter.default.publisher(for: .removeNumber)) { _ in
            print("Remove")
        }
        .onReceive(NotificationCenter.default.publisher(for: .submitAnswer)) { _ in
            print("Submit")
        }
    }
    
    func createQuestions() {
        for _ in 1...50 {
            questions.append(Question())
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
