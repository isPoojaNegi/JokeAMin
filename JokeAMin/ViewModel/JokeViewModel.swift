//
//  JokeViewModel.swift
//  JokeAMin
//
//  Created by Pooja on 10/06/23.
//

import Foundation
import Dispatch

class JokeViewModel {
    
    private var jokesArray : [JokesModel] = []
    private var timer : Timer?
    private let queue = DispatchQueue(label : "com.fetchAPI")
    
    var numberOfRows: Int {
        return jokesArray.count
    }
    
    var reloadData: (() -> Void)?
    
    func fetchData() {
        APIManager.shared.fetchJokesData { [weak self] joke in
            guard let `self` = self else {return}
            if self.jokesArray.count == 10 {
                self.jokesArray.remove(at: 0)
                self.jokesArray.append(joke)
            } else {
                self.jokesArray.append(joke)
            }
            self.reloadData?()
        }
    }
    
    func getDataEveryMinute() {
        if let savedJokes = UserDefaults.standard.array(forKey: "savedJokes") as? [String]{
            jokesArray = savedJokes.map{JokesModel(joke: $0)}
            self.reloadData?()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.fetchData()
        }
        // Start the timer
        timer?.fire()
    }
    
    func stopFetching() {
        var savedJokes = [String]()
        for i in jokesArray {
            savedJokes.append(i.joke)
        }
        UserDefaults.standard.set(savedJokes, forKey: "savedJokes")
        timer?.invalidate()
        timer = nil
    }
    
    func titleForRow(at index: Int) -> String {
        return jokesArray[index].joke
    }
}
