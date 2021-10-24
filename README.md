Link to repository's master branch : https://github.com/kenho811/hs-char-mapper/tree/master

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

### Example
- Suppose we are using the mappings in the `sample_mappings.csv` file.
- When we run the executatable, we will be prompted to enter a line which we want to get translated.
- Each of the character in the line will then be translated by referencing the `mappings.csv` file.
- The image below shows the result in the Windows cmd terminal.

![image](https://user-images.githubusercontent.com/57944769/138584924-be81705c-f1f3-4988-b681-0bb4d54d71f3.png)
