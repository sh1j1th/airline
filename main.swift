//
//  main.swift
//  airline
//
//  Created by Shijith K  on 06/06/22.
//

import Foundation

print("******* Welcome to AlphaAir Ticket Booking System *******")
print("\nPlease follow the prompt for booking your ticket in flight AA 542.")

//MARK: - variables

/// Test cases to execute various scenario
// all seats empty testCase
//var seatChart = [false, false, false, false, false, false, false, false, false, false]

// first class filled and economy empty
//var seatChart = [true, true, true, true, true, false, false, false, false, false]

// economy filled and first class has availability
//var seatChart = [true, true, true, true, false, true, true, true, true, true]

// no seats available, all filled
var seatChart = [ true, true, true, true, true, true, true, true, true, true]
/// End of scenario test cases

var userName: String
var userChoiceType: Int
var userChoiceSeat: Int
var seatConfirmed: (Int, Bool) = (-1, false)
var seatAvailable: (Int, Bool) = (-1, false)
var upgradeAvailable: (Int, String) = (-1, "")
var upgradeChoice: String = "n"


//MARK: - handle user
print("\nPlease enter your name or initial: ", terminator: "")
userName = readLine()!
print("\nPlease type 1 for First Class or please type 2 for Economy: ", terminator: "")
userChoiceType = Int(readLine() ?? "0") ?? 0

// check if seat available in type user requested for
seatAvailable = checkAvailability(userChoiceType)
if seatAvailable.1{
    // confirm users ticket in the available seat of the chosen type
    seatConfirmed = assignSeat(seatAvailable.0)
} else {
    // check which section has availability for upgrade
    upgradeAvailable = checkAllSeatsAndConfirm(userChoiceType)
    //handle upgrade
    if upgradeAvailable.0 != -1 {
        print("\nPlease press y to confirm upgrade to \(upgradeAvailable.1): ", terminator: "")
        upgradeChoice = readLine()!
        if upgradeChoice.lowercased() == "y" {
            print("\nTrying to upgrade your seat from \(userChoiceType == 1 ? "First Class" : "Economy")", terminator: "")
            // re-assign user to upgraded type
            userChoiceType = upgradeAvailable.1 == "Economy" ? 2 : 1
            print(" to \(userChoiceType == 1 ? "First Class" : "Economy")")
            seatConfirmed = assignSeat(upgradeAvailable.0)
        }
    } else {
        print("\nUnable to locate a seat or provide upgrade in current flight!!")
    }
}

//MARK: - Create instance and display detail
//create reservation instance
var reserved = Reservation(userName: userName, seatType: userChoiceType == 1 ? "First Class" : "Economy", seatAssigned: seatConfirmed.1, seatNumber: seatConfirmed.0)
print("\n\n<<<<<<<<<< BOOKING STATUS >>>>>>>>>>>")
reserved.userDetails()
print("<<<<<<<<<<<<<<< END >>>>>>>>>>>>>>>>>\n\n")
print("Exiting application...")

public func checkAvailability(_ userChoiceSeatType: Int) -> (Int, Bool) {
    switch(userChoiceSeatType){
    case 1 : //firstClass 1-5
        for seat in stride(from: 0, through: 4, by: 1){
            if seatChart[seat] == false {
                return (seat, true)
            }
        }
    case 2 : //economy 6-10
        for seat in stride(from: 5, through: 9, by: 1){
            if seatChart[seat] == false {
                return (seat, true)
            }
        }
    default : return (-1, false)
    }
    return (-1, false)
}

public func assignSeat(_ seatNumber: Int) -> (Int, Bool) {
    if seatChart[seatNumber] == false {
        seatChart[seatNumber] = true
        return (seatNumber, true)
    } else {
        return (seatNumber, false)
    }
}

func checkAllSeatsAndConfirm(_ currentTypeChoice: Int) -> (Int, String) {
    switch currentTypeChoice {
    case 2 : //firstClass 1-5
        for seat in stride(from: 0, through: 4, by: 1){
            if seatChart[seat] == false {
                return (seat, "First Class")
            }
        }
    case 1 : //economy 6-10
        for seat in stride(from: 5, through: 9, by: 1){
            if seatChart[seat] == false {
                return (seat, "Economy")
            }
        }
    default : return (-1, "")
    }
    return (-1, "")
}

