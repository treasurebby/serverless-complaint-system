import json

def lambda_handler(event, context):
    body = json.loads(event['body'])
    complaint_id = 123 #placeholder, normally saved in db
    response = {
        "status" : "submitted",
        "complaint_id" : complaint_id
    }
    return {
        "statuscode" : 200,
        "body" : json.dumps(response)
    }