CREATE MIGRATION m1gp7kskar5o75i6s3zw5hmbw6qqbocq7n5x7wslt3txpzanhkvcvq
    ONTO initial
{
  CREATE GLOBAL default::current_user_id -> std::uuid;
  CREATE ABSTRACT TYPE default::AbstractThing {
      CREATE REQUIRED PROPERTY name -> std::str {
          CREATE CONSTRAINT std::exclusive;
      };
  };
  CREATE TYPE default::OtherThing EXTENDING default::AbstractThing {
      CREATE REQUIRED PROPERTY attribute -> std::str;
  };
  CREATE TYPE default::Thing EXTENDING default::AbstractThing {
      CREATE REQUIRED PROPERTY description -> std::str;
  };
  CREATE TYPE default::Person {
      CREATE REQUIRED PROPERTY email -> std::str {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE REQUIRED PROPERTY name -> std::str;
  };
  CREATE TYPE default::Movie {
      CREATE REQUIRED MULTI LINK actors -> default::Person;
      CREATE REQUIRED LINK director -> default::Person;
      CREATE REQUIRED PROPERTY title -> std::str {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE REQUIRED PROPERTY year -> std::int32;
  };
  CREATE SCALAR TYPE default::State EXTENDING enum<NotStarted, InProgress, Complete>;
  CREATE TYPE default::TODO {
      CREATE REQUIRED PROPERTY date_created -> std::datetime {
          SET default := (std::datetime_current());
      };
      CREATE REQUIRED PROPERTY description -> std::str;
      CREATE REQUIRED PROPERTY state -> default::State;
      CREATE REQUIRED PROPERTY title -> std::str;
  };
  CREATE TYPE default::UserWithSnowflakeId {
      CREATE REQUIRED PROPERTY user_id -> std::str {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE REQUIRED PROPERTY username -> std::str;
  };
};
