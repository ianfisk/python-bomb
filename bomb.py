# Use https://pylingual.io/ to decompile.

import sys

def explode(message="BOOM!!! You failed to defuse the bomb."):
    print(f"\n{message}\n")
    sys.exit(1)

def phase_1(user_input):
    if user_input.strip() != "hello":
        explode("Phase 1 failed. Try again!")
    print("Phase 1 defused successfully!")

def phase_2(user_input):
    try:
        numbers = [int(x) for x in user_input.split()]
        if len(numbers) != 3:
            explode("Phase 2 failed. Expected 3 numbers.")

        a, b, c = numbers
        if a + b + c != 42 or a * b * c != 2744:
            explode("Phase 2 failed. The numbers are not what I expected...")
    except ValueError:
        explode("Phase 2 failed. Invalid number format.")

    print("Phase 2 defused successfully!")

def phase_3(user_input):
    correct_password = "encrypted_password"
    key = 5

    encrypted_input = "".join([chr(ord(c) + key) for c in user_input.strip()])

    if encrypted_input != correct_password:
        explode("Phase 3 failed. Incorrect password.")

    print("Phase 3 defused successfully!")

def main():
    print("Welcome to the Python Bomb Challenge.")
    print("Each phase requires a specific input to defuse it.")

    # Phase 1
    user_input = input("Phase 1: Enter the defusal code: ")
    phase_1(user_input)

    # Phase 2
    user_input = input("Phase 2: Enter the 3 magic numbers: ")
    phase_2(user_input)

    # Phase 3
    user_input = input("Phase 3: Enter the secret password: ")
    phase_3(user_input)

    print("\nCongratulations! You have defused the bomb!")

if __name__ == "__main__":
    # The `if __name__ == "__main__":` block is a classic entry point.
    # To make this a "hackable" challenge, you would provide the **compiled bytecode**
    # or a packaged executable, not the source code.
    main()
