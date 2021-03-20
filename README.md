# TicTacToe

## Setup

**Optional** To run a minimal set of tests before you push run follolin in root folder.

⚠️ will overwrite whatever is in the pre-push, if you have a pre-push append rather then running this command.

```bash
mv .git/hooks/pre-push.sample .git/hooks/pre-push && echo '#!/bin/bash' > .git/hooks/pre-push && echo 'swift test --package-path TicTacToe/Shared/SharedPackage' >> .git/hooks/pre-push
```
