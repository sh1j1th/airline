//
//  Reservation.swift
//  airline
//
//  Created by Shijith K  on 06/06/22.
//

import Foundation
public class Reservation {
    var userName: String
    var seatType: String
    var seatAssigned: Bool
    var seatNumber: Int
    
    init(userName: String, seatType: String, seatAssigned: Bool, seatNumber: Int) {
        self.userName = userName
        self.seatType = seatType
        self.seatAssigned = seatAssigned
        self.seatNumber = seatNumber
    }
    
    public func userDetails() {
        if seatAssigned == true {
            print("\n---------- BOARDING PASS ISSUED ----------\nDear \(userName), your ticket has been CONFIRMED in \(seatType).\nYour seat number is \(seatNumber + 1).\nThank you and wish you a safe journey.\n")
        } else {
            print("\nDear \(userName), your ticket is NOT CONFIRMED.")
            print("Next flight leaves in 3 hours. Thank you.\n")
        }
    }
}
