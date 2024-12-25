import subprocess
import json

def lambda_handler(event, context):
    try:
        # Parse the body of the request (API Gateway sends it as a JSON string)
        body = json.loads(event.get("body", "{}"))
        roman = body.get("roman")
        
        if not roman:
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "Invalid input or missing key"})
            }

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
                "statusCode": 500,
                "body": json.dumps({"error": process.stderr.strip() or "An unknown error occurred"})
            }

        # Parse the output
        result = process.stdout.strip()
        return {
            "statusCode": 200,
            "body": json.dumps({"result": int(result)})
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": f"Failed to execute program: {str(e)}"})
        }
