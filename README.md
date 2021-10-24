# Mapper between UTF-8 compliant characters

### Summary
- Given a string, convert each of character to another character as specified by the character mappings in `mappings.csv`.


### Installation

1. Use `git clone` to clone the repository to your local machine
2. CD into the folder, run `stack init` and `stack install`. This will install an executable somewhere in your machine depending on your Operating System.

### Usage
1. Create a new folder on your Desktop and place the executable in the folder.
2. In that newly created folder, create a file called `mappings.csv`. `mappings.csv` must conform to the format below:
  - Each line must contain only 2 records. They two records must be separated by a comma.
  - Each record on each line must be a single character.
  - Each Character must be UTF-8 compliant.
  - The first record is the character to convert from, while the second record is the character to convert to.
3. See `sample_mappings.csv` as an example