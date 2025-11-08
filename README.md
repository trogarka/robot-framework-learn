# Robot Framework Career Page Tests

A beginner-friendly Robot Framework project that tests the Continero career page using Selenium WebDriver with Chrome in headless mode.

## Project Structure

```
robot-framework-learn/
├── requirements.txt           # Python dependencies with pinned versions
├── tests/
│   ├── test_open_page.robot      # Test 1: Open page validation
│   ├── test_career_images.robot  # Test 2: Gallery image verification
│   └── test_career_intro.robot   # Test 3: Introduction text verification
├── resources/
│   ├── variables.resource        # Shared variables (URLs, selectors, timeouts)
│   └── keywords.resource         # Reusable keywords and browser management
└── README.md
```

## Quick Start

### Prerequisites
- Python 3.8+ installed
- Chrome browser installed

### Installation

1. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

### Running Tests

#### Run all tests:
```bash
python -m robot tests
```

#### Run specific test file:
```bash
python -m robot tests/test_open_page.robot
python -m robot tests/test_career_images.robot
python -m robot tests/test_career_intro.robot
```

#### Run tests by tag:
```bash
# Run all regression tests (all 3 tests)
python -m robot --include regression tests

# Run only smoke tests
python -m robot --include smoke tests

# Run only gallery tests
python -m robot --include gallery tests
```

#### Generate HTML report:
```bash
python -m robot tests --output results/output.xml --log results/log.html --report results/report.html
```

## Test Overview

### Test 1: Open Career Page (`test_open_page.robot`)
- **Purpose**: Basic smoke test to verify page accessibility
- **Tags**: `regression`, `smoke`
- **Validations**: Page title contains "Career", URL contains "continero.com"

### Test 2: Gallery Image Verification (`test_career_images.robot`)
- **Purpose**: Verify photo gallery displays correctly
- **Tags**: `regression`, `gallery`, `images`
- **Validations**:
  - Exactly 16 gallery images present
  - Each image has non-empty `src` attribute
  - Images are visible and loaded

### Test 3: Introduction Text Verification (`test_career_intro.robot`)
- **Purpose**: Verify page content loads correctly
- **Tags**: `regression`, `content`, `introduction`
- **Validations**: Introduction text element exists and is visible

## Configuration

### Headless vs. Visible Browser

**Default**: Headless mode (no browser window visible)

To run tests with visible browser for debugging:
1. Edit `resources/variables.resource`
2. Change `${HEADLESS}` from `${True}` to `${False}`

### Timeout Settings

All tests use dynamic waits with 10-second timeout:
- `${WAIT_TIMEOUT}` = `10s`
- Adjust in `resources/variables.resource` if needed

### Browser Options

Chrome runs with these options for CI/CD compatibility:
- `--headless=new` - New headless mode
- `--no-sandbox` - Required for Linux containers
- `--disable-dev-shm-usage` - Prevents memory issues in containers

## 🛠️ Key Robot Framework Concepts Used

### Resource Files
- **`variables.resource`**: Centralizes all variables (URLs, selectors, timeouts)
- **`keywords.resource`**: Reusable actions and browser management

### Test Structure
- **Setup**: Opens browser before each test
- **Teardown**: Closes browser and captures screenshot on failure
- **Tags**: Used for test categorization and selective execution

### Dynamic Waits
- `Wait Until Element Is Visible` - Waits for elements to appear
- `Wait Until Page Contains` - Waits for text content
- No fixed `Sleep` commands - tests run as fast as possible

### Error Handling
- Automatic screenshots on test failure
- Descriptive error messages in assertions
- Detailed logging for debugging

## Debugging Tips

1. **Run with visible browser**: Set `${HEADLESS}` to `${False}`
2. **Check logs**: Look at `log.html` for detailed execution steps
3. **Screenshots**: Failed tests automatically capture screenshots
4. **Increase timeout**: Temporarily increase `${WAIT_TIMEOUT}` for slow networks

## Learning Points

This project demonstrates:
- **Good practices**: Resource files, descriptive keywords, proper cleanup
- **Robust testing**: Dynamic waits instead of fixed delays
- **Maintainability**: Variables for selectors and URLs
- **Error handling**: Screenshots on failure, clear error messages
- **Beginner-friendly**: Simple structure with helpful comments

## CI/CD Ready

The configuration is optimized for automated execution:
- Headless browser for server environments
- No interactive prompts
- Fast execution with minimal artificial delays
- Container-friendly Chrome options
