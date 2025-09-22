import json
import uuid
import boto3
from datetime import datetime

dynamodb = boto3.resoource("dynamodb")
table = dynamodb.Table("Complaints")

def lambda_handler(event, context):
    try:
        body = json.load(event.get("body", "{}"))

        if not body.get("userId") or not body.get("description"):
            return {
                "statuscode": 400,
                "body" : json.dumps({"error": userId and descriptions are required})   
            }   
        
        complaint_id = str(uuid.uuid4())

        item = {
            "complaintId": complaint_id,
            "userId" : body["userId"],
            "description": body["description"],
            "status": "NEW",
            "createdAt": datetime.utcnow().isoformat()
        }

        table.put_item(Item=item)
        
        return {
            "statuscode": 201,
            "body" : json.dumps({"message": "complaint submitted", "complaintId": complaint_id})

        }
    
    except Exception as e:
        return{"statuscode": 500,
               "body": json.dumps({"error": str(e)})}