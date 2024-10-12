Certainly! I'll provide you with comprehensive information about the `sed` tool, including its purpose, parameters, installation, and usage examples, all formatted in Markdown.

# SED: Stream Editor

`sed` (Stream Editor) is a powerful text processing tool used for parsing and transforming text. It's commonly used in Unix-like operating systems for text manipulation tasks.

## What is sed?

`sed` is a non-interactive command-line utility that processes text line by line. It can perform various operations such as searching, find and replace, insertion, and deletion.

## Parameters

Here's a table of common `sed` parameters:

| Parameter | Description |
|-----------|-------------|
| `-n`      | Suppress automatic printing of pattern space |
| `-e`      | Add the script to the commands to be executed |
| `-f`      | Add the contents of script-file to the commands to be executed |
| `-i`      | Edit files in-place |
| `-r`      | Use extended regular expressions |

## How to Install

### On Unix-like systems (Linux, macOS)

`sed` is usually pre-installed on most Unix-like systems. If it's not available, you can install it using your package manager:

For Debian/Ubuntu:
```bash
sudo apt-get install sed
```

For macOS (using Homebrew):
```bash
brew install gnu-sed
```

### On Windows

For Windows, you can use:

1. Windows Subsystem for Linux (WSL)
2. Cygwin
3. Git Bash (comes with Git for Windows)

## Usage Examples

Here are 30+ explained `sed` command samples:

1. Print specific lines:
   ```bash
   sed -n '1p' file.txt  # Print first line
   ```

2. Delete specific lines:
   ```bash
   sed '1d' file.txt  # Delete first line
   ```

3. Replace text:
   ```bash
   sed 's/old/new/' file.txt  # Replace first occurrence of 'old' with 'new'
   ```

4. Replace all occurrences:
   ```bash
   sed 's/old/new/g' file.txt  # Replace all occurrences of 'old' with 'new'
   ```

5. Replace on specific lines:
   ```bash
   sed '1,5s/old/new/g' file.txt  # Replace on lines 1-5
   ```

6. Case-insensitive replacement:
   ```bash
   sed 's/old/new/gI' file.txt  # Case-insensitive replacement
   ```

7. Delete empty lines:
   ```bash
   sed '/^$/d' file.txt  # Delete empty lines
   ```

8. Delete lines matching a pattern:
   ```bash
   sed '/pattern/d' file.txt  # Delete lines containing 'pattern'
   ```

9. Insert text before a line:
   ```bash
   sed '2i\Inserted text' file.txt  # Insert before 2nd line
   ```

10. Append text after a line:
    ```bash
    sed '2a\Appended text' file.txt  # Append after 2nd line
    ```

11. Change whole line:
    ```bash
    sed '3c\New line content' file.txt  # Change 3rd line
    ```

12. Use multiple sed commands:
    ```bash
    sed -e 's/old/new/' -e 's/foo/bar/' file.txt
    ```

13. Read commands from a file:
    ```bash
    sed -f commands.sed file.txt
    ```

14. Print lines matching a pattern:
    ```bash
    sed -n '/pattern/p' file.txt
    ```

15. Print lines not matching a pattern:
    ```bash
    sed -n '/pattern/!p' file.txt
    ```

16. Replace with a backreference:
    ```bash
    sed 's/\(foo\)bar/\1baz/' file.txt  # Replace 'foobar' with 'foobaz'
    ```

17. Replace with multiple backreferences:
    ```bash
    sed 's/\(foo\)\(bar\)/\2\1/' file.txt  # Swap 'foo' and 'bar'
    ```

18. Use address ranges:
    ```bash
    sed '2,4d' file.txt  # Delete lines 2-4
    ```

19. Use regular expressions in address:
    ```bash
    sed '/start/,/end/d' file.txt  # Delete from 'start' to 'end'
    ```

20. Duplicate lines:
    ```bash
    sed 'p' file.txt  # Duplicate each line
    ```

21. Remove leading whitespace:
    ```bash
    sed 's/^[ \t]*//' file.txt
    ```

22. Remove trailing whitespace:
    ```bash
    sed 's/[ \t]*$//' file.txt
    ```

23. Remove comments:
    ```bash
    sed 's/#.*$//' file.txt  # Remove comments starting with #
    ```

24. Add line numbers:
    ```bash
    sed = file.txt | sed 'N;s/\n/\t/'
    ```

25. Convert DOS to Unix line endings:
    ```bash
    sed 's/\r$//' file.txt
    ```

26. Print only lines of certain length:
    ```bash
    sed -n '/^.\{20\}$/p' file.txt  # Print lines with exactly 20 characters
    ```

27. Replace in specific column:
    ```bash
    sed 's/\(.\{10\}\)old/\1new/' file.txt  # Replace 'old' with 'new' starting at 11th character
    ```

28. Reverse order of lines:
    ```bash
    sed '1!G;h;$p' file.txt
    ```

29. Remove duplicate lines (keeping order):
    ```bash
    sed '$!N; /^\(.*\)\n\1$/!P; D'
    ```

30. Uppercase conversion:
    ```bash
    sed 's/\(.*\)/\U\1/' file.txt
    ```

31. Lowercase conversion:
    ```bash
    sed 's/\(.*\)/\L\1/' file.txt
    ```

32. Replace only if pattern is found:
    ```bash
    sed '/foo/s/bar/baz/' file.txt  # Replace 'bar' with 'baz' only in lines containing 'foo'
    ```

These examples showcase the versatility and power of `sed`. Remember to always backup your files before performing in-place edits with `sed -i`.