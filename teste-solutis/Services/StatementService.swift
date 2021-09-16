//
//  ExtratoService.swift
//  teste-solutis
//
//  Created by Virtual Machine on 03/09/21.
//

import Foundation

enum StatementServiceError: String, Error {
    
    case invalidRequest = "Ocorreu um erro desconhecido ao fazer a requisição"
    case invalidParse = "Ocorreu um erro desconhecido ao processar os dados"
}

extension StatementServiceError: LocalizedError {
    var errorDescription: String? { return NSLocalizedString(rawValue, comment: "") }
}

class StatementService {
    
    private let apiUrl = NSLocalizedString("ApiURL", comment: "")
    
    func fetchStatements(token: String, completionHandler: @escaping (Result<[StatementModel], Error>) -> Void) {
        let urlString = apiUrl + "extrato"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "token")
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil {
                    completionHandler(.failure(StatementServiceError.invalidRequest))
                    return
                }
                
                if (response as! HTTPURLResponse).statusCode > 299 {
                    completionHandler(.failure(StatementServiceError.invalidRequest))
                    return
                }
                
                if let safeData = data {
                    if let statementList = self.parseJson(safeData) {
                        completionHandler(.success(statementList))
                    } else {
                        completionHandler(.failure(StatementServiceError.invalidParse))
                    }
                }
            }
            
            task.resume()
        }
    }
    
    private func parseJson(_ data: Data) -> [StatementModel]? {
        do {
            let statementData = try JSONDecoder().decode([StatementData].self, from: data)
            var statementList: [StatementModel] = []
            
            for item in statementData {
                let statement = StatementModel(description: item.descricao, value: item.valor, date: item.data)
                statementList.append(statement)
            }
            
            return statementList
        } catch {
            return nil
        }
    }
}
