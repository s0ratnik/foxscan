## FoxScan - Automated XSS Scanner

FoxScan is a bash script that automates the process of discovering and scanning for XSS vulnerabilities in web applications. It combines the power of `gau` for URL discovery and `dalfox` for XSS scanning to provide comprehensive security testing.

```
███████╗  ██████╗  ██╗  ██╗  ██████╗   ██████╗  █████╗   ███╗   ██╗
██╔════╝ ██╔═══██╗ ╚██╗██╔╝ ██╔════╝  ██╔════╝ ██╔══██╗  ████╗  ██║
█████╗   ██║   ██║  ╚███╔╝  ╚█████╗   ██║      ███████║  ██╔██╗ ██║
██╔══╝   ██║   ██║  ██╔██╗    ╚═══██  ██║      ██╔══██║  ██║╚██╗██║
██║      ╚██████╔╝ ██╔╝ ██╗ ██████╔╝  ███████╗ ██║  ██║  ██║ ╚████║
╚═╝       ╚═════╝   ╚═╝  ╚═╝ ╚════╝   ╚══════╝ ╚═╝  ╚═╝  ╚═╝  ╚═══╝
```

## Features

- Automated URL discovery using `gau`
- Parameter extraction and processing
- XSS vulnerability scanning with `dalfox`
- Organized output directory structure
- Error handling and dependency checking

## Prerequisites

The following tools must be installed and available in your PATH:

- `gau` - GetAllUrls tool
- `dalfox` - Parameter analyzer and XSS scanner

## Installation

1. Clone this repository or download the script
2. Make the script executable:
```bash
chmod +x foxscan.sh
```

## Usage

```bash
./foxscan.sh <URL>
```

Example:
```bash
./foxscan.sh https://example.com
```

## Output Structure

The script creates a directory named `{domain}_scan_{timestamp}` containing:

- `result.txt`: Raw output from gau
- `processed_input.txt`: Processed URLs with extracted parameters
- `xss.txt`: Final XSS scan results from dalfox

## Process Flow

1. Checks for required dependencies (`gau` and `dalfox`)
2. Creates a timestamped output directory
3. Runs `gau` to discover URLs
4. Processes the URLs to extract parameters
5. Scans for XSS vulnerabilities using `dalfox`

## Configuration

The script uses the following dalfox configuration:
- `--skip-mining-dom`: Skips DOM mining for better performance
- `--worker 50`: Sets 50 concurrent workers

## Error Handling

The script includes error checking for:
- Missing dependencies
- Empty output files
- Invalid arguments

## Security Considerations

This tool is intended for security testing with proper authorization. Always ensure you have permission to test the target system.

## License

By contributing, you agree that your contributions will be licensed under its MIT License.
