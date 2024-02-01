//
//  main.swift
//  Grade Managment
//
//  Created by StudentAM on 1/25/24.
//

import Foundation
import CSV


//Stores the names of student
var studentNames: [String] = []
//Store the name of grades
var studentGades: [[String]] = []




//Holds the final grades
var finalGrads: [Double] = []



//Help them menu show the right screen
var optionsSelected = 0

//Shows if menu is running
var status = true

//Shows all the Data need for the project
print("Generating Data, Pls wait......")
print("")
readData()
print("")
print("")
printData()
while optionsSelected != 10 && status { // Only allows the menu to to accept user input 1 - 9 and checks that status is running
    menuDisplay()
    if let userInput = readLine(), let selectedOption = Int(userInput) {
        optionsSelected = selectedOption
        
        //MARK: Display Grade Of Single Student
        if optionsSelected == 1 {
            //Shows a single students thier grades for class. Will show error if student has not been found
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
            
        //MARK: Display All Grades For A Student
        } else if optionsSelected == 2 {
            //Shows a single students all thier grades for class. Will show error if student has not been found
            print("")
            print("")
            print("Which student would you like to choose?")
            if let userInputString = readLine(), let studentIndex = searchForStudent(studentName: userInputString) {
                print("\(studentNames[studentIndex])'s grades for this class are: ")
                formatArray(studentGradesArray: studentGades[studentIndex])
            } else {
                print(" name is not found in students. Please try a differnt name")
            }
        //MARK: Display All Grades Of All Students
        } else if optionsSelected == 3 {
            //Print all  the grades for the student with names
            print("")
            print("")
            printAllGrades()
            
        //MARK: Find The Average Grade Of The Class
        } else if optionsSelected == 4 {
            //CA -> Class Average
         let CA =  classAverage()
            print("")
            print("")
            print("The class average is: \(String(format: "%.2f", CA))") //Format the Class Average
        //MARK: Find The Average Grade Of An Assignment
        } else if optionsSelected == 5 {
            print("")
            print("")
            print("Which assignent would like to get the average of (1-10):")
            if let userInputString = readLine(), let assignmentNumber = Int(userInputString), assignmentNumber >=  0, assignmentNumber < 11 {
                //Only allows a number from 1 to 10 to be enter
                
                //Get the assigment average
                let assigmentAverage = assigmentAverage(assignmnetNumber: userInputString)
                print("The average for assignment #\(assignmentNumber) is \(String(format: "%.2f", assigmentAverage))")
                //Format the average with the assignment number
                
            }
            
        //MARK: Find The Lowest Grade In The Class
        } else if optionsSelected == 6 {
            //Find the lowest grade and along with the student name
            print("")
            print("")
            let studentIndex = lowestGrade()
            print("\(studentNames[studentIndex!]) has the lowest grade: \(finalGrads[studentIndex!])")

        //MARK: Find The Highest Grade Of The Class
        } else if optionsSelected == 7 {
            //Find the highest grade and along with the student name
            print("")
            print("")
            var studentIndex = highestGrade()
            print("\(studentNames[studentIndex!]) has the highest grade: \(finalGrads[studentIndex!])")
            
        //MARK: Filter Students By Grade Range
        } else if optionsSelected == 8 {
            //Takes low and high ranges enter by the user and filter the data and shows the user
            print("")
            print("")
            print("Enter the low range you would like to use:")
            if let userInputString = readLine(), let lowRange = Double(userInputString) {
              
                print("")
               
                print("Enter the high range you would like to use")
                if let userInputString = readLine(), let highRange = Double(userInputString) {
                  filterGrade(lowrange: lowRange, highrange: highRange)
                  
                }
            }
            
        //MARK: Quit
        } else if optionsSelected == 9 {
            //Tell the menu to stop running
            status = false
            print("")
            print("")
            //Shows the quit message
            print("Have a great rest of your day!")
        } else {
            //If the user put in a number more then 9
            print("Option Not Found")
        }
    }
    
    
}
    
    //MARK: Menu Display
    func menuDisplay() { //Display options for the menu
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
        print("CopyRight C 1956 School Systems - All Rights Reserved")
    }
    
    //MARK: Read Data
    func readData() { //Read the data from a file, Located in the project
        do {
            let stream = InputStream(fileAtPath: "/Users/studentam/Downloads/Grade Data.csv.txt")
            let csv = try CSVReader(stream: stream!)
            
            while let row = csv.next() {
                manageData(row: row) //add  the data to manage data
                
            }
            
        } catch {
            print("DEBUG: Error trying to read the file") //Disaplay an error if anything goes wrong while reading the data
        }
    }


    
//MARK: Manage Data
    func manageData(row: [String]) {
        var tempGrades: [String] = [] //Creates a tempary array to hold grades
        for i in row.indices {
            if i == 0 { //Makes sure we starting counting at 1 not zero
                studentNames.append(row[i])
                
            } else {
                tempGrades.append(row[i])
//
            }
            
          
          
        }
//
        getAverage(array: tempGrades) //Find the average of the temp grades
        studentGades.append(tempGrades) //Once the average is found at it to the student grades variable
        
        
    }
//MARK: Get Average
func getAverage(array: [String]) {
    if array.count == 0 { //Wont run if the array has nothing in it
        return
    }
    //var need to get the average
    var sumOfGrades: Int = 0
    var average: Double = 0.0
    
    
    for grade in array { //Check the array provied
        
        if let intGrade = Int(grade) { //Converts grade to Int
            sumOfGrades += intGrade //Add the grade Int to sum of grades
        }
    }
    
    //Declares the average
    average = Double(sumOfGrades / array.count)
    //Add the average to final grades
    finalGrads.append(average)
  

    sumOfGrades = 0
}


//MARK: Assigment Average
func assigmentAverage(assignmnetNumber: String) -> Double{
    var sum: Double = 0.0
    
    if let index = Int(assignmnetNumber) { //Coverts assignement number to Int
        
        for grades in studentGades {
            
            
            sum += Double(grades[index - 1])!
            //Looks through the array return the answer
            
        }
    }
    
    //Create the assignment average
    let average = sum / Double(studentNames.count) //Divides the sum by the number of students
    return average
    
    
}
    

    
    
    //MARK: Search For Student
    func searchForStudent(studentName name: String) -> Int? {
        let studentNameLowercasee = name.lowercased()
        //Allows for student name to be enter lowercasse
        for index in studentNames.indices {
            if studentNames[index].lowercased() == studentNameLowercasee {
                return index
            }
            
            //Checks that the student name and the lowercasse version are the same
        }
        
        return nil
    }


//MARK: Format Array
func formatArray(studentGradesArray: [String]) {
    //Formats the array with , and prints the grade in the array
    for grade in studentGradesArray {
        print("\(grade)", terminator: ",")
    }
}


//MARK: Print Data
func printData() {
    //Prints all the data you see one you run the program at the top of the screen
    print("Class Of 1957 - MR. Beckmans 5th Period History Class: \(studentNames)")
    print("")
    print("")
    print("MR. Beckmans 5th Period History Class Grades: \(studentGades)")
}


//MARK: Print All Grades
func printAllGrades() {
    
    //Finds the student name and match it to thier grades with index and prints it
    for (index, studentName) in studentNames.enumerated() {
        print("\(studentName) grades are: \(studentGades[index].map { String($0) }.joined(separator: ", "))")
    }
}

//MARK: Finds Class Average
func classAverage() -> Double {
    var totalGrades: Double = 0.0
    
    //Finds the class avarge by adding up all the grades in final grades and dividing it by the number of students
    for grade in finalGrads {
        totalGrades += grade
    }
    
    return Double(totalGrades) / Double(studentNames.count)
    
   
}




//MARK: Lowest Grade
func lowestGrade() -> Int? {
    //Assumes the lowest grade is the frist grade
    var lowest = finalGrads[0]
    var indexTracking: Int = -1
    //Keep track of the index
    
  
    
    for index in finalGrads.indices {
        if lowest > finalGrads[index]{
             lowest = finalGrads[index]
            indexTracking = index
        }//Finds lowest in final grades
    }
  
    //Return the lowest grade
    return indexTracking
    
}

//MARK: Highest Grade
func highestGrade() -> Int? {
    //Assumes the highest grade is the frist grade
    var highest = finalGrads[0]
    var indexTracker: Int = -1
    //Keep track of the index
    
    for index in finalGrads.indices{
        if highest < finalGrads[index] {
            highest = finalGrads[index]
            indexTracker = index
        }//Finds highest in final grades
    }
    
    //Return the highest grade
    return indexTracker
}

//MARK: Filter Grade
func filterGrade(lowrange: Double, highrange: Double)  {
    //Ask the user for low and high range input
    
    for index in finalGrads.indices {
        if highrange > finalGrads[index] && lowrange < finalGrads[index] {
            print("\(studentNames[index]):  \(finalGrads[index])")
        } else {
            print("The ranges you have entred have not been found. Please try a different number")
        }
        
        // Check if the range that the user put in is in final grades and if it is print the student names and thier grade. Else will give an error saying data has not been found
    }
    
    
}
