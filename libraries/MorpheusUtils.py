# Python built-in modules
import random

# Python third-party modules
from robot.api.deco import keyword


class MorpheusUtils:
    @keyword('Generate Random Integer From "${start}" To "${end}" That Is Not Equal To "${value}"')
    def generate_random_integer_with_exception(self, start: int, end: int, value: int) -> int:
        """Returns an integer within specified range but not equal to a specified value."""
        random_integer = random.randint(start, end)

        while random_integer == value:
            random_integer = random.randint(start, end)

        return random_integer
