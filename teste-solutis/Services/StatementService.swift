//
//  ExtratoService.swift
//  teste-solutis
//
//  Created by Virtual Machine on 03/09/21.
//

import Foundation

protocol StatementServiceDelegate {
    func didUpdateExtract(_ statementService: StatementService, statementList: [StatementModel])
    func didFailWithoutError(_ statementService: StatementService, message: String)
    func didFailWithError(_ statementService: StatementService, error: Error)
}

class StatementService {
    var delegate: StatementServiceDelegate?
    
    let apiUrl = NSLocalizedString("ApiURL", comment: "")
    
    func getExtract(token: String) {
        let url = apiUrl + "extrato"
        performRequest(with: url, token: token)
    }
    
    func performRequest(with urlString: String, token: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "token")
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(self, error: error!)
                    return
                }
                
                if (response as! HTTPURLResponse).statusCode > 299 {
                    self.delegate?.didFailWithoutError(self, message: "Ocorreu um erro desconhecido")
                    return
                }
                
                if let safeData = data {
                    if let extractList = self.parseJson(safeData) {
                        self.delegate?.didUpdateExtract(self, statementList: extractList)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(_ data: Data) -> [StatementModel]? {
        do {
            let statementData = try JSONDecoder().decode([StatementData].self, from: data)
            var statementList: [StatementModel] = []
            
            for item in statementData {
                let statement = StatementModel(description: item.descricao, value: item.valor, date: item.data)
                statementList.append(statement)
            }
            
            return statementList
        } catch {
            delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
}
