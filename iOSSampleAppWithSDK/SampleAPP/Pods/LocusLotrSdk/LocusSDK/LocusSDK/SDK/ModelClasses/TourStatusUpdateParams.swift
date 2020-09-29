//
//  UserVisitStatusUpdateParams.swift
//  LocusSDK
//
//  Created by Karthik M N on 11/03/20.
//  Copyright © 2020 Karthik M N. All rights reserved.
//
import Foundation

public class TourStatusUpdateParams {

    var tourId: String
    var visitId: String
    var status: VisitStatusRequest.Status
    var checklistValues: [String: String]?

    public init(tourId: String, visitId: String, status: VisitStatusRequest.Status, checklist: [String: String]? =
        nil)
    {
        self.tourId = tourId
        self.visitId = visitId
        self.status = status
        self.checklistValues = checklist
    }
}
