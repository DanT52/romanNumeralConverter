import subprocess
import json

def lambda_handler(event, context):
    # Validate the input
    roman = event.get("roman")
    if not roman:
        return {
            "error": "Invalid input or missing key"
        }
    
    try:
        # Call the compiled C program
        process = subprocess.run(
            ['./roman', roman],
            text=True,
            capture_output=True,
            check=False
        )
        
        # Check for errors in the program
        if process.returncode != 0:
            return {
                "error": process.stderr.strip() or "An unknown error occurred"
            }
        
        # Parse the output
        result = process.stdout.strip()
        return {
            "result": int(result)
        }
    except Exception as e:
        return {
            "error": f"Failed to execute program: {str(e)}"
        }
