//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation


public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money
//
public struct Money {
    public var currency : String
    public var amount : Int
    init (amount: Int, currency: String) {
        self.currency = currency
        self.amount = amount
    }
    public var dic: [String: Int] = ["USD" : 15, "GBP" : 30,
                                     "EUR" : 10, "CAN" : 12]
    
    
    public func convert(_ to: String) -> Money {
        let ratio = (Double(dic[self.currency]!)) / (Double (dic[to]!))
        let new = Int((Double(self.amount)) * ratio)
        return Money(amount: new, currency: to)
    }
    
    public func add(_ to: Money) -> Money {
        let m = self.convert("USD")
        let n = to.convert("USD")
        let total = Money(amount: m.amount + n.amount, currency: "USD")
        return total.convert(to.currency)
    }
    public func subtract(_ from: Money) -> Money {
        let m = self.convert("USD")
        let n = from.convert("USD")
        let result = Money(amount: n.amount - m.amount, currency: "USD")
        return result.convert(from.currency)
    }
}

////////////////////////////////////
// Job
//
open class Job {
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type{
        case .Hourly(let h):
            return (Int(Double(hours) * h))
        case.Salary(let y):
            return y
        }
    }
    
    open func raise(_ amt : Double) {
        switch self.type{
        case .Hourly(let h):
            self.type = .Hourly(h + amt)
        case .Salary(let y):
            self.type = .Salary(y + Int(amt))
        }
    }
}

////////////////////////////////////
// Person

open class Person {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get {
            if _job == nil{
                return nil
            }else {
                return _job!
            }
        }
        set(value) {
            if age < 16{
                _job = nil
            } else {
            _job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
            if _spouse == nil {
                return nil
            }else {
                return _spouse
            }}
        set(value) {
            if age < 18 {
                _spouse = nil
            } else {
                _spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:nil spouse:nil]"
    }
}

////////////////////////////////////
// Family
//
open class Family {
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        //if (spouse1.age >= 21 || spouse2.age >= 21){
            members.append(spouse1)
            members.append(spouse2)
        //}
    }
    
    open func haveChild(_ child: Person) -> Bool {
        //let child : Person = Person(firstName: "", lastName: "", age: 0)
        members.append(child)
        return true
    }
    
    open func householdIncome() -> Int {
        var total: Int = 0
        for p in members {
            if p.job != nil{
                switch (p.job!.type){
                case .Salary:
                    total += p.job!.calculateIncome(1)
                case .Hourly:
                    total += (p.job!.calculateIncome(2000))
                }
            }
            
        }
        return total
    }
}





