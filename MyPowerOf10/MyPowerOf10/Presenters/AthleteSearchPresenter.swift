//
//  AthleteSearchPresenter.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 06/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import TABResourceLoader

protocol AthleteSearchView: class {
    func updateLoadingState()
    func showError()
    func didRecieveResults(athletes: [AthleteResult])
}

final class AthleteSearchPresenter {
    
    public typealias SubmitAthleteSearchResourceService = GenericNetworkDataResourceService<SubmitAthleteSearchResource>
    private typealias SubmitAthleteSearchOperation = ResourceOperation<SubmitAthleteSearchResourceService>
    
    weak var view: AthleteSearchView?
    private let queue = OperationQueue()
    
    // MARK: - Internal
    
    func performSearch(firstname: String, surname: String, club: String) {
        let resource = SubmitAthleteSearchResource(firstname: firstname, surname: surname, club: club)
        let service = SubmitAthleteSearchResourceService()
        let athleteSearchOperation = SubmitAthleteSearchOperation(resource: resource, service: service) { [weak self] (service, result) in
          print(service)
          print(result)
            self?.handleAthleteSearchResult(result)
        }
        queue.addOperation(athleteSearchOperation)
    }
    
    private func handleAthleteSearchResult(_ result: NetworkResponse<SubmitAthleteSearchResource.Model>) {
        switch result {
        case .failure:
            print("FAILLLLL")
        case .success(let athletes, _):
            print(athletes)
        }
    }
    
}
