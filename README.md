# TicTacToe

[Releases](https://github.com/kata-me/TicTacToe/releases) can be found in Github. If you do not want to build the project you can just download the TicTacToe.app.zip which runs on a mac. It is a notarized app so you will receive 1 pop-up to allow it to install and then you should be good to go.

The structure of the project is as many code as possible in the `SharedPackage`. That package contains a SPM package that can run the logic tests continuously and fast (more in [Building](Building)).

The `TicTacToe/TicTacToe.xcodeproj/` contains several targets:

- TicTacToe (iOS) = runs Unit tests and some basic application launch test on iPhone simulator and runs the app on an IOS device for you to play
- TicTacToe (macOS) = runs on macOS and also runs unit tests and some basic application tests

## Checkout

For conveniency of the example and as most of the TDD is done in TicTacToeKit we suggest to run the project by checking out 2 repos from git. 

Folder structure like this:

```
┌───────────────┐
│~/<#Developer#>│
└─────┬─────────┘
    │ │
    │ │   ┌─────────────────────────────────────────────────────────────────────────────┐
    │ └───│TicTacToe = https://github.com/kata-me/TicTacToeKit/releases/tag/1.O.0       │
    │     └─────────────────────────────────────────────────────────────────────────────┘
    │     ┌─────────────────────────────────────────────────────────────────────────────┐
    └─────│TicTacToeKit = https://github.com/kata-me/TicTacToe/releases/tag/1.0.0       │
          └─────────────────────────────────────────────────────────────────────────────┘
```

If you only want one project remove from `TicTacToe.xcodeproj` the reverence folder `TicTacToeKit` and xcode will check out using SPM depency management.

Take a look ate the [Releases](https://github.com/kata-me/TicTacToe/releases) to get big picture of steps taken. 

The local SPM package approach is mainly handy for development. As of version 1.0.0 it could be chosen to only. checking TicTacToe as TicTacTooKit will remain maybe stable. The main reason a swift package was chosen was to make build and running test a lot faster during development. 

The largest part of the tests are logic tests, by separating into a SPM package these tests can be ran fast on a mac every time, for example before pushing.

## Building

Requirements are

- macOS 11 or more
- iOS 14.1 or more

```bash
open TicTacToe/TicTacToe.xcodeproj/
```

Select scheme to run and target to run it on, and hit run.

### Testing

In the same project select scheme and hit `cmd+u` to run all tests. 

To run only logic test (faster) select scheme `TicTacToeKit` and `cmd+u`.

#### Setup pre-push hook

**Optional** To run a minimal set of tests before you push run following command in root folder.

⚠️ will overwrite whatever is in the pre-push, if you have a pre-push append rather then running this command.

```bash
mv .git/hooks/pre-push.sample .git/hooks/pre-push && echo '#!/bin/bash' > .git/hooks/pre-push && echo 'xcodebuild -scheme "TicTacToe (macOS)" test' >> .git/hooks/pre-push
```
