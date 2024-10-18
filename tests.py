import unittest
import subprocess

class TestRomanNumeralDecoder(unittest.TestCase):
    
    def run_roman(self, numeral):
        """Helper function to run the ./roman program with a given numeral."""
        result = subprocess.run(['./roman', numeral], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return result.stdout.decode('utf-8').strip(), result.stderr.decode('utf-8').strip()

    def test_valid_roman_numerals(self):
        """Test valid Roman numerals with correct output."""
        test_cases = {
            'I': '1',
            'II': '2',
            'III': '3',
            'IV': '4',
            'V': '5',
            'VI': '6',
            'IX': '9',
            'X': '10',
            'XL': '40',
            'L': '50',
            'XC': '90',
            'C': '100',
            'CD': '400',
            'D': '500',
            'CM': '900',
            'M': '1000',
            'MM': '2000',
            'MMM': '3000',
            'MMMCMXCIX': '3999'
        }
        
        for roman, expected in test_cases.items():
            with self.subTest(roman=roman):
                output, error = self.run_roman(roman)
                self.assertEqual(output, expected)
                self.assertEqual(error, '')  # No error should be present for valid cases

    def test_invalid_roman_numerals(self):
        """Test invalid Roman numerals with error output."""
        invalid_cases = [
            'IIII',     # More than 3 I's
            'VV',       # Repetition of V
            'XXXX',     # More than 3 X's
            'LL',       # Repetition of L
            'CCCC',     # More than 3 C's
            'DD',       # Repetition of D
            'MMMM',     # More than 3 M's
            'IC',       # Invalid subtractive combination
            'IL',       # Invalid subtractive combination
            'VX',       # Invalid numeral sequence
            'IIIIII',   # Excessive repetition
            'MXD',      # Invalid combination
            'A'        # Non-Roman numeral character

        ]
        
        for roman in invalid_cases:
            with self.subTest(roman=roman):
                output, error = self.run_roman(roman)
                self.assertEqual(output, '')  # No output should be present for invalid cases
                self.assertIn('Error', error)  # Error message should be present

    def test_edge_cases(self):
        """Test edge cases for Roman numeral input."""
        edge_cases = {
            'I': '1',
            'MMMCMXCIX': '3999',
            'CMXC': '990',
            'XLIV': '44',
            'MCMXCIV': '1994'
        }

        for roman, expected in edge_cases.items():
            with self.subTest(roman=roman):
                output, error = self.run_roman(roman)
                self.assertEqual(output, expected)
                self.assertEqual(error, '')  # No error should be present for valid cases

if __name__ == '__main__':
    unittest.main()
