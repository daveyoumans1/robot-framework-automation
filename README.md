# Robot Framework Automation

A Robot Framework test automation suite covering web UI and REST API scenarios, using SeleniumLibrary and RequestsLibrary. Targets [Sauce Demo](https://www.saucedemo.com) for UI tests and [ReqRes](https://reqres.in) for API tests.

## Features

- **Keyword-driven design** — layered keyword files (`common`, `web_keywords`, `api_keywords`) keep test cases readable and maintainable
- **Variable externalization** — all configurable values in `resources/variables/variables.robot`; override via CLI or environment without touching test files
- **Tag-based execution** — `smoke`, `regression`, `api`, `login`, `sorting`, `cart` tags enable targeted runs
- **Automatic screenshot on failure** — embedded in the HTML log for fast root-cause analysis
- **Built-in HTML reporting** — Robot Framework's `log.html` and `report.html` provide rich test results out of the box
- **GitHub Actions CI** — separate web and API jobs with artifact upload

## Project Structure

```
├── resources/
│   ├── keywords/
│   │   ├── common.robot          # Browser lifecycle, shared utilities
│   │   ├── web_keywords.robot    # Page-level keywords for Sauce Demo
│   │   └── api_keywords.robot    # API-level keywords for ReqRes
│   └── variables/
│       └── variables.robot       # All configurable values
├── tests/
│   ├── web/
│   │   ├── login_tests.robot
│   │   └── inventory_tests.robot
│   └── api/
│       └── user_api_tests.robot
└── .github/workflows/ci.yml
```

## Setup

```bash
pip install -r requirements.txt
```

## Running Tests

```bash
# All tests
robot tests/

# Web tests only (headed)
robot tests/web/

# Web tests headless
robot --variable HEADLESS:True tests/web/

# API tests only
robot tests/api/

# Smoke tests only
robot --include smoke tests/

# Specific output directory and log level
robot --outputdir results --loglevel DEBUG tests/
```

## Tags

| Tag | Description |
|---|---|
| `smoke` | Critical path — run on every commit |
| `regression` | Full regression suite |
| `login` | Login-related tests |
| `sorting` | Inventory sort tests |
| `cart` | Cart interaction tests |
| `api` | API tests |
| `auth` | Authentication tests |

## Variables

Override any variable from the CLI with `--variable NAME:value`:

| Variable | Default | Description |
|---|---|---|
| `BASE_URL` | `https://www.saucedemo.com` | Web app base URL |
| `BROWSER` | `chrome` | Browser to use |
| `HEADLESS` | `${False}` | Run headless |
| `API_BASE_URL` | `https://reqres.in/api` | API base URL |

## CI

GitHub Actions runs web and API suites in parallel jobs on every push and pull request. Test artifacts (log, report, screenshots) are retained for 7 days.
