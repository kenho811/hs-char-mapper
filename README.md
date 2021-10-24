# Mapper between UTF-8 compliant characters

### Summary
- Given a string, convert each of the latin character to germanic character. Return the string


### Installation

1. Use `git clone` to clone the repository to your local machine
2. CD into the folder, run `stack init` and `stack install`. This will install an executable somewhere in your machine depending on your Operating System.

### Usage
1. Create a new folder on your Desktop and place the executable in the folder.
2. In that newly created folder, create a file called `mappings.csv`. `mappings.csv` must conform to the format below:
  - Each line must contain only 2 records. They two records must be separated by a comma.
  - Each record on each line must be a single character.
  - Each Character must be UTF-8 compliant.
3. See `sample_mappings.csv` as an example