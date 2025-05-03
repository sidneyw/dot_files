# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "smart-open[s3]",
# ]
# ///

import json
import argparse
import sys
from smart_open import open
from itertools import islice


def read_pretty_print_jsonl_gz(file_path, num_lines, indent):
    """Read and pretty print JSONL records efficiently."""
    # Try to use ujson for faster parsing if available
    try:
        import ujson as json_parser
    except ImportError:
        json_parser = json

    def process_line(line):
        """Process a single JSON line with error handling."""
        try:
            json_obj = json_parser.loads(line)
            print(json_parser.dumps(json_obj, indent=indent))
            return True
        except json_parser.JSONDecodeError as e:
            print(f"Warning: Skipping invalid JSON line: {e}", file=sys.stderr)
            return False

    with open(file_path, "rt", encoding="utf-8") as file:
        for line in islice(file, num_lines):
            process_line(line)


def main():
    parser = argparse.ArgumentParser(
        description="Read and pretty-print JSONL records from a .jsonl.gz file."
    )
    parser.add_argument(
        "file",
        type=str,
        help="Path or S3 URL to the .jsonl.gz file",
    )

    parser.add_argument(
        "-n",
        "--num-lines",
        type=int,
        default=1,
        help="Number of lines to read and print from the file (default: 1)",
    )

    parser.add_argument(
        "-i",
        "--indent",
        type=int,
        default=0,
        help="Number of spaces to indent the JSON output",
    )

    args = parser.parse_args()

    # Execute the read function
    try:
        read_pretty_print_jsonl_gz(args.file, args.num_lines, args.indent)
    except Exception as e:
        print(f"Error reading the file: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()


