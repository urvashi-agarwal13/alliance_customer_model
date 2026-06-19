# Alliance Customer Model - dbt Data Vault Assignment

This repository implements a simple Data Vault model using dbt Cloud and PostgreSQL.

## What is included

- Hubs: `hub_customer`, `hub_product`
- Link: `link_customer_product`
- Satellites: `sat_customer`, `sat_product`
- Raw layer: seed data in `seeds/`
- Tests: built-in and custom dbt tests
- Documentation: model descriptions in `models/schema.yml`

## Project structure

- `dbt_project.yml` - dbt project configuration
- `models/` - dbt SQL models under `staging/` and `datavault/`
- `seeds/` - sample raw data tables
- `tests/` - custom dbt test SQL files
- `README.md` - project instructions

## How to run with dbt Cloud

1. Connect this repository to dbt Cloud:
   - Sign in to [dbt Cloud](https://cloud.getdbt.com/)
   - Create a new project and connect it to this repository via Git (GitHub, GitLab, or Azure DevOps).

2. Configure a dbt Cloud environment:
   - Create a development environment with a PostgreSQL connection to the `DEV` database.
   - Specify the `SALES` schema in the environment settings.
   - Add your database credentials securely in dbt Cloud.

3. Run commands in dbt Cloud:

   **In dbt Cloud IDE (web-based development):**
   ```bash
   dbt seed
   dbt run
   dbt test
   dbt docs generate
   ```

   **Or via dbt Cloud jobs (automated runs):**
   - Create a job with commands: `dbt seed && dbt run && dbt test && dbt docs generate`
   - Set a schedule or trigger manually from the dbt Cloud dashboard.

## Database setup

This project uses seed files to create a raw layer with `customers`, `products`, and `customer_products`.
The dbt models transform those inputs into Data Vault tables in the `DEV.SALES` schema.

## Notes on YAML setup

- `dbt_project.yml` configures where dbt finds models and seeds, and specifies `database: DEV` and `schema: SALES`.
- `models/schema.yml` contains model descriptions, column metadata, and tests.
- Use `ref()` to build dependency-aware SQL transformations.

## dbt Cloud Features

- **IDE**: Write and test SQL models in the web-based IDE without local setup.
- **Jobs**: Schedule and run transformations automatically on a cadence.
- **Documentation**: Auto-generated and hosted in dbt Cloud.
- **Lineage**: View data lineage and dependencies across models.
- **Slack Integration**: Receive job status notifications in Slack.
