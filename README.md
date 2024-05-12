# Ruby Bank Transaction Simulator

This project provides a simple simulation of bank transactions using Ruby, incorporating concepts like classes, modules, logging, and error handling.

## Description

The program simulates a basic banking system where transactions are processed for a set of users. Key features include:

- **User Management:**  Users have names and account balances.
- **Transaction Processing:** Transactions are created with a user and a value (amount).
- **Bank Logic:** The `CBABank` class implements the logic for processing transactions, including:
    - Checking if the user is associated with the bank.
    - Updating user balances.
    - Handling insufficient balance errors.
- **Logging:** The `Logger` module provides functions to log information, warnings, and errors to a file (`app.log`).
- **Callback Functionality:** A callback mechanism is used to simulate actions taken upon success or failure of a transaction.

## Usage

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   
2. **Run the Code::**
    ```bash
    ruby day2.rb

## Example Output

- **Terminal Output:**
  ![Screenshot 2024-05-12 211010](https://github.com/marwan-mohamed12/ITI_ruby_course/assets/40841193/36e66776-342a-4ff4-b631-4a68d4263df8)

- **file.log:**
  ![Screenshot 2024-05-12 211319](https://github.com/marwan-mohamed12/ITI_ruby_course/assets/40841193/f1489ef6-7b22-4671-bfd3-235fd9dcd01e)

