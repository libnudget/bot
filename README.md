<p align="center">
<img src="assets/avatar.png" width="200px">
</p>
<h1 align="center">libnudget bot</h1>
<p align="center">A programmable GitHub bot for automated commits.</p>

<p align="center">
<a href="./LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
</p>

<br>

The goal of this project is to provide a single, auditable automation identity for the libnudget organization. Instead of hardcoding bot credentials across multiple repositories, this repo centralizes the bot configuration and provides reusable actions.

This bot is designed for students learning about GitHub Actions and automation. It demonstrates how to create a reusable commit action that can be consumed by any repository.

<br>

# Table of Contents

<!-- vim-markdown-toc GFM -->

* [OVERVIEW](#overview)
* [IDENTITY](#identity)
* [HOW IT WORKS](#how-it-works)
* [USAGE](#usage)
    * [GitHub Action](#github-action)
    * [Local Scripts](#local-scripts)
* [CONFIGURATION](#configuration)
* [FILES](#files)
* [AVATAR](#avatar)
* [PRIVACY](#privacy)

<!-- vim-markdown-toc -->

<br>

<!-- CHAPTER START -->
# OVERVIEW

libnudget bot is an automated commit identity for the libnudget organization. It allows repositories to make commits using a consistent bot identity without hardcoding credentials.

Key features:
- Reusable GitHub Action for commits
- Configurable bot identity via environment variables
- Custom avatar support through Gravatar
- No infrastructure required
- Single source of truth for bot behavior

<!-- CHAPTER END -->

<!-- CHAPTER START -->
# IDENTITY

The bot uses the following identity:

| Field | Value |
| ----- | ----- |
| Name | `libnudget[bot]` |
| Email | `$BOT_EMAIL` (configurable) |

The identity is set in each script:

```bash
git config user.name "libnudget[bot]"
git config user.email "$BOT_EMAIL"
```

This ensures all commits from the bot are consistent and traceable.

<!-- CHAPTER END -->

<!-- CHAPTER START -->
# HOW IT WORKS

The system works in two ways:

## GitHub Actions

When used as a GitHub Action:

1. Repository configures `BOT_EMAIL` in GitHub secrets/variables
2. Workflow calls the reusable action
3. Action sets git config using the email
4. Commit is made with bot identity
5. GitHub links email to Gravatar, displaying the avatar

```yaml
- uses: libnudget/bot/actions/commit@v1
  with:
    message: "chore: update dependencies"
```

## Local Scripts

For local development:

1. Set `BOT_EMAIL` environment variable
2. Run configuration script
3. Make commits normally

```bash
export BOT_EMAIL="your@email.com"
./scripts/configure-git.sh
git commit -m "chore: update file"
```

<!-- CHAPTER END -->

<!-- CHAPTER START -->
# USAGE

## GitHub Action

Add to your workflow:

```yaml
name: automated commit

on:
  workflow_dispatch:

jobs:
  commit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: libnudget/bot/actions/commit@v1
        with:
          message: "chore: automated update"
        env:
          BOT_EMAIL: ${{ vars.BOT_EMAIL }}
```

Requires setting `BOT_EMAIL` in repository settings.

## Local Scripts

### Configure Git

```bash
export BOT_EMAIL="your@email.com"
./scripts/configure-git.sh
```

### Make a Commit

```bash
./scripts/commit.sh "chore: your message"
```

### Create a Release

```bash
./scripts/release.sh v1.0.0
```

<!-- CHAPTER END -->

<!-- CHAPTER START -->
# CONFIGURATION

## GitHub Repository

1. Go to repository **Settings**
2. Navigate to **Secrets and variables** → **Actions**
3. Add new variable:
   - Name: `BOT_EMAIL`
   - Value: your Gravatar email

## Environment Variable

| Variable | Required | Description |
|----------|----------|-------------|
| `BOT_EMAIL` | Yes | Email for commit identity and avatar |

Set locally:

```bash
export BOT_EMAIL="your@email.com"
```

<!-- CHAPTER END -->

<!-- CHAPTER START -->
# FILES

```
bot/
├── .github/workflows/
│   └── bot-self-test.yml    # Self-test workflow
├── actions/commit/
│   ├── action.yml           # Action definition
│   ├── entrypoint.sh       # Action logic
│   └── README.md           # Action documentation
├── scripts/
│   ├── configure-git.sh    # Set bot identity
│   ├── commit.sh           # Make commits
│   └── release.sh          # Create releases
├── docs/
│   └── IDENTITY.md        # Identity documentation
├── PRIVACY.md              # Privacy policy
└── README.md               # This file
```

<!-- CHAPTER END -->

<!-- CHAPTER START -->
# AVATAR

The bot avatar is fetched from Gravatar using the commit email.

## Setup

1. Register at [gravatar.com](https://gravatar.com)
2. Add the email you configured as `BOT_EMAIL`
3. Upload your desired avatar

## How It Works

GitHub links commits to Gravatar using the email address:

```
commit email → Gravatar lookup → display avatar
```

This means any email registered with Gravatar will display that avatar on commits.

<!-- CHAPTER END -->

<!-- CHAPTER START -->
# PRIVACY

This bot only performs automated commits on behalf of the libnudget organization.

## What the bot does

- Creates commits in repositories where it is configured
- Uses a dedicated identity for all automated actions
- Does not collect, store, or process any personal data

## Data handling

- All activity is limited to git commits within the organization
- No external data collection
- No third-party services receive data from this bot

## Questions

For any questions about this bot's behavior, please open an issue in the repository.

<!-- CHAPTER END -->

# AFTERWORD

This project is designed for educational purposes. Students can learn how to:
- Create reusable GitHub Actions
- Configure automated commit identities
- Set up Gravatar integration
- Build automation tooling

Feel free to fork and modify for your own use cases!
