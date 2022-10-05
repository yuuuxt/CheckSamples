#load "../.paket/load/EdgeDB.Net.Driver.fsx"

open EdgeDB

// basic client
let client = EdgeDBClient()

// querying a string
client.QuerySingleAsync<string>("SELECT \"Hello, World!\"")

let result1 =
    task {
        let! result = client.QuerySingleAsync<string>("SELECT \"Hello, World!\"")
        return result
    }

result1
|> Async.AwaitTask
|> Async.RunSynchronously

// querying a type
type Person = { Name: string; Email: string; Age: int option }

let result2 =
    task {
        let! result = client.QueryAsync<Person>("SELECT Person { Name, Email, Age }")
        return result
    }

result2
|> Async.AwaitTask
|> Async.RunSynchronously
