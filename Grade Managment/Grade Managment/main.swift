//
//  main.swift
//  Grade Managment
//
//  Created by StudentAM on 1/25/24.
//

import Foundation
import CSV


//let studentGrades =
//let classAvegare = 

var studentNames: [String] = []
var studentGades: [[String]] = []





var finalGrads: [Double] = []
var sumOfGrades: Int = 0
var average: Double = 0.0


var optionsSelected = 0

var status = true

print("Generating Data, Pls wait......")
print("")
readData()
print("")
print("")
printData()
while optionsSelected != 10 && status {
    menuDisplay()
    if let userInput = readLine(), let selectedOption = Int(userInput) {
        optionsSelected = selectedOption
        
        if optionsSelected == 1 {
            print("")
            print("")
            print("Which student would you like to choose?")
            if let userInputString = readLine(), let studentIndex = searchForStudent(studentName: userInputString) {
                print("\(studentNames[studentIndex])'s grades in this class is:  ")
                print("\(finalGrads[studentIndex])")
//
            } else {
                print(" name is not found in students. Please try a differnt name")
            }
            
        } else if optionsSelected == 2 {
            print("")
            print("")
            print("Which student would you like to choose?")
            if let userInputString = readLine(), let studentIndex = searchForStudent(studentName: userInputString) {
                print("\(studentNames[studentIndex])'s grades for this class are: ")
                formatArray(studentGradesArray: studentGades[studentIndex])
            } else {
                print(" name is not found in students. Please try a differnt name")
            }
        } else if optionsSelected == 3 {
            print("")
            print("")
            printAllGrades()
            
        } else if optionsSelected == 4 {
            print("")
            print("")
            print("The class average is: ")
        } else if optionsSelected == 5 {
            
        } else if optionsSelected == 6 {
            
        } else if optionsSelected == 7 {
            
        } else if optionsSelected == 8 {
            
        } else if optionsSelected == 9 {
            status = false
            print("")
            print("")
            print("Have a great rest of your day!")
        } else {
            print("Option Not Found")
        }
    }
    
    
}
    
    //MARK: Menu Display
    func menuDisplay() {
        print("")
        print("")
        print("Welcome to the Grade Manager!")
        print("What would you like to do? (Enter the number):")
        print("1.Display grade of single student")
        print("2.Display all grades for a student")
        print("3.Display all grades of ALL students")
        print("4.Find the average grade of the class")
        print("5.Find the average grade of an assignment")
        print("6.Find the lowest grade in the class")
        print("7.Find the highest grade of the class")
        print("8.Filter students by grade range")
        print("9.Quit")
    }
    
    //MARK: Read Data
    func readData() {
        do {
            let stream = InputStream(fileAtPath: "/Users/studentam/Downloads/Grade Data.csv.txt")
            let csv = try CSVReader(stream: stream!)
            
            while let row = csv.next() {
                manageData(row: row)
                
            }
            
        } catch {
            print("DEBUG: Error trying to read the file")
        }
    }


    
//MARK: Manage Data
    func manageData(row: [String]) {
        var tempGrades: [String] = []
        for i in row.indices {
            if i == 0 {
                studentNames.append(row[i])
                
            } else {
                tempGrades.append(row[i])
                getAverage(array: row, index: i)
            }
            
          
          
        }
        studentGades.append(tempGrades)
        
        
    }

func getAverage(array: [String], index: Int) {
    
    for grade in array {
        
        if let intGrade = Int(grade) {
            sumOfGrades += intGrade
        }
    }
    
    average = Double(sumOfGrades / array.count)
    finalGrads[index] = average
}
    
    
    
    //MARK: Search For Student
    func searchForStudent(studentName name: String) -> Int? {
        let studentNameLowercasee = name.lowercased()
        for index in studentNames.indices {
            if studentNames[index].lowercased() == studentNameLowercasee {
                return index
            }
        }
        
        return nil
    }


func formatArray(studentGradesArray: [String]) {
    for grade in studentGradesArray {
//        let joinedString = studentGradesArray.joined(separator: ",")
//        let gradeString = joinedString.dropLast()
        print("\(grade)", terminator: ",")
    }
}

func printData() {
    print("Studnet Names: \(studentNames)")
    print("")
    print("")
    print("Student Grades: \(studentGades)")
}

func printAllGrades() {
    for s in studentGades.indices {
        print("\(studentGades[s]) grades are:", terminator: ",")
     
    }
    
}




