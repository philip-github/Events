//
//  ViewControllerViewModel.swift
//  Events
//
//  Created by Philip Twal on 5/23/20.
//  Copyright © 2020 Philip Altwal. All rights reserved.
//

import Foundation


class ViewControllerVM {
    
    var sectionList : [String] = []
    typealias EventCompletionHandler = ([Event]?,Error?) -> Void
    
    func localDataApiCall(completionHandler : @escaping EventCompletionHandler){
        
        let data = APIManager.shared.callLocalData()
        if data != nil {
            APIManager.shared.parseLocalData(jsonData: data!) { (events, error) in
                if events != nil{
                    completionHandler(events,nil)
                }else{
                    completionHandler(nil,error)
                }
            }
        }
    }
    
    func generateSortedSections(events : [Event]) -> Dictionary<String,[Event]>{
        
        var setlist : Set<String> = []
        var list : [String] = []
        var dictValueList : [Event] = []
        var eventDict : Dictionary<String,[Event]> = [:]
        
        for i in events {
            var date = i.start!.split(separator: " ")
            date.remove(at: 3)
            date.remove(at: 3)
            let stringDate = date.joined(separator: " ")
            setlist.insert(stringDate)
        }
        
        setlist.forEach { (date) in
            list.append(date)
        }
    
        for i in 0...list.count - 1 {
            
            for event in events {
                var date = event.start!.split(separator: " ")
                date.remove(at: 3)
                date.remove(at: 3)
                let stringDate = date.joined(separator: " ")
                
                if stringDate == list[i]{
                    dictValueList.append(event)
                    eventDict[list[i]] =  dictValueList
                }
            }
            dictValueList = []
        }
        sortDates(dates : list)
        return sortEvents(events: eventDict)
    }

    func sortDates(dates : [String]){
        
        var dateList : [Date] = []
        var stringDateList : [String] = []
        
        let dateFormatterString = DateFormatter()
        dateFormatterString.dateStyle = .long
        dateFormatterString.timeStyle = .none
        dateFormatterString.locale = Locale(identifier: DateFormat.locale.rawValue)
        
        for i in dates{
            let date = dateFormatterString.date(from: i)
            
            if date != nil {
                dateList.append(date!)
            }
        }
        
        let sortedDateList = dateList.sorted{$0 > $1}
        
        sortedDateList.forEach { (date) in
            let stringDate = dateFormatterString.string(from: date)
            stringDateList.append(stringDate)
        }
        sectionList = stringDateList
    }
    
    
    func sortEvents(events : Dictionary<String,[Event]>) -> Dictionary<String,[Event]>{
        
        var timeList : Set<String> = []
        var eventsList : [Event] = []
        var eventDict : Dictionary<String,[Event]> = [:]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.formatedDate.rawValue
        
        for i in events{
            
            let key = i.key
            let myEvent = events[key]
            
            for val in myEvent!{
                let date = val.start!
                let formattedDate = dateFormatter.date(from: date)
                let formattedString = dateFormatter.string(from: formattedDate!)
                timeList.insert(formattedString)
            }
            
            let sortedTimeList = timeList.sorted{$0 < $1}
            
            for sortedDate in sortedTimeList{
                for val in myEvent!{
                    if val.start == sortedDate{
                        eventsList.append(val)
                    }
                }
                eventDict[key] = eventsList
            }
            eventsList = []
            timeList = []
        }
        return eventDict
    }
    // MARK:- identify algo not finished
//    func identifyConflict(sections : [String] , events : Dictionary<String,[Event]>){
//
//        let dateFormatter = DateFormatter()
//        for i in sections{
//
//            for val in events[i]!{
//
//                dateFormatter.dateFormat = "h:mm a"
//
//                let startDateSplit = val.start?.split(separator: " ")[3]
//                let startTime12format = val.start?.split(separator: " ")[4]
//
//                let endDateSplit = val.end?.split(separator: " ")[3]
//                let endTime12format = val.end?.split(separator: " ")[4]
//
//                let startTimeAsString = "\(startDateSplit ?? "") \(startTime12format ?? "")"
//                let endTimeAsString = "\(endDateSplit ?? "") \(endTime12format ?? "")"
//
//                let startDate = dateFormatter.date(from: startTimeAsString)
//                let endDate = dateFormatter.date(from: endTimeAsString)
//
//                dateFormatter.dateFormat = "HH:mm"
//
//                let startDate24 = dateFormatter.string(from: startDate!)
//                let endDate24 = dateFormatter.string(from: endDate!)
//
//
//            }
//        }
//    }
}
