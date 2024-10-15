Here's a comprehensive guide on managing ReactJS dependencies, presented in a formatted Markdown style:

# Managing ReactJS Dependencies

## Checking Current Dependencies

To check the current dependencies of your ReactJS project:

1. Open your project's root directory in the terminal.
2. Run the following command:

```bash
npm list --depth=0
```

This will display a tree structure of your direct dependencies and their versions.

For a more detailed view, you can use:

```bash
npm list
```

> **Tip**: Add `--json` flag for JSON output: `npm list --json`

## Adding Dependencies

To add a new dependency to your ReactJS project:

```bash
npm install <package-name>
```

Example:
```bash
npm install react-router-dom
```

| Flag | Description | Example |
|------|-------------|---------|
| `--save-prod` | Add as production dependency (default) | `npm install --save-prod axios` |
| `--save-dev` | Add as development dependency | `npm install --save-dev jest` |
| `--no-save` | Install without adding to package.json | `npm install --no-save lodash` |

## Removing Dependencies

To remove a dependency from your ReactJS project:

```bash
npm uninstall <package-name>
```

Example:
```bash
npm uninstall moment
```

> **Tip**: Use `--save` or `--save-dev` flags to ensure the package is removed from `package.json` as well.

## Upgrading Dependencies

To upgrade a specific dependency:

```bash
npm update <package-name>
```

To upgrade all dependencies to their latest versions:

```bash
npm update
```

For major version upgrades, use:

```bash
npm install <package-name>@latest
```

## Downgrading Dependencies

To downgrade a dependency to a specific version:

```bash
npm install <package-name>@<version>
```

Example:
```bash
npm install react-router-dom@5.2.0
```

---

### Visualizing Dependency Tree

For a visual representation of your dependency tree, you can use the `npm-dependency-tree` package:

1. Install globally:
   ```bash
   npm install -g npm-dependency-tree
   ```

2. Run in your project directory:
   ```bash
   npm-dependency-tree
   ```

This will generate a graphical representation of your dependencies.

---

Remember to always run `npm install` after making changes to your `package.json` file to ensure your `node_modules` directory is in sync with your declared dependencies.