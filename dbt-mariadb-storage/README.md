# DBT MariaDB Storage Project

This project is designed to manage two tables, `hot_storage` and `cold_storage`, using DBT (Data Build Tool) with a MariaDB backend. The primary goal is to append newly inserted rows from `hot_storage` to `cold_storage` while checking for modifications based on the `id` and `timestamp` fields, without propagating deletions.

## Project Structure

- **dbt_project.yml**: Configuration settings for the DBT project, including project name, version, and model configurations.
- **profiles.yml**: Connection settings for the MariaDB database, including host, user, password, and database name.
- **models/**: Contains SQL files for staging and transformation models.
  - **staging/**: 
    - `hot_storage_source.sql`: Staging model for `hot_storage`.
    - `cold_storage_source.sql`: Staging model for `cold_storage`.
  - **marts/core/**:
    - `hot_storage.sql`: Model for processing data from `hot_storage`.
    - `cold_storage_incremental.sql`: Incremental model for appending new rows from `hot_storage` to `cold_storage`.
- **macros/**: Contains reusable SQL macros.
  - `mariadb_incremental.sql`: Macro for implementing incremental loading logic.
- **snapshots/**: 
  - `hot_storage_snapshot.sql`: Snapshot of the `hot_storage` table for auditing purposes.
- **tests/**: 
  - `test_hot_cold_consistency.sql`: Tests to ensure data consistency between `hot_storage` and `cold_storage`.
- **.gitignore**: Specifies files and directories to be ignored by Git.

## Setup Instructions

1. **Clone the Repository**: 
   ```bash
   git clone <repository-url>
   cd dbt-mariadb-storage
   ```

2. **Install DBT**: Follow the installation instructions for DBT on the official website.

3. **Configure Database Connection**: Update the `profiles.yml` file with your MariaDB connection details.

4. **Run DBT Models**: 
   ```bash
   dbt run
   ```

5. **Run Tests**: 
   ```bash
   dbt test
   ```

## Usage

- The `hot_storage` table is used for real-time data ingestion.
- The `cold_storage` table serves as a historical repository of data, updated incrementally.
- Use the provided tests to ensure data integrity and consistency between the two tables.

## Additional Information

For more details on DBT and its capabilities, refer to the [DBT Documentation](https://docs.getdbt.com/).