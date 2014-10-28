
## User temporary directory rotation

* Creates a rotating directory structure for user temporary files

    ~/tmp/YYYY/MM/

* Provides shortcut links to the current and previous month directory

    ~/tmp/current aka ~/tmp/0

    ~/tmp/previous aka ~/tmp/1

## Usage

1. Download the script user-tmp-rotate.sh, or clone this repo.
2. Source the script in your .bashrc or .zshrc (or similar), e.g.

    ```bash
    source ~/bin/user-tmp-rotate.sh
    ```

3. Run the command

    ```bash
    user-tmp-rotate
    ```
