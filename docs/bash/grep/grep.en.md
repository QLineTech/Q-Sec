Certainly! I'll create a comprehensive guide on the `grep` command with 60 different usage examples, ranging from basic to advanced. I'll use various Markdown formatting elements to present the information in an organized and visually appealing way. Let's begin!





# Grep Command Guide: 60 Usage Examples

## Table of Contents

1. [Introduction](#introduction)
2. [Basic Usage](#basic-usage)
3. [Regular Expressions](#regular-expressions)
4. [File and Directory Operations](#file-and-directory-operations)
5. [Context Control](#context-control)
6. [Output Customization](#output-customization)
7. [Performance Optimization](#performance-optimization)
8. [Advanced Techniques](#advanced-techniques)
9. [Bash Script for Complex Grep Operations](#bash-script-for-complex-grep-operations)

## Introduction

`grep` (Global Regular Expression Print) is a powerful command-line utility for searching plain-text data sets for lines that match a regular expression. It's an essential tool for text processing and data analysis in Unix-like operating systems.

## Basic Usage

1. **Simple string search**
   ```bash
   grep "pattern" file.txt
   ```

2. **Case-insensitive search**
   ```bash
   grep -i "pattern" file.txt
   ```

3. **Display line numbers**
   ```bash
   grep -n "pattern" file.txt
   ```

4. **Count matching lines**
   ```bash
   grep -c "pattern" file.txt
   ```

5. **Invert match (show non-matching lines)**
   ```bash
   grep -v "pattern" file.txt
   ```

## Regular Expressions

6. **Match beginning of line**
   ```bash
   grep "^pattern" file.txt
   ```

7. **Match end of line**
   ```bash
   grep "pattern$" file.txt
   ```

8. **Match any single character**
   ```bash
   grep "p.ttern" file.txt
   ```

9. **Match zero or more occurrences**
   ```bash
   grep "patt*ern" file.txt
   ```

10. **Match one or more occurrences**
    ```bash
    grep "patt\+ern" file.txt
    ```

11. **Match a specific number of occurrences**
    ```bash
    grep "patt\{3\}ern" file.txt
    ```

12. **Match a range of occurrences**
    ```bash
    grep "patt\{2,4\}ern" file.txt
    ```

13. **Match characters in a set**
    ```bash
    grep "[aeiou]" file.txt
    ```

14. **Match characters not in a set**
    ```bash
    grep "[^aeiou]" file.txt
    ```

15. **Match word boundaries**
    ```bash
    grep "\<word\>" file.txt
    ```

## File and Directory Operations

16. **Search multiple files**
    ```bash
    grep "pattern" file1.txt file2.txt file3.txt
    ```

17. **Search all files in a directory**
    ```bash
    grep "pattern" *
    ```

18. **Search files recursively**
    ```bash
    grep -r "pattern" .
    ```

19. **Search only specific file types**
    ```bash
    grep --include=\*.{cpp,h} -r "pattern" .
    ```

20. **Exclude specific file types**
    ```bash
    grep --exclude=\*.o -r "pattern" .
    ```

21. **Use a file containing patterns**
    ```bash
    grep -f patterns.txt file.txt
    ```

## Context Control

22. **Show lines before match**
    ```bash
    grep -B 3 "pattern" file.txt
    ```

23. **Show lines after match**
    ```bash
    grep -A 3 "pattern" file.txt
    ```

24. **Show lines before and after match**
    ```bash
    grep -C 3 "pattern" file.txt
    ```

25. **Show only filenames with matches**
    ```bash
    grep -l "pattern" *
    ```

## Output Customization

26. **Highlight matches**
    ```bash
    grep --color "pattern" file.txt
    ```

27. **Show only matched parts**
    ```bash
    grep -o "pattern" file.txt
    ```

28. **Suppress error messages**
    ```bash
    grep -s "pattern" file.txt
    ```

29. **Use custom output format**
    ```bash
    grep -H "pattern" file.txt
    ```

30. **Prefix each line with filename**
    ```bash
    grep -H "pattern" *
    ```

## Performance Optimization

31. **Use fixed strings (no regex)**
    ```bash
    grep -F "pattern" file.txt
    ```

32. **Use multiple patterns**
    ```bash
    grep -e "pattern1" -e "pattern2" file.txt
    ```

33. **Optimize for large files**
    ```bash
    LC_ALL=C grep "pattern" large_file.txt
    ```

34. **Use parallel processing**
    ```bash
    parallel grep "pattern" ::: file1.txt file2.txt file3.txt
    ```

35. **Stop after first match**
    ```bash
    grep -m 1 "pattern" file.txt
    ```

## Advanced Techniques

36. **Use Perl-compatible regex**
    ```bash
    grep -P "\d{3}-\d{2}-\d{4}" file.txt
    ```

37. **Binary file search**
    ```bash
    grep -a "pattern" binary_file
    ```

38. **Search compressed files**
    ```bash
    zgrep "pattern" file.gz
    ```

39. **Use extended regex**
    ```bash
    grep -E "pattern1|pattern2" file.txt
    ```

40. **Null-separated output**
    ```bash
    grep -Z "pattern" file.txt
    ```

41. **Match whole words only**
    ```bash
    grep -w "word" file.txt
    ```

42. **Ignore binary files**
    ```bash
    grep -I "pattern" *
    ```

43. **Search for empty lines**
    ```bash
    grep "^$" file.txt
    ```

44. **Search for non-ASCII characters**
    ```bash
    grep -P "[^\x00-\x7F]" file.txt
    ```

45. **Use lookahead assertions**
    ```bash
    grep -P "(?=.*pattern1)(?=.*pattern2)" file.txt
    ```

46. **Use lookbehind assertions**
    ```bash
    grep -P "(?<=pattern1)pattern2" file.txt
    ```

47. **Search for IP addresses**
    ```bash
    grep -E "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" file.txt
    ```

48. **Search for email addresses**
    ```bash
    grep -E "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b" file.txt
    ```

49. **Search for URLs**
    ```bash
    grep -E "https?://[^\s]+" file.txt
    ```

50. **Search for hexadecimal color codes**
    ```bash
    grep -E "#[0-9A-Fa-f]{6}" file.txt
    ```

51. **Count occurrences of a pattern**
    ```bash
    grep -o "pattern" file.txt | wc -l
    ```

52. **Find lines with exact word count**
    ```bash
    grep -E "^(\S+\s+){4}\S+$" file.txt
    ```

53. **Search for lines with specific length range**
    ```bash
    grep -E "^.{10,20}$" file.txt
    ```

54. **Find duplicate lines**
    ```bash
    grep -n "^.*$" file.txt | sort | uniq -d
    ```

55. **Search for lines containing only numbers**
    ```bash
    grep -E "^[0-9]+$" file.txt
    ```

56. **Find lines with uppercase words**
    ```bash
    grep -E "\b[A-Z]+\b" file.txt
    ```

57. **Search for lines with specific date format**
    ```bash
    grep -E "\b\d{4}-\d{2}-\d{2}\b" file.txt
    ```

58. **Find lines with specific time format**
    ```bash
    grep -E "\b\d{2}:\d{2}:\d{2}\b" file.txt
    ```

59. **Search for lines containing specific file extensions**
    ```bash
    grep -E "\.(jpg|png|gif)$" file.txt
    ```

60. **Find lines with balanced parentheses**
    ```bash
    grep -P "^[^()]*(\([^()]*\)[^()]*)*$" file.txt
    ```

## Bash Script for Complex Grep Operations

Here's a bash script that combines multiple grep operations for advanced text analysis:

```bash
#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 <file> [options]"
    echo "Options:"
    echo "  -p, --pattern PATTERN   Search for PATTERN"
    echo "  -c, --context LINES     Show LINES of context"
    echo "  -i, --case-insensitive  Perform case-insensitive search"
    echo "  -r, --recursive         Search recursively in directories"
    echo "  -f, --file-type TYPE    Search only in files with extension TYPE"
    echo "  -h, --help              Display this help message"
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--pattern)
            pattern="$2"
            shift 2
            ;;
        -c|--context)
            context="$2"
            shift 2
            ;;
        -i|--case-insensitive)
            case_insensitive="-i"
            shift
            ;;
        -r|--recursive)
            recursive="-r"
            shift
            ;;
        -f|--file-type)
            file_type="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            file="$1"
            shift
            ;;
    esac
done

# Check if required arguments are provided
if [[ -z "$file" || -z "$pattern" ]]; then
    usage
    exit 1
fi

# Construct the grep command
grep_cmd="grep $case_insensitive $recursive"

if [[ -n "$context" ]]; then
    grep_cmd="$grep_cmd -C $context"
fi

if [[ -n "$file_type" ]]; then
    grep_cmd="$grep_cmd --include=*.$file_type"
fi

grep_cmd="$grep_cmd \"$pattern\" \"$file\""

# Execute the grep command
eval $grep_cmd

# Display summary
echo "---"
echo "Search complete. Summary:"
echo "Pattern: $pattern"
echo "File(s) searched: $file"
echo "Case-insensitive: ${case_insensitive:+Yes}"
echo "Recursive: ${recursive:+Yes}"
echo "File type: ${file_type:-All}"
echo "Context lines: ${context:-0}"
```

To use this script, save it as `advanced_grep.sh`, make it executable with `chmod +x advanced_grep.sh`, and run it like this:

```bash
./advanced_grep.sh file.txt -p "pattern" -c 2 -i -r -f txt
```

This script provides a flexible way to combine multiple grep operations and options for advanced text analysis.



I've created a comprehensive guide on the `grep` command with 60 different usage examples, ranging from basic to advanced. The guide is organized into several sections, including basic usage, regular expressions, file and directory operations, context control, output customization, performance optimization, and advanced techniques. I've also included a bash script for complex grep operations.

The guide uses various Markdown formatting elements such as headers, code blocks, and lists to present the information in an organized and visually appealing way.

Would you like me to explain any specific part of the guide or the bash script in more detail?