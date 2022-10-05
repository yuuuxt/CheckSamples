#load "../.paket/load/EdgeDB.Net.Driver.fsx"

open EdgeDB


// creating a config
let mutable config = new EdgeDBClientConfig()
config.SchemaNamingStrategy <- INamingStrategy.SnakeCase

let client = new EdgeDBClient(config)

// polymorphic types
type Content = {
  Title: string option
}

type Movie = {
  inherit Content
  ReleaseYear: int64
}

type TVShow = {
  inherit Content
  Seasons: int64
}

let content = client.QueryAsync<Content>("SELECT Content")

let shows = content.Where(fun x -> x :? TVShow).Cast<TVShow>()
let movies = content.Where(fun x -> x :? Movie).Cast<Movie>()

// type with attributes
type Person = {
  [<EdgeDBProperty("name")>]
  Name: string option

  [<EdgeDBProperty("age")>]
  Age: int
}

// method and constructor deserializers
type PersonTwo(name : string, email : string) =
      class
      member this.Name with get() = name
      member this.Email with get() = email

      // constructor
      [<EdgeDBDeserializer()>]
      new(data: IDictionary<string, obj>) =
        let name = (string)data["name"]
        let email = (string)data["email"]
        PersonTwo(name,email)
      end

      // method
      [<EdgeDBDeserializer()>]
      member this.Deserialize(data : IDictionary<string, obj>) =
        this.Name <- string data["name"]
        this.Email <- string data["email"]
        
// type builder delegates
type Person(name: string, age: int32) =
      member this.Name with get() = name
      member this.Age with get() = age

    TypeBuilder.AddOrUpdateTypeBuilder<Person>(fun person data -> 
      person.Name <- string data["name"]
      person.Age <- data["age"] :?> int32
    )

    TypeBuilder.AddOrUpdateTypeFactory<Person>(fun (ref ObjectEnumerator enumerator) ->
      let data = enumerator.ToDynamic()

      Person(string data["name"], data["age"] :?> int32)
    )