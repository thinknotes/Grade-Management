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

var savedData: [[String]] = []

var optionsSelected = 0

print("Generating Data, Pls wait......")
print("")
readData()
print("")
print("")
printData()
while optionsSelected != 10 {
    menuDisplay()
    if let userInput = readLine(), let selectedOption = Int(userInput) {
        optionsSelected = selectedOption
        
        if optionsSelected == 1 {
            print("")
            print("")
            print("Which student would you like to choose?")
            if let userInputString = readLine(), let StudentNames = searchForStudent(studentName: userInputString) {
                print("\(studentNames)'s grades for this class are:")
            } else {
                print(" name is not found in students. Please try a differnt name")
            }
            
        } else if optionsSelected == 2 {
            
        } else if optionsSelected == 3 {
            print("")
            print("")
//            readData()
            
        } else if optionsSelected == 4 {
            print("")
            print("")
            print("The class average is: ")
        } else if optionsSelected == 5 {
            
        } else if optionsSelected == 6 {
            
        } else if optionsSelected == 7 {
            
        } else if optionsSelected == 8 {
            
        } else if optionsSelected == 9 {
            
            
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
            }
            
            studentGades.append(tempGrades)
          
        }
    }
    
    
    
    //MARK: Search For Student
    func searchForStudent(studentName name: String) -> Int? {
        let studentNameLowercasee = name.lowercased()
        for index in studentNames.indices {
            if studentNames[index] == studentNameLowercasee {
                return index
            }
        }
        
        return nil
    }

func printData() {
    print("Studnet Names: \(studentNames)")
    print("Student Grades: \(studentGades)")
}
    

