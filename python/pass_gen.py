from password_generator import PasswordGenerator

# docs
# https://pypi.org/project/random-password-generator/

def pass_gen():
  pwo = PasswordGenerator()
  key = pwo.non_duplicate_password(20)
  print("generated pass:", key)

def pass_gen_exclusion():
  pwo = PasswordGenerator()
  pwo.excludeschars = "-$~@:.+-&= "  # (Optional)
  key = pwo.non_duplicate_password(20)
  print("generated pass with some chars exclusion:", key)

pass_gen()
pass_gen_exclusion()


#  Passwords must contain at least one of each of these items:
#  lowercase letters (a-z), uppercase letters (A-Z) and digits (0-9).
#  Some symbols, such as ~ @ : . + - < & and spaces, are not allowed.
#  Passwords must be between 5 and 20 characters.