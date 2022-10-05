CREATE MIGRATION m12ns4uqfb53dacxe4a4vzp2pkkuyv77ihjgiluhlgu2tj3wbpufra
    ONTO m1gp7kskar5o75i6s3zw5hmbw6qqbocq7n5x7wslt3txpzanhkvcvq
{
  ALTER TYPE default::Person {
      CREATE PROPERTY Age -> std::int32;
  };
  ALTER TYPE default::Person {
      ALTER PROPERTY email {
          RENAME TO Email;
      };
  };
  ALTER TYPE default::Person {
      ALTER PROPERTY name {
          RENAME TO Name;
      };
  };
};
